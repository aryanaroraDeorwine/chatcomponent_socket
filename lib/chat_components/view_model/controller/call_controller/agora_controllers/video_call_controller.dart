import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../model/chatHelper/chat_helper.dart';
import '../../../../model/chat_arguments/chat_arguments.dart';
import '../../../../model/function_helper/debounce_function.dart';
import '../../../../model/models/call_model/call_model.dart';
import '../../../../model/models/user_model/user_model.dart';
import '../../../../model/network_services/firebase_database.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';

class VideoCallController extends GetxController {
  /// agora engine variable
  RtcEngine agoraRtcEngine = createAgoraRtcEngine();

  /// user details variable
  Rx<Users> currentUser = Users().obs;
  Rx<Users> user = Users().obs;


  RxBool localUserJoined = false.obs;
  int localUserId = 0;
  RxInt remoteUid = 0.obs;

  /// timer variables
  late Timer timer;
  RxInt start = 0.obs;

  /// call details
  CallModel callDetails = CallModel();
  RxBool isMicOn = true.obs;
  RxBool isSpeakerOn = true.obs;
  RxBool isUserMicOn = true.obs;
  RxBool isVideoOn = true.obs;
  RxBool isUserVideoOn = true.obs;

  /// firebase function class variable
  var firebase = FirebaseDataBase();

  /// call refernce vairable
  Stream<DocumentSnapshot<Map<String, dynamic>>>? streamRef;


  /// call agruments
  late CallArguments callArguments;


  /// start timer for display on screen to users
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        start++;
      },
    );
  }

  /// setup agora engine for video call
  Future<void> setupAgoraEngine() async {
    agoraRtcEngine = createAgoraRtcEngine();
    await agoraRtcEngine.initialize(RtcEngineContext(
        appId: callArguments.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    agoraRtcEngine.registerEventHandler(getEventHandler());
    await agoraRtcEngine.setClientRole(
        role: ClientRoleType.clientRoleBroadcaster);
    await agoraRtcEngine.enableVideo();
    await agoraRtcEngine.enableAudio();
    await agoraRtcEngine.startPreview();
  }

  /// on off mic function on click
  void onMicTap() {
    if (isMicOn.isTrue) {
      isMicOn.value = false;
      agoraRtcEngine.enableLocalAudio(false);
    } else {
      isMicOn.value = true;
      agoraRtcEngine.enableLocalAudio(true);
    }
  }

  /// video on off  function click
  void onVideoTap() {
    if (isVideoOn.isTrue) {
      isVideoOn.value = false;
      agoraRtcEngine.enableLocalVideo(false);
    } else {
      isVideoOn.value = true;
      agoraRtcEngine.enableLocalVideo(true);
    }
  }


  /// speaker on off on click
  void onSpeakerTap() {
    if (isSpeakerOn.isTrue) {
      isSpeakerOn.value = false;
      agoraRtcEngine.muteAllRemoteAudioStreams(true);
    } else {
      isSpeakerOn.value = true;
      agoraRtcEngine.muteAllRemoteAudioStreams(false);
    }
  }

  /// rtc event handle r function for call join and exit details
  RtcEngineEventHandler getEventHandler() {
    return RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      logPrint("local user ${connection.localUid} joined");
      localUserJoined.value = true;
    }, onUserJoined: (RtcConnection connection, int uid, int elapsed) {
      logPrint("remote user $remoteUid joined");
      startTimer();
      remoteUid.value = uid;
    }, onUserOffline:
            (RtcConnection connection, int uid, UserOfflineReasonType reason) {
      logPrint("remote user $remoteUid left channel");
      remoteUid.value = 0;
    }, onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
      logPrint(
          '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
    }, onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
      logPrint("remote user $remoteUid , $muted muted the audio");
      isUserMicOn.value = muted;
    }, onUserMuteVideo: (RtcConnection connection, int remoteUid, bool muted) {
      logPrint("remote user $remoteUid , $muted muted the video ");
      isUserVideoOn.value = muted;
    });
  }

  /// initalize agora method
  Future<void> agoraInit() async {
    try {
      await [Permission.microphone, Permission.camera].request();
      await setupAgoraEngine();
      await agoraRtcEngine.isSpeakerphoneEnabled();
      logPrint("tokens is");
      logPrint(callArguments.agoraToken);
      await agoraRtcEngine.joinChannel(
          options: const ChannelMediaOptions(),
          token: callArguments.agoraToken,
          channelId: callArguments.agoraChannelName,
          uid: 0);
    } catch (e) {
      logPrint("error agora room : $e");
    }
  }

  /// init method
  @override
  Future<void> onInit() async {
    /// get all details form arguments for call
    callArguments = Get.arguments;

    user.value = callArguments.user;

    currentUser.value = callArguments.currentUser;


    isMicOn.value = callArguments.isMicOn??false;

    /// call fetch call details method
    fetchCallDetails();
    /// call agora initalize method
    agoraInit();
    super.onInit();
  }




/// fetch call details
  fetchCallDetails() async {
    try{
      streamRef = firebase.callReferenceById(callArguments.callId).snapshots();
      DocumentReference<Map<String, dynamic>> reference = firebase.callReferenceById(callArguments.callId);
      await reference.get().then((value) async {
        callDetails = CallModel.fromJson(value.data()??{});
      });
      await streamListener();
      logPrint(callDetails.callStatus);
      callDetails.callStatus = CallStatus.running.name;
      firebase.updateCallStatus(callDetails);
    }catch(e){
      logPrint("Error fetch call details : $e");
    }
  }

  /// call refrence listner
  Future<void> streamListener() async {
    streamRef?.listen((event) {
      logPrint("event ");
      callDetails = CallModel.fromJson(event.data() ?? {});
      if (callDetails.callStatus == CallStatus.ended.name) {
        endCall(false);
        DebounceHelper.instance.debounceFunction(onDebounceCall: () => Get.back(), duration: const Duration(milliseconds: 500));
      }
    });
  }

  /// close/ destroy video call controller and screen
  @override
  void onClose() {
    logPrint(" close dispose");
    super.onClose();
  }

  /// end call for click o end call
  Future<void> endCall(bool isClose) async {
    await agoraRtcEngine.leaveChannel();
    await agoraRtcEngine.release();
    if(callDetails.callStatus != CallStatus.ended.name){
      callDetails.callTimeOn = start.toString();
      callDetails.callStatus = CallStatus.ended.name;
      logPrint(callDetails.callStatus);
      logPrint(callDetails.callId);
      await firebase.updateCallStatus(callDetails);
    }
  }
}
