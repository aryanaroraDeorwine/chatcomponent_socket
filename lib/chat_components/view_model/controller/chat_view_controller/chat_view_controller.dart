import 'package:chat_component/chat_components/model/network_services/networking/base_model/base_model.dart';
import 'package:chat_component/chat_components/model/network_services/networking/repo/api_repo.dart';
import 'package:chat_component/chat_components/model/network_services/networking/result/language_extensions.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../model/chatHelper/chat_helper.dart';
import '../../../model/chat_arguments/chat_arguments.dart';
import '../../../model/firebase_notification/firebase_notification.dart';
import '../../../model/function_helper/downlaod_helper.dart';
import '../../../model/function_helper/get_image_function.dart';
import '../../../model/models/call_model/call_model.dart';
import '../../../model/models/chat_model/chat_model.dart';
import '../../../model/models/message_model/message_model.dart';
import '../../../model/models/picker_file_modal/picker_file_modal.dart';
import '../../../model/models/user_model/user_model.dart';
import '../../../model/network_services/firebase_database.dart';
import '../../../model/network_services/networking/result/apiresult.dart';
import '../../../model/randomkey/randomkey.dart';
import '../../../model/services/chat_services.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/toast_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatViewController extends GetxController with WidgetsBindingObserver{

  /// emojis list for reaction
  List<String> emoji = Get.find<ChatServices>().chatArguments.reactionsEmojisIcons ?? ["❤️", "😀", "😁", "😎", "👆"];

  /// initial index for reaction list when display in chats
  RxInt reactionIndex = 7.obs;

  ApiRepo apiRepo = GetIt.instance();

  /// select index for reaction list
  RxString selectReactionIndex = "".obs;

  /// messages box textfeild controller
  TextEditingController messageController = TextEditingController();

  /// scrolling controller for message list view
  ScrollController scrollController = ScrollController();

  /// textfeild focus
  FocusNode messageFocus = FocusNode();

  /// user details current and other user
  Rx<Users> users = Users().obs;
  Rx<Users> currentUser = Users().obs;

  /// chat room details
  Rx<ChatRoomModel> chatRoomModel = ChatRoomModel().obs;
  RxBool isFirstUser = false.obs;
  RxBool isFirstCurrent = false.obs;
  RxBool isUserId = false.obs;
  RxBool isReaction = false.obs;

  RxBool isWizardWidgetGet = false.obs;

  /// message model list
  RxList<MessageModel> messages = <MessageModel>[].obs;
  List<MessageModel> oldMessages = <MessageModel>[];
  RxInt pageNo = 0.obs;

  /// permissions for camera and photos
  RxBool isPermissionCameraGranted = false.obs;
  RxBool isPermissionPhotosGranted = false.obs;

  /// image file variable
  Rx<File> image = File('').obs;

  /// typing status
  RxBool userTypingStatus = false.obs;

  /// firebase functions file import
  var firebase = FirebaseDataBase();

  /// firebase notification file import
  var firebaseNotification = FirebaseNotification();

  /// message , typing , active status , presence listner
  StreamSubscription<QuerySnapshot>? messageListener;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? typingListener;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?activeStatusListener;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? presenceListener;

  /// loading values
  RxBool isLoadingPreviousChats = true.obs;
  RxBool isError = false.obs;
  RxBool isLoadingChats = true.obs;
  RxBool isScreenOn = false.obs;
  RxBool isDownloadingStart = false.obs;
  RxBool isAudioRecorderStart = false.obs;

  /// dailog open boolean value
  RxBool isDialogOpen = false.obs;

  /// chat room reference variable
  DocumentReference<Map<String, dynamic>>? reference;

  /// chip messages list text
  List<String> suggestions = Get.find<ChatServices>().chatArguments.suggestionsMessages ?? <String>[
            'Hii',
            "Hello",
            'Hey there',
            'how are you',
            'What are you doing',
            "What's up"
          ];

  RxList<PickerFileModal> imageList = <PickerFileModal>[].obs;
  RxList<TextEditingController> imageMessageControllerList = <TextEditingController>[].obs;

  RecorderController recorderController = RecorderController();


  /// arguments get
  late ChatArguments chatArguments;
  ImageArguments? imageArguments;
  ThemeArguments? themeArguments;
  RxString chatRoomID = "".obs;
  RxString currentUserId = "".obs;
  RxString otherUserId = "".obs;
  RxString agoraChannelName = "".obs;
  RxString agoraToken = "".obs;


  /// open attachments dialog from  message box(textfield)
  void openDialog() {
    if (isDialogOpen.isTrue) {
      isDialogOpen.value = false;
      isAudioRecorderStart.isTrue ? stopRecorder(false) : null;
      isAudioRecorderStart.isTrue ? isAudioRecorderStart.value = false : null;
    } else {
      isDialogOpen.value = true;
    }
  }

  void onScreenTap() {
    selectReactionIndex.value = "";
    isReaction.value = false;
    isDialogOpen.value = false;
  }


  /// send messages form message box( text field ) and updating message chatroom and messages list
  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      Message message = Message(
          text: messageController.text,
          messageType: MessageType.text.name,
      );
      messageController.clear();

      try {
        socket?.emit('message', {
          "load_id": "e3a7aa70-b20d-4b97-a3cd-5617b23e2d9c",
          "current_user_id":currentUserId.value,
          "app_type": chatArguments.appType,
          "message": message.toJson()
        }
        ..addIf(messages.isNotEmpty || chatRoomID.value.isNotEmpty, "chat_id", chatRoomID.value)
        ..addIf(messages.isEmpty && chatArguments.appType == "carrier" && chatRoomID.value.isEmpty , "sent_to", otherUserId.value)
        );

        isWizardWidgetGet.call(true);

        // firebaseNotification.sendNotification("", currentUser.value, users.value.deviceToken ?? "", CallModel(), true, message, chatRoomID.value, chatArguments.firebaseServerKey, users.value, CallArguments(
        //     agoraChannelName: '',
        //     agoraToken: '',
        //     user: Users(),
        //     currentUser: Users(),
        //     callType: '',
        //     callId: '',
        //     imageBaseUrl: '',
        //     agoraAppId: '',
        //     agoraAppCertificate: '',
        //     userId: '',
        //     currentUserId: '',
        //     firebaseServerKey: chatArguments.firebaseServerKey));

      } catch (e) {
        logPrint("error messaging : $e");
      }
    } else {
      toastShow(massage: "please Enter message", error: true);
    }
  }

  void addReaction(int index, int messageIndex) {
    try {
      isReaction.value = isReaction.value;
      messages[messageIndex].message?.reaction = index;
      selectReactionIndex.value = "";
      logPrint("select value is : ${selectReactionIndex.value} , ${messages[messageIndex].message?.reaction}");
    } catch (e) {
      logPrint("error in updating reactions : $e ");
    }
  }


  /// chip message send update message chatroom and messages list
  Future<void> chipMessage(int index) async {
    String id = getRandomString();
    Message message = Message(
        id: id,
        text: suggestions[index],
        messageType: MessageType.text.name,
        sender: currentUserId.value,
        isSeen: false,
        time: DateTime.now().toUtc().toString());

    messageController.clear();

    firebaseNotification.sendNotification("", currentUser.value, users.value.deviceToken ?? "", CallModel(), true, message, chatRoomID.value, chatArguments.firebaseServerKey, users.value, CallArguments(agoraChannelName: '', agoraToken: '', user: Users(), currentUser: Users(), callType: '', callId: '', imageBaseUrl: '', agoraAppId: '', agoraAppCertificate: '', userId: '', currentUserId: '', firebaseServerKey: ''));

  }

  /// pick up file for storage and upload in firebase storage and send in chats
  void pickFile() async {
    /// pick up file for storage
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    isDialogOpen.value = false;
    /// genrate id
    if (result == null)
    {
      logPrint("file not found ");
    }
    else {
      try {
        // MessageModel loadingMessage = MessageModel(id: id,file: Files(fileName: result.files.first.name, fileMimeType: result.files.first.extension, fileType: FileTypes.document.name, fileUrl: result.files.first.path,isAdding: false), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
        // messages.add(loadingMessage);
        //
        // /// upload file in firebase storage
        // String? url = await firebase.addChatFiles(id, result.files.first.path!);
        //
        // List storagePath = url!.split(chatArguments.imageBaseUrl);
        //
        // messageController.clear();
        //
        // /// update chatroom and message list
        // MessageModel message = MessageModel(id: id, file: Files(fileName: result.files.first.name, fileMimeType: result.files.first.extension, fileType: FileTypes.document.name, fileUrl: storagePath[1],isAdding: true), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
        // ChatRoomModel chatRoomModel = addChatRoomModel(message);
        //
        // firebase.addMessage(message, chatRoomModel);
        // firebaseNotification.sendNotification("", currentUser.value, users.value.deviceToken ?? "", CallModel(), true, message, chatRoomModel.chatRoomId, chatArguments.firebaseServerKey, users.value, CallArguments(agoraChannelName: '', agoraToken: '', user: Users(), currentUser: Users(), callType: '', callId: '', imageBaseUrl: '', agoraAppId: '', agoraAppCertificate: '', userId: '', currentUserId: '', firebaseServerKey: ''));
        //
        // final index = messages.indexWhere((element) => element.id == message.id);
        // messages[index] = message;
        // messageController.clear();
        //
        // if (otherUserId.value != ChatHelpers.instance.userId) {
        //   await chatroomUpdates();
        // }
      } catch (e) {
        // final index = messages.indexWhere((element) => element.id == id);
        // messages.removeAt(index);
        toastShow(massage: "Error sending document", error: true);
      }
    }
  }

  /// pick photo form gallery send photo in chats function
  Future<void> photoPermission() async {
    PermissionStatus photosStatus = await Permission.photos.status;
    isDialogOpen.value = false;
    if (photosStatus.isGranted) {
      isPermissionPhotosGranted.value = true;
      /// image picker
      image.value = (await GetImageHelper.instance.getImage(2)) ?? File("");

      if (image.value.path != "") {

        Get.toNamed(ChatHelpers.cameraScreen,arguments: image.value)?.
        then((value) async {
          logPrint("Image get form back : ${value.toString()}");
          imageList.value = value["ImageList"];
          imageMessageControllerList.value = value["textMessageList"];

          logPrint("List of image and text : ${imageList.length} ${imageList.toString()} , ${imageMessageControllerList.toString()}");

          if(imageList.isNotEmpty) {
            await uploadListImages();
          }

        });

      }
    } else {
      Permission.photos.request();
    }
  }

  /// update typing status in chatroom
  void typingStatus(bool status) {
    firebase.userTypingStatus(chatRoomID.value, status, currentUserId.value);
  }

  /// read all messages of chat room
  Future<void> updateChats() async {
    try {
      logPrint("api called ");
      chatRoomID.value.isNotEmpty ?
      await apiRepo.getMessagesList(chatRoomId: chatRoomID.value,messagesBody: {
        "page_number":"1",
        "page_size":"20",
        "sort_by":"created_at",
        "sort_order":"asc"
      }).mapSuccess((value, msg) {
        PagedDataMessages<List<MessageModel>> pagedDataMessages = value;
        messages.value = pagedDataMessages.data ?? [];
        oldMessages = pagedDataMessages.data ?? [];
        logPrint("vlaue it this is : ${checkImagesGrouping(messagesList: oldMessages)}");
        chatRoomID.value = messages.first.id.toString();
        pageNo.call(pagedDataMessages.currentPage);
        return ApiResult.success(data: value, message: msg);
      }).mapFailure((failure) async {
        return ApiResult.failure(failure: failure);
      }) : null;
      return ;
    } catch (e) {
      logPrint("error message fetch : $e");
    }
  }


  /// updating reading typing pressence in chatroom
  Future<void> readingTypingPresence() async {
    try {
      // DocumentReference<Map<String, dynamic>>? typingPresence =
      // await firebase.readTypingStatus(chatRoomID.value);
      // typingListener = typingPresence!.snapshots().listen((event) async {
      //   if (event.exists) {
      //     ChatRoomModel chatRoomModel =
      //     ChatRoomModel.fromJson(event.data() ?? {});
      //     if (chatRoomModel.userFirstId == currentUserId.value) {
      //       userTypingStatus.value =
      //           chatRoomModel.userSecond?.userTypingStatus ?? false;
      //     } else {
      //       userTypingStatus.value =
      //           chatRoomModel.userFirst?.userTypingStatus ?? false;
      //     }
      //   }
      // });
    } catch (e) {
      logPrint("error update presence => $e");
    }
  }

  void readPresence() async {
    try {
      // DocumentReference<Map<String, dynamic>> presenceReference =
      // await firebase.readPresence(users.value.id ?? "");
      // presenceListener = presenceReference.snapshots().listen((event) async {
      //   users.value = Users.fromJson(event.data() ?? <String, dynamic>{});
      // });
    } catch (e) {
      logPrint("error update presence => $e");
    }
  }

  void updatePresence(String presence) {
    // firebase.updatePresence(presence, currentUserId.value);
  }

  /// destroy or close method controller
  @override
  Future<void> onClose() async {
    isScreenOn.value = false;

    scrollController.dispose();
    messageListener?.cancel();
    typingListener?.cancel();
    presenceListener?.cancel();
    activeStatusListener?.cancel();


    super.onClose();
  }

  /// init method
  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    initServices();
    super.onInit();
  }

  Future<void> goToCameraScreen() async {
    Get.toNamed(ChatHelpers.cameraScreen,arguments: File(""))?.
    then((value) async {
      logPrint("Image get form back : ${value.toString()}");
      imageList.value = value["ImageList"] ?? [];
      imageMessageControllerList.value = value["textMessageList"];

      logPrint("List of image and text : ${imageList.length} ${imageList.toString()} , ${imageMessageControllerList.toString()}");

      if(imageList.isNotEmpty) {
        await uploadListImages();
      }

    });
  }

  Future<void> uploadListImages() async {
    try{
      selectReactionIndex.value = "";
      isReaction.value = false;
      isDialogOpen.value = false;
      for (int counter = 0; counter < imageList.length; counter++){

        File cameraImage = imageList[counter].file ?? File("");
        getRandomString();
        if (cameraImage != File("")) {
          try {
            // String fileName = cameraImage.path.split('/').last;
            //
            // /// get file extension of a file
            // String fileExt = getFileExtension(fileName)!;
            //
            // String thumbnail = await getVideoThumbnail(imageList[counter].file?.path ?? "");
            //
            //
            // MessageModel loadingMessage = MessageModel(id: id,text: imageMessage.text,file: Files(fileName: fileName, fileMimeType: fileExt, fileType: imageList[counter].isVideo ?? false ? FileTypes.video.name : FileTypes.image.name , fileUrl: cameraImage.path,fileImageThumbnail: imageList[counter].isVideo ?? false ? thumbnail : "", isAdding:false), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
            // messages.add(loadingMessage);
            //
            // /// add image in firebase storage
            // String? url = await firebase.addChatFiles(id, cameraImage.path);
            // String? thumbnailUrl = await firebase.addChatFiles("$id+thumbnail", thumbnail);
            //
            // logPrint("url : - $url , ${imageMessage.text} , $thumbnailUrl");
            //
            // List storagePath = url!.split(chatArguments.imageBaseUrl);
            // List thumbnailStoragePath = thumbnailUrl!.split(chatArguments.imageBaseUrl);
            //
            // /// update chatroom and messages list
            // logPrint("url : - $url , ${imageMessage.text} , ${storagePath[1]}");
            // MessageModel message = MessageModel(id: id,message: imageMessage.text, file: Files(fileName: fileName, fileMimeType: fileExt, fileType: imageList[counter].isVideo ?? false ? FileTypes.video.name : FileTypes.image.name, fileUrl: storagePath[1],isAdding:true, fileImageThumbnail: imageList[counter].isVideo ?? false ? thumbnailStoragePath[1] : ""), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
            //
            // ChatRoomModel chatRoomModel = addChatRoomModel(message);
            // firebase.addMessage(message, chatRoomModel);
            // final index = messages.indexWhere((element) => element.id == message.id);
            // messages[index] = message;
            // File file = File(cameraImage.path);
            // await file.delete(recursive: true);
            //
            // firebaseNotification.sendNotification("", currentUser.value, users.value.deviceToken ?? "", CallModel(), true, message, chatRoomModel.chatRoomId, chatArguments.firebaseServerKey, users.value, CallArguments(agoraChannelName: '', agoraToken: '', user: Users(), currentUser: Users(), callType: '', callId: '', imageBaseUrl: '', agoraAppId: '', agoraAppCertificate: '', userId: '', currentUserId: '', firebaseServerKey: ''));
            //
            // if (otherUserId.value != ChatHelpers.instance.userId) {
            //   await chatroomUpdates();
            // }
          } catch (e) {
            // final index = messages.indexWhere((element) => element.id == id);
            // messages.removeAt(index);
            toastShow(massage: "Error sending image", error: true);
          }
        }

      }
    }catch(e){
      logPrint("Error uploading images ing : $e");
      toastShow(massage: "Error uploading images", error: true);
    }
  }

  Future<String> getVideoThumbnail(String url) async {
    try{
      final uint8list = await VideoThumbnail.thumbnailData(
        video: url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );
      Permission.storage.isGranted;
      var tempDir = await getExternalStorageDirectory();
      final imagePath = await File('${tempDir?.path}/image.png').create();
      await imagePath.writeAsBytes(uint8list??[]);
      logPrint("vidoe file thumbnail : ${imagePath.path} $uint8list , ${uint8list.runtimeType}");
      return imagePath.path;
    }catch(e){
      logPrint("error in video thumbnail fetching : $e}");
      return "";
    }
    // return uint8list ?? "";
  }

  /// app life cycle  state manage with online status
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
            isFirstUser.call, currentUserId.value);
        updatePresence(PresenceStatus.offline.name);
      case AppLifecycleState.resumed:
        firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
            isFirstUser.call, currentUserId.value);
        updatePresence(PresenceStatus.online.name);
      case AppLifecycleState.paused:
        firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
            isFirstUser.call, currentUserId.value);
        updatePresence(PresenceStatus.offline.name);
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
  }

  ///  chat room updates all functions of chatroom call here
  Future<void> chatroomUpdates() async {
    /// fetch chat room detail
    chatRoomModel.value = await firebase.fetchChatRoom(chatRoomID.value);

    /// chatroom reference
    reference = await firebase.userActiveChatroomReference(chatRoomID.value);

    /// call fetch all messages
    updateChats();

    scrollerListener();

    /// update user prescnse in app
    readPresence();
  }

  /// update active status of users if he is online in chat room
  Future<void> updateActiveStatus() async {
    try {
      // activeStatusListener = reference!.snapshots().listen((event) {
      //   if (event.exists) {
      //     chatRoomModel.value = ChatRoomModel.fromJson(event.data() ?? {});
      //     return;
      //   } else {
      //     return;
      //   }
      // });
    } catch (e) {
      logPrint("error updating active status :$e");
    }
  }

  downloadFileFromServer(int index) async {
    isDownloadingStart.value = true;

    try {
      DownloadHelper().createFolderAndDownloadFile(
          url: chatArguments.imageBaseUrl + (messages[index].message?.file ?? ""),
          fileName: messages[index].message?.file?.split("/").last ?? "",
          onSuccess: () {
            isDownloadingStart.value = false;
          },
          onError: () {
            isDownloadingStart.value = false;
          });
    } catch (e) {
      logPrint("error downloading file : $e");
      isDownloadingStart.value = false;
    }
  }

  void scrollerListener(){
    scrollController.addListener(() async {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if(oldMessages.isNotEmpty){
        if (maxScroll == currentScroll) {
          try {
            oldMessages.clear();
            isLoadingPreviousChats.value = false;
            pageNo++;
            await apiRepo.getMessagesList(chatRoomId: chatRoomID.value,messagesBody: {
              "page_number":pageNo.value.toString(),
              "page_size":"20",
              "sort_by":"created_at",
              "sort_order":"asc"
            }).mapSuccess((value, msg) {
              PagedDataMessages<List<MessageModel>> pagedDataMessages = value;
              messages.addAll(pagedDataMessages.data ?? []);
              oldMessages.addAll(pagedDataMessages.data ?? []);
              chatRoomID.value = messages.first.id.toString();
              pageNo.call(pagedDataMessages.currentPage);
              return ApiResult.success(data: value, message: msg);
            }).mapFailure((failure) async {
              return ApiResult.failure(failure: failure);
            });
            isLoadingPreviousChats.value = true;
          } catch (e) {
            isLoadingPreviousChats.value = true;
            logPrint("error message fetch : $e");
          }
        }
      }
    });
  }

  IO.Socket? socket;

  void socketConnect()async{

    socket = IO.io(chatArguments.socketBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'forceNew':true,
      'autoConnect': false,
      'extraHeaders': {'Authorization': "Bearer ${chatArguments.userToken}",}
    });
    logPrint("AppConstants.socket : ${socket!.opts}");
    socket?.disconnect().connect();
    socket?.onConnect((_) {
      logPrint('connected to websocket ${chatArguments.userToken}');
    });

    socket!.on('message', (messageDataFromEvent) {
      logPrint("receive data $messageDataFromEvent");
      logPrint("receive data ${messageDataFromEvent.runtimeType}");
      try{
        SocketReceiveModel socketReceiveModel = SocketReceiveModel.fromJson(messageDataFromEvent);
        logPrint("time is : ${socketReceiveModel.data?.createdAt}");
        messages.add(socketReceiveModel.data ?? MessageModel());
        chatRoomID.value = messages.first.id.toString();
        logPrint("vlaue it this is : ${checkImagesGrouping(messagesList: messages)}");
        // if(messageDataFromEvent["status"]==true && messageDataFromEvent["data"]["chat_id"].toString()==chatId.value.toString()){
        //   try{
        //     Message message =  Message.fromJson(messageDataFromEvent["data"]);
        //     messageList.insert(0,message);
        //   }catch(e){
        //     print("chat add $e");
        //   }
        // }
      }catch(e){
        logPrint("error recive message : $e");
      }
    });
  }



  /// call in init method
  Future<void> initServices() async {
    /// get all details with arguments
    chatArguments = Get.find<ChatServices>().chatArguments;
    imageArguments = chatArguments.imageArguments;
    themeArguments = chatArguments.themeArguments;

    if(Get.arguments != null){
      if ((Get.arguments[ChatHelpers.instance.currentUserID] == "" &&
          Get.arguments[ChatHelpers.instance.otherUserID] == "")) {
        isError.value = true;
        isLoadingChats.value = false;
      }
      else {
        currentUserId.value = Get.arguments[ChatHelpers.instance.currentUserID];
        Get.arguments[ChatHelpers.instance.chatRoomId] != null ? chatRoomID.value = Get.arguments[ChatHelpers.instance.chatRoomId] : null;
        agoraToken.value = Get.arguments[ChatHelpers.instance.agoraToken];
        otherUserId.value = Get.arguments[ChatHelpers.instance.otherUserID];
        agoraChannelName.value = Get.arguments[ChatHelpers.instance.agoraChannelName];

        logPrint("chat room id : ${chatRoomID.value}");
        
        isScreenOn.value = true;

       try{
         socketConnect();
         chatRoomID.value.isNotEmpty ? await updateChats() : null;
         scrollerListener();
         var list = checkImagesGrouping(messagesList: messages);
         logPrint("values in list changes : $list");
       }catch(e){
         logPrint("error in socket connection : $e");
       }
        isLoadingChats.value = false;
      }
    }
    else{
      isError.value = true;
      isLoadingChats.value = false;
    }
  }


  onAudioCallTap(){
    (chatArguments.agoraAppId
        ?.isNotEmpty ?? false) &&
        agoraChannelName.isNotEmpty
        ? Get
        .toNamed(ChatHelpers.outGoingScreen,
        arguments: CallArguments(
            user: users.value,
            callType: CallType.audioCall.name,
            callId: "",
            imageBaseUrl:chatArguments
                .imageBaseUrl,
            agoraAppId: chatArguments.agoraAppId ?? "",
            agoraAppCertificate: chatArguments.agoraAppCertificate ?? "",
            userId: users.value.id ?? "",
            currentUserId: currentUser.value.id ?? "",
            firebaseServerKey: chatArguments.firebaseServerKey,
            currentUser: currentUser.value,
            agoraChannelName: agoraChannelName.value,
            agoraToken: agoraToken.value,
            themeArguments: themeArguments))
        : toastShow(
        massage: "Please give agora Details to use this ",
        error: true);
  }

  onVideoTap(){
    (chatArguments.agoraAppId
        ?.isNotEmpty ?? false) &&
        agoraChannelName.isNotEmpty
        ? Get
        .toNamed(ChatHelpers.outGoingScreen,
        arguments: CallArguments(
            user: users.value,
            callType: CallType.videoCall.name,
            callId: "",
            imageBaseUrl: chatArguments.imageBaseUrl,
            agoraAppId: chatArguments.agoraAppId ?? "",
            agoraAppCertificate: chatArguments.agoraAppCertificate ?? "",
            userId: users.value.id ?? "",
            currentUserId: currentUser.value.id ?? "",
            firebaseServerKey: chatArguments.firebaseServerKey,
            currentUser: currentUser.value,
            agoraChannelName: agoraChannelName.value,
            agoraToken: agoraToken.value,
            themeArguments: themeArguments))
        : toastShow(
        massage: "Please give agora Details to use this ",
        error: true);
  }


  /// for audio record
  Future<void> record() async {
    try{
      final hasPermission = await recorderController.checkPermission();  // Check mic permission (also called during record)
      if(hasPermission){
        recorderController = RecorderController()
          ..androidEncoder = AndroidEncoder.aac
          ..androidOutputFormat = AndroidOutputFormat.mpeg4
          ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
          ..sampleRate = 16000;
        isAudioRecorderStart.value = true;
        await recorderController.record();
      }else{
        PermissionStatus status = await Permission.microphone.request();
        if(status.isGranted){
          recorderController = RecorderController();
          isAudioRecorderStart.value = true;
          await recorderController.record();
        }else{
          toastShow(massage: "Please allow microphone permission to record", error: true);
        }
      }
    }catch(e){
      logPrint("error in starting record file : $e");
    }
  }

  void stopRecorder(bool isStop) async {
    try{
      if(isStop) {
        final path = await recorderController.stop();
        isAudioRecorderStart.value = false;
        recorderController.refresh();
        recorderController.dispose();
        uploadAudioFile(path??"");
      }
      else{
        isAudioRecorderStart.value = false;
        recorderController.refresh();
        recorderController.dispose();
      }
    }catch(e){
      logPrint("error in stopping record file : $e");
    }
  }


  List<MessageModel> checkImagesGrouping({required List<MessageModel> messagesList}){

    for(int i =0; i < messagesList.length-1 ; i++){
      logPrint("indexs : ${messagesList[i].message?.toJson()}  , ,, ${( i+1 != messagesList.length-1 ? messagesList[i+1].message?.messageType == "image" : false)}");
      if(messagesList[i].message?.messageType == "image" && ( i+1 != messagesList.length-1 ? messagesList[i+1].message?.messageType == "image" : false)){
        messagesList[i].multiImages?.add(messagesList[i].message ?? Message());
        messagesList[i].multiImages?.add(messagesList[i+1].message ?? Message());
      }
    }
    return messagesList;
  }


  uploadAudioFile(String path) async {
    if ( path != "") {
      try {
        // File audioFile = File(path);
        // String fileName = audioFile.path.split('/').last;
        //
        // /// get file extension of a file
        // String fileExt = getFileExtension(fileName)!;
        //
        //
        // MessageModel loadingMessage = MessageModel(id: id,file: Files(fileName: fileName, fileMimeType: fileExt, fileType: FileTypes.audio.name, fileUrl: audioFile.path,isAdding:false), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
        // messages.add(loadingMessage);
        //
        // /// add image in firebase storage
        // String? url = await firebase.addChatFiles(id, audioFile.path);
        //
        // logPrint("url : - $url ");
        //
        // List storagePath = url!.split(chatArguments.imageBaseUrl);
        //
        // /// update chatroom and messages list
        // logPrint("url : - $url , ${storagePath[1]}");
        // MessageModel message = MessageModel(id: id,file: Files(fileName: fileName, fileMimeType: fileExt, fileType: FileTypes.audio.name, fileUrl: storagePath[1],isAdding:true), messageType: MessageType.file.name, sender: currentUserId.value, isSeen: false, time: DateTime.now().toUtc().toString());
        //
        // firebase.addMessage(message, chatRoomModel);
        // final index = messages.indexWhere((element) => element.id == message.id);
        // messages[index] = message;
        //
        //
        // firebaseNotification.sendNotification("", currentUser.value, users.value.deviceToken ?? "", CallModel(), true, message, chatRoomModel.chatRoomId, chatArguments.firebaseServerKey, users.value, CallArguments(agoraChannelName: '', agoraToken: '', user: Users(), currentUser: Users(), callType: '', callId: '', imageBaseUrl: '', agoraAppId: '', agoraAppCertificate: '', userId: '', currentUserId: '', firebaseServerKey: ''));
        //
        // if (otherUserId.value != ChatHelpers.instance.userId) {
        //   await chatroomUpdates();
        // }
        //
        // File file = File(audioFile.path);
        // await file.delete(recursive: true);
      } catch (e) {
        // final index = messages.indexWhere((element) => element.id == id);
        // messages.removeAt(index);
        toastShow(massage: "Error sending audio file ", error: true);
      }
    }
  }


}