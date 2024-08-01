import 'package:chat_component/chat_components/model/network_services/networking/base_model/base_model.dart';
import 'package:chat_component/chat_components/model/network_services/networking/repo/api_repo.dart';
import 'package:chat_component/chat_components/model/network_services/networking/result/language_extensions.dart';
import 'package:chat_component/chat_components/view/widgets/pagination_view/pagination_view_screen.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
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
import '../../../model/network_services/networking/result/apiresult.dart';
import '../../../model/randomkey/randomkey.dart';
import '../../../model/services/chat_services.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/toast_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;


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

  RxBool isWizardWidgetGet = true.obs;

  /// permissions for camera and photos
  RxBool isPermissionCameraGranted = false.obs;
  RxBool isPermissionPhotosGranted = false.obs;

  /// image file variable
  Rx<File> image = File('').obs;

  /// typing status
  RxBool userTypingStatus = false.obs;

  /// firebase notification file import
  var firebaseNotification = FirebaseNotification();


  /// loading values
  RxBool isLoadingPreviousChats = true.obs;
  RxBool isError = false.obs;
  RxBool isLoadingChats = true.obs;
  RxBool isScreenOn = false.obs;
  RxBool isDownloadingStart = false.obs;
  RxBool isAudioRecorderStart = false.obs;

  /// dailog open boolean value
  RxBool isDialogOpen = false.obs;

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

  PaginationViewController<MessageModel> messagesPaginationController =  PaginationViewController(
      showMessage: "No more messages found",
      totalPageCont: 0,
      onScrollDownDone: (bool value, int pageNumber) {},
      itemList: <MessageModel>[].obs);

  List<MessageModel> messagesList = <MessageModel>[];


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
        // ..addIf(messagesPaginationController.itemList.isNotEmpty || chatRoomID.value.isNotEmpty, "chat_id", chatRoomID.value)
        ..addIf(messagesPaginationController.itemList.isEmpty && chatArguments.appType == "carrier" && chatRoomID.value.isEmpty , "sent_to", otherUserId.value)
        );

        // isWizardWidgetGet.call(true);

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
      messagesPaginationController.itemList[messageIndex].message?.reaction = index;
      selectReactionIndex.value = "";
      logPrint("select value is : ${selectReactionIndex.value} , ${messagesPaginationController.itemList[messageIndex].message?.reaction}");
    } catch (e) {
      logPrint("error in updating reactions : $e ");
    }
  }


  /// chip message send update message chatroom and messagesPaginationController.itemList list
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
        // messagesPaginationController.itemList.add(loadingMessage);
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
  Future<void> photoPermission({required bool isImageWithText,required bool isVideoSendEnable}) async {
    PermissionStatus photosStatus = await Permission.photos.status;
    isDialogOpen.value = false;
    if (photosStatus.isGranted) {
      isPermissionPhotosGranted.value = true;
      /// image picker
      image.value = (await GetImageHelper.instance.getImage(2)) ?? File("");

      if (image.value.path != "") {

        Get.toNamed(ChatHelpers.cameraScreen,arguments: {
          "image":image.value,
          "isVideoSendEnable": isVideoSendEnable,
          "isImageWithText":isImageWithText
        })?.
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

  // /// update typing status in chatroom
  // void typingStatus(bool status) {
  //   firebase.userTypingStatus(chatRoomID.value, status, currentUserId.value);
  // }

  /// read all messages of chat room
  Future<void> updateChats() async {
    try {
      chatRoomID.value.isNotEmpty ?
      await apiRepo.getMessagesList(chatRoomId: chatRoomID.value,messagesBody: {
        "page_number":"1",
        "page_size":"20",
        "sort_by":"created_at",
        "sort_order":"desc"
      }).mapSuccess((value, msg) {
        PagedDataMessages<List<MessageModel>> pagedDataMessages = value;
        pagedDataMessages.data ?? [];
        messagesPaginationController.currentPage.value = pagedDataMessages.currentPage ?? 1;
        messagesPaginationController.totalPageCont = findTotalPage(totalRecord: pagedDataMessages.total ?? 20,pageSize: pagedDataMessages.pageSize ?? 20);
        messagesPaginationController.itemList.value = checkImagesGrouping(messagesList: pagedDataMessages.data?.reversed.toList() ?? []);
        messagesPaginationController.onScrollDownDone = (bool value, int pageNumber) async {
          if (value) {
            messagesPaginationController.isLoading.call(true);
            await loadMoreMessages(pageNumber);
            messagesPaginationController.isLoading.call(false);
          }
        };
        chatRoomID.value = messagesPaginationController.itemList.first.chatId.toString();
        return ApiResult.success(data: value, message: msg);
      }).mapFailure((failure) async {
        return ApiResult.failure(failure: failure);
      }) : null;
      return ;
    } catch (e) {
      logPrint("error message fetch : $e");
    }
  }

  Future<void> loadMoreMessages(int pageNo) async {
    await apiRepo.getMessagesList(chatRoomId: chatRoomID.value,messagesBody: {
      "page_number":pageNo,
      "page_size":"20",
      "sort_by":"created_at",
      "sort_order":"desc"
    }).mapSuccess((value, msg) {
      PagedDataMessages<List<MessageModel>> pagedDataMessages = value;
      messagesPaginationController.itemList.insertAll(0,checkImagesGrouping(messagesList: pagedDataMessages.data?.reversed.toList() ?? []));
      return ApiResult.success(data: value, message: msg);
    }).mapFailure((failure) async {
      return ApiResult.failure(failure: failure);
    });
  }

  int findTotalPage({required int totalRecord ,required int pageSize}){
    final result = totalRecord/pageSize;
    final resultRounded = (totalRecord/pageSize).round();
    final hasDecimalPoint = result % 1 != 0;
    return  hasDecimalPoint ? resultRounded + 1 : resultRounded;
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

    super.onClose();
  }

  /// init method
  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
    initServices();
    super.onInit();
  }

  Future<void> goToCameraScreen({required bool isImageWithText,required bool isVideoSendEnable}) async {
    Get.toNamed(ChatHelpers.cameraScreen,arguments: {
      "image": File(""),
      "isVideoSendEnable": isVideoSendEnable,
      "isImageWithText":isImageWithText
    })?.
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
        // firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
        //     isFirstUser.call, currentUserId.value);
        // updatePresence(PresenceStatus.offline.name);
      case AppLifecycleState.resumed:
        // firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
        //     isFirstUser.call, currentUserId.value);
        // updatePresence(PresenceStatus.online.name);
      case AppLifecycleState.paused:
        // firebase.userActiveChatroom(chatRoomID.value, isScreenOn.value,
        //     isFirstUser.call, currentUserId.value);
        // updatePresence(PresenceStatus.offline.name);
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
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
          url: chatArguments.imageBaseUrl + (messagesPaginationController.itemList[index].message?.file ?? ""),
          fileName: messagesPaginationController.itemList[index].message?.file?.split("/").last ?? "",
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

  io.Socket? socket;

  void socketConnect()async{

    socket = io.io(chatArguments.socketBaseUrl, <String, dynamic>{
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

      try {
        // Parse the incoming message data
        SocketReceiveModel socketReceiveModel = SocketReceiveModel.fromJson(messageDataFromEvent);

        // Log message creation time
        logPrint("time is : ${socketReceiveModel.data?.createdAt}");

        // Ensure data is valid before processing
        if (socketReceiveModel.data != null) {
          // Add the new message to the list
          messagesPaginationController.itemList.add(socketReceiveModel.data!);

          List<MessageModel> tempList = List.from(messagesPaginationController.itemList);
          List<MessageModel> processedList = checkImagesGrouping(messagesList: tempList);

          logPrint("messafge list length : ${messagesPaginationController.itemList.length} ,, ${processedList.length} ,, ${processedList.last.multiImages?.length}");

          // Update the RxList with processed results
          messagesPaginationController.itemList.clear();
          messagesPaginationController.itemList.addAll(processedList);

          // Update chatRoomID
          if (messagesPaginationController.itemList.isNotEmpty) {
            chatRoomID.value = messagesPaginationController.itemList.first.chatId.toString();
          }
        } else {
          logPrint("Received empty message data");
        }
      } catch (e, stackTrace) {
        // Detailed error logging
        logPrint("error receiving message: $e");
        logPrint("stack trace: $stackTrace");
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


  List<MessageModel> checkImagesGrouping({required List<MessageModel> messagesList}) {
    List<int> index = [];
    List<int> reciverIndex = [];

    for (int i = 0; i < messagesList.length; i++) {
      var item = messagesList[i];
      if (item.message?.messageType == "image" && item.userId == currentUserId.value) {
        index.add(i);
      } else if (item.message?.messageType == "image" && item.userId != currentUserId.value) {
        reciverIndex.add(i);
      }
    }

    // Perform grouping operations
    messagesList = groupMessages(index, messagesList);
    messagesList = groupMessages(reciverIndex, messagesList);

    return messagesList;
  }

  List<MessageModel> groupMessages(List<int> indices, List<MessageModel> messagesList) {
    int bound = 0;
    int indexLength = indices.length;
    List<int> indicesToRemove = [];

    for (int i = 0; i < indexLength; i++) {
      if (i != indexLength - 1) {
        if (indices[i] + 1 == indices[i + 1]) {
          // Continue if consecutive
          continue;
        } else {
          if (i - bound >= 2) { // Group of 3 or more
            indicesToRemove.addAll(indices.sublist(bound, i + 1));
            addData(indices[bound], indices[i], messagesList);
          }
          bound = i + 1;
        }
      } else {
        if (i - bound >= 2) { // Group of 3 or more
          indicesToRemove.addAll(indices.sublist(bound, i + 1));
          addData(indices[bound], indices[i], messagesList);
        }
      }
    }

    // Remove indices from the list in reverse order to avoid shifting issues
    indicesToRemove.sort((a, b) => b.compareTo(a));
    for (int idx in indicesToRemove) {
      messagesList.removeAt(idx);
    }

    return messagesList;
  }

  void addData(int startIndex, int endIndex, List<MessageModel> messagesList) {
    if (messagesList[startIndex].multiImages != null) {
      if (messagesList[endIndex].multiImages == null) {
        messagesList[endIndex].multiImages = [];
      }
      messagesList[endIndex].multiImages?.addAll(messagesList[startIndex].multiImages ?? []);
    }
    for (int i = startIndex; i <= endIndex; i++) {
      if (messagesList[i].message != null) {
        messagesList[endIndex].multiImages?.add(messagesList[i].message!);
      }
    }
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