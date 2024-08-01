import 'dart:io';
import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:chat_component/chat_components/model/models/chat_view_args/chat_view_args.dart';
import 'package:chat_component/chat_components/model/models/message_model/message_model.dart';
import 'package:chat_component/chat_components/view/screens/chat_screen/view_holder/multi_image_views_screen.dart';
import 'package:chat_component/chat_components/view/widgets/empty_data_view/empty_data_view.dart';
import 'package:chat_component/chat_components/view/widgets/loader/loader_view.dart';
import 'package:chat_component/chat_components/view/widgets/pagination_view/pagination_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../view_model/controller/chat_view_controller/chat_view_controller.dart';
import '../../widgets/chat_message/audio_player_view/audio_player_view.dart';
import '../../widgets/chat_message/date_view.dart';
import '../../widgets/chat_message/multi_images_views.dart';
import '../../widgets/user_detail_view_chat/user_details_view_chatscreen.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import '../../../model/function_helper/date_time_convertor/date_time_convertor.dart';
import '../../widgets/chat_message/file_view.dart';
import '../../widgets/chat_message/full_screen_video_player.dart';
import '../../widgets/chat_message/image_view.dart';
import '../../widgets/chat_message/image_zoom_view.dart';
import '../../widgets/chat_message/message_view.dart';
import '../../widgets/common_button/common_text_button.dart';
import '../../widgets/icon_button/icon_button.dart';
import '../../widgets/message_box_field/message_box_field.dart';
import '../../widgets/text_chip/text_chip.dart';


class ChatView<T extends ChatViewController> extends GetView<ChatViewController> {
  final T viewControl;
  final String? tag;
  final Color? backgroundColor;
  final String? errorImage;
  final String? errorText;
  final Rx<HeaderViewArgs> headerViewArgs;
  final Rx<MainViewArgs> mainViewArgs;
  final Rx<BottomViewArgs> bottomViewArgs;



  const ChatView(
      {super.key,
        this.tag,
        required this.headerViewArgs,
        required this.mainViewArgs,
        required this.bottomViewArgs,
        this.backgroundColor,
        this.errorImage,
        this.errorText,
        required this.viewControl,
      });


  @override
  Widget build(BuildContext context) {

    final T controller = (tag != null)?Get.put(viewControl,tag: tag):Get.put(viewControl);


    return SafeArea(
        left: true,
        top: false,
        bottom: Platform.isIOS?false:true,
        right: true,
        child: buildChild(context,controller)
    );
  }


  buildChild(BuildContext context,T controller){
    return  Obx(() => Scaffold(
      backgroundColor: backgroundColor ?? ChatHelpers.white,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: ChatHelpers.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child:  Stack(children: [
            Visibility(
                visible: controller.isError.isFalse,
                child: _buildMainView(context,controller)),
            Visibility(
              visible: controller.isError.value,
              child: EmptyDataView(
                  title: errorText ?? ChatHelpers.instance.errorMissingData,
                  isButton: false,
                  image: errorImage ?? ChatHelpers.instance.somethingWentWrong),
            )
          ])),
    ));
  }


  Widget _buildMainView(BuildContext context, T controller){
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Obx(() => headerViewArgs.value.customTopView !=null ? headerViewArgs.value.customTopView!(userName: headerViewArgs.value.userName.capitalizeFirst ??"",userProfile: headerViewArgs.value.userProfile,onBack: () => Get.back(),onAudioCallTap: controller.onAudioCallTap,onVideoCallTap: controller.onVideoTap)
              : UserViewChatScreen(
                userName: headerViewArgs.value.userName.capitalizeFirst??"",
                userProfile: headerViewArgs.value.userProfile,
                presence: "",
                backButtonTap: () => Get.back(),
                audioCallButtonTap: () => controller.onAudioCallTap(),
                videoCallButtonTap: () => controller.onVideoTap(),
                chatController: controller, isVideoCallEnable: headerViewArgs.value.isVideoCallEnable, isAudioCallEnable: headerViewArgs.value.isAudioCallEnable,
              )),
          _messagesListView(context,controller),
          const SizedBox(height: ChatHelpers.marginSizeExtraSmall,),
          Obx( () => (mainViewArgs.value.wizardWidget?.isWizardWidgetEnable ?? false) & controller.isWizardWidgetGet.isTrue ? mainViewArgs.value.wizardWidget?.wizardWidget ?? const SizedBox() : const SizedBox() ),
          Obx(() =>
          mainViewArgs.value.messageSuggestionEnable
              && controller.isLoadingChats.isFalse
              ? controller.messagesPaginationController.itemList.isEmpty
              ? Container(
              margin: const EdgeInsets.only(left: 5),
              height: 55,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    controller.suggestions.length,
                        (index) =>
                        TextChip(
                          message:
                          controller.suggestions[index],
                          tap: () =>
                              controller.chipMessage(index),
                        )),
              ))
              : const SizedBox()
              : const SizedBox()),
          _bottomViewBox(context, controller)
        ],
      ),
    );
  }

  Widget _messagesListView(BuildContext context, T controller){
    return Expanded(
      child: Obx(() =>
      controller.isLoadingChats.isFalse
          ? controller.messagesPaginationController.itemList.isEmpty
          ? SizedBox(
          height: 300,
          child: Lottie.asset(
              ChatHelpers.instance.hello,
              package: 'chat_component'))
          :
          PaginationView(
              isReverse: true,
              showItemList: controller.messagesPaginationController.itemList,
              mainView: (BuildContext context, int index,MessageModel itemData) {
                return Column(
                  children: [
                    index == 0 ?
                    DateView(
                        date: DateTimeConvertor
                            .dateTimeShowMessages(
                            itemData.createdAt ??
                                ""))
                        : DateTime.parse(itemData.createdAt ?? "").day != DateTime.parse(itemData.createdAt ?? "").day
                        ? DateView(
                        date: DateTimeConvertor
                            .dateTimeShowMessages(
                            itemData
                                .createdAt ??
                                ""))
                        : const SizedBox(),
                    itemData.message?.messageType == 'text' ?
                    MessageView(
                      index: index,
                      chatController: controller,
                      onLongTap: () {
                        controller
                            .selectReactionIndex
                            .value =
                            index.toString();
                        controller.isReaction
                            .value =
                        !controller.isReaction
                            .value;
                      },
                      message: itemData.message
                          ?.text ?? '',
                      time: DateTimeConvertor
                          .timeExt(
                          itemData
                              .createdAt ?? ''),
                      isSender: itemData.userId ==
                          controller
                              .currentUserId
                              .value,
                      isSeen: false,
                      isReaction: controller
                          .isReaction
                          .value,
                      reactionList: controller
                          .emoji,
                      reaction: itemData
                          .message?.reaction ?? 7,
                    )
                        : itemData.message?.messageType ==
                        FileTypes.image.name || itemData.message?.messageType ==
                        FileTypes.video.name
                        ?
                    itemData.multiImages?.isNotEmpty ?? false ?
                    MultiImagesViews(multiImageList: itemData.multiImages ?? [], index: index, reaction: itemData
                        .message?.reaction ?? 7, isSender: itemData.userId == controller.currentUserId.value,
                      onTap: () => Get.to(
                                    MultiImageViewsScreen(
                                    imagesList: itemData.multiImages ?? [],
                                    chatController: controller, isSender: itemData.userId == controller.currentUserId.value,),
                      ),
                      onLongPress: () {  }, chatController: controller,
                      isSeen: itemData
                        .message?.isSeen ?? false, time: DateTimeConvertor
                        .timeExt(
                        itemData
                            .createdAt ?? ""),

                    )
                        :
                    ImageView(
                      isAdding: true,
                      imageMessage: itemData
                          .message?.text ?? "",
                      reaction: itemData
                          .message?.reaction ?? 7,
                      time: DateTimeConvertor
                          .timeExt(
                          itemData
                              .createdAt ?? ""),
                      image: itemData.message?.file ?? "",
                      isSender: itemData.userId == controller.currentUserId.value,
                      onTap: () => itemData.message?.file == FileTypes.video.name ?
                      Get.to(
                        FullScreenVideoPlayer(
                          file: itemData.message?.file ?? '',
                          chatController: controller, imageThumbnail: itemData.message?.file ?? "",
                        ),
                      )
                          : Get.to(
                        ViewImageAndPlayVideoScreen(
                          file: itemData.message?.file ?? '',
                          chatController: controller,
                        ),
                      ),
                      isSeen: itemData
                          .message?.isSeen ?? false,
                      onLongPress: () {
                        controller
                            .selectReactionIndex
                            .value =
                            index.toString();
                        controller.isReaction
                            .value =
                        !controller.isReaction
                            .value;
                      },
                      index: index,
                      chatController: controller,
                      isVideo: itemData.message?.messageType == FileTypes.image.name ? false : true,
                    )
                        : itemData.message?.fileType ==
                        FileTypes.audio.name ?
                    AudioPlayerView(
                        audioUrl: itemData
                            .message?.file ??
                            "",
                        time: DateTimeConvertor
                            .timeExt(
                            itemData
                                .createdAt ?? ""),
                        index: index,
                        reaction: itemData
                            .message?.reaction ?? 7,
                        isSender: itemData.message?.sender == controller.currentUserId.value,
                        isSeen: itemData.message?.isSeen ?? false,
                        isReaction: controller.isReaction.value,
                        reactionList: controller.emoji,
                        onLongTap: () {
                          controller.selectReactionIndex.value = index.toString();
                          controller.isReaction.value = !controller.isReaction.value;
                        },
                        chatController: controller)
                        : FileView(
                      isAdding: true,
                      reaction: itemData.message?.reaction ?? 7,
                      isSeen: itemData.message?.isSeen ?? false,
                      onLongPress: () {
                        controller.selectReactionIndex.value = index.toString();
                        controller.isReaction.value = !controller.isReaction.value;
                      },
                      index: index,
                      chatController: controller,
                      time:
                      DateTimeConvertor
                          .timeExt(itemData.createdAt ?? ""),
                      fileName: itemData.message?.file ?? '',
                      isSender: itemData
                          .userId ==
                          controller
                              .currentUserId
                              .value,
                    ),
                  ],
                );
              },
              pagingScrollController: controller.messagesPaginationController,
              onRefresh: (){})
          : Center(
        child: mainViewArgs.value.customLoader ?? controller.themeArguments?.customWidgetsArguments?.customLoaderWidgets ?? LoaderView(
          size: 30,
          loaderColor: controller.themeArguments?.colorArguments?.mainColor ??
              ChatHelpers.mainColor,),
      )
      ),
    );
  }

  Widget _bottomViewBox(BuildContext context, T controller){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        bottomViewArgs.value.customBottomView != null ? bottomViewArgs.value.customBottomView!(context: context,messageController: controller.messageController,onCameraTap: () => controller.goToCameraScreen(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),onSendTap: controller.sendMessage,onAttachmentTap: controller.openDialog,onDocumentTap:controller.pickFile) :  SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              MessageField(
                onChange: (String? value) {
                  // controller.typingStatus(true);
                  // EasyDebounce.debounce('TypingStatus',
                  //     const Duration(
                  //         milliseconds: 1000), () =>
                  //         controller.typingStatus(false));
                  return null;
                },
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.80,
                controller: controller.messageController,
                hintText: 'Enter Message',
                onValidators: (String? value) => null,
                unFocusedColor: controller.themeArguments
                    ?.colorArguments
                    ?.messageTextFieldColor,
                focusedColors: controller.themeArguments
                    ?.colorArguments
                    ?.messageTextFieldColor,
                focusedRadius: controller.themeArguments
                    ?.borderRadiusArguments
                    ?.messageTextFieldRadius,
                hintTextStyle: controller.themeArguments
                    ?.styleArguments
                    ?.messageTextFieldHintTextStyle,
                textStyle: controller.themeArguments
                    ?.styleArguments
                    ?.messageTextFieldTextStyle,
                suffixValue: Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .22,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      bottomViewArgs.value.isAttachmentSendEnable
                          ? CircleIconButton(
                        height: ChatHelpers
                            .iconSizeExtraOverLarge,
                        width: ChatHelpers
                            .iconSizeExtraOverLarge,
                        padding: 0,
                        splashColor: ChatHelpers.black
                            .withOpacity(.3),
                        boxColor: ChatHelpers.transparent,
                        isImage: false,
                        colors: controller.themeArguments
                            ?.colorArguments
                            ?.attachmentIconColor ??
                            ChatHelpers.textColor_4,
                        icons: Icons.attach_file,
                        onTap: () =>
                            controller.openDialog(),
                      )
                          : const SizedBox(),
                      bottomViewArgs.value.isCameraImageSendEnable
                          ?  bottomViewArgs.value.customCameraBtn != null ? bottomViewArgs.value.customCameraBtn!(context,() => controller.goToCameraScreen(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable)) : CircleIconButton(
                        height: ChatHelpers
                            .iconSizeExtraOverLarge,
                        width: ChatHelpers
                            .iconSizeExtraOverLarge,
                        padding: 0,
                        splashColor: ChatHelpers.black
                            .withOpacity(.3),
                        boxColor: ChatHelpers.transparent,
                        isImage: false,
                        icons: Icons.camera_alt,
                        colors: controller.themeArguments
                            ?.colorArguments
                            ?.cameraIconColor ??
                            ChatHelpers.textColor_4,
                        onTap: () =>
                            controller.goToCameraScreen(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),
                      )
                          : const SizedBox()
                    ],
                  ),
                ),
                focus: controller.messageFocus,
                maxLines: 5,
              ),
              bottomViewArgs.value.customSendBtn != null ? bottomViewArgs.value.customSendBtn!(context,controller.sendMessage) : CircleIconButton(
                height: 50,
                width: 50,
                boxColor: controller.themeArguments
                    ?.colorArguments?.mainColorLight ??
                    ChatHelpers.mainColorLight,
                isImage: false,
                shapeRec: true,
                icons: Icons.send,
                sendBtn: controller.themeArguments
                    ?.customWidgetsArguments
                    ?.customSendIconButtonWidgets,
                colors: controller.themeArguments
                    ?.colorArguments?.sendIconColor ??
                    controller.themeArguments
                        ?.colorArguments
                        ?.iconColor ?? ChatHelpers.white,
                onTap: () => controller.sendMessage(),
              ),
              const SizedBox(width: ChatHelpers.marginSizeExtraSmall,)
            ],
          ),
        ),
        const SizedBox(height: ChatHelpers.marginSizeSmall,),
        bottomViewArgs.value.customAttachmentView != null ? bottomViewArgs.value.customAttachmentView!(context: context,onCameraTap:() => controller.goToCameraScreen(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),onGalleryTap:() =>  controller.photoPermission(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),onDocumentTap: controller.pickFile,onRecorderTap: controller.record) : _sendAttachmentView(context, controller)
      ],
    );
  }

  Widget _sendAttachmentView(BuildContext context, T controller){
    return Obx(() =>
        AnimatedOpacity(
          opacity: controller.isDialogOpen.isTrue
              ? 1.0
              : 0,
          duration: const Duration(milliseconds: 500),
          child: AnimatedContainer(
              height: controller.isDialogOpen.isTrue
                  ? (controller.imageArguments
                  ?.isAudioRecorderEnable ?? false) &&
                  (controller.imageArguments
                      ?.isDocumentsSendEnable ??
                      false) &&
                  (controller.imageArguments
                      ?.isImageFromCamera ?? false) &&
                  (controller.imageArguments
                      ?.isImageFromGallery ?? false)
                  ? 170
                  : controller.isAudioRecorderStart.isTrue ? 170 : 90
                  : 0,
              width: controller.isDialogOpen.isTrue
                  ? MediaQuery
                  .of(context)
                  .size
                  .width
                  : 0,
              padding: const EdgeInsets.symmetric(vertical: ChatHelpers.marginSizeDefault,horizontal: ChatHelpers.marginSizeSmall),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(
                      ChatHelpers.cornerRadius)),
              duration: const Duration(
                  milliseconds: 500),
              curve: Curves.easeInOutCirc,
              child: controller.isAudioRecorderStart
                  .isFalse ?
              Wrap(
                alignment: WrapAlignment.center,
                spacing: ChatHelpers.marginSizeExtraSmall,
                runSpacing: ChatHelpers.marginSizeSmall,
                children: [
                  controller.imageArguments
                      ?.isImageFromCamera ?? false ?
                  CommonIconVBtn(
                    boxColor: ChatHelpers.grey.withOpacity(.4),
                    // onPressed: () => controller.cameraPermission(),
                    onPressed: () =>
                        controller.goToCameraScreen(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),
                    title: 'Camera',
                    icons: Icons.camera_alt,
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .25,
                    fontSize: ChatHelpers
                        .marginSizeLarge,
                    color: controller.themeArguments
                        ?.colorArguments
                        ?.attachmentCameraIconColor ??
                        ChatHelpers.mainColorLight,
                    iconSize: ChatHelpers.iconSizeDefault,
                  ) : const SizedBox(),
                  controller.imageArguments
                      ?.isImageFromGallery ?? false ?
                  CommonIconVBtn(
                    boxColor: ChatHelpers.grey.withOpacity(.4),
                    onPressed: () =>
                        controller.photoPermission(isImageWithText: bottomViewArgs.value.isImageWithText,isVideoSendEnable: bottomViewArgs.value.isVideoSendEnable),
                    title: 'Gallery',
                    icons: Icons.photo_album,
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .25,
                    fontSize: ChatHelpers
                        .marginSizeLarge,
                    color: controller.themeArguments
                        ?.colorArguments
                        ?.attachmentGalleryIconColor ??
                        ChatHelpers.red,
                    iconSize: ChatHelpers
                        .iconSizeDefault,
                  ) : const SizedBox(),
                  controller.imageArguments
                      ?.isDocumentsSendEnable ?? false
                      ?
                  CommonIconVBtn(
                    boxColor: ChatHelpers.grey.withOpacity(.4),
                    onPressed: () =>
                        controller.pickFile(),
                    title: 'Documents',
                    icons: Icons.folder,
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .25,
                    fontSize: ChatHelpers
                        .marginSizeLarge,
                    color: controller.themeArguments
                        ?.colorArguments
                        ?.attachmentDocumentsIconColor ??
                        ChatHelpers.green,
                    iconSize: ChatHelpers
                        .iconSizeDefault,
                  )
                      : const SizedBox(),
                  controller.imageArguments
                      ?.isAudioRecorderEnable ?? false
                      ? CommonIconVBtn(
                    boxColor: ChatHelpers.grey.withOpacity(.4),
                    onPressed: controller.record,
                    title: 'Recorder',
                    icons: Icons.mic,
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * .25,
                    fontSize: ChatHelpers
                        .marginSizeLarge,
                    color: controller.themeArguments
                        ?.colorArguments
                        ?.attachmentDocumentsIconColor ??
                        ChatHelpers.purple,
                    iconSize: ChatHelpers
                        .iconSizeDefault,
                  )
                      : const SizedBox(),
                ],
              )
                  : SizedBox(
                height: 90,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: ChatHelpers.marginSizeDefault),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: ChatHelpers.white,
                          border: Border.all(color: ChatHelpers.mainColor),
                          borderRadius: BorderRadius.circular(ChatHelpers.buttonRadius)
                      ),
                      child: AudioWaveforms(
                        size: Size(MediaQuery.of(context).size.width * .7, 50.0),
                        recorderController: controller.recorderController,
                        enableGesture: true,
                        waveStyle: const WaveStyle(
                          waveColor: ChatHelpers.mainColorLight,
                          showDurationLabel: false,
                          spacing: 8.0,
                          showBottom: true,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: ChatHelpers.marginSizeDefault,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleIconButton(
                          onTap: () => controller.stopRecorder(true),
                          isImage: false,
                          icons: Icons.mic,
                          colors: ChatHelpers.white,
                          height: 50,
                          width: 50,
                          shapeRec: true,),
                        const SizedBox(width: ChatHelpers.marginSizeDefault,),
                        CircleIconButton(
                          onTap: () => controller.stopRecorder(false),
                          isImage: false,
                          icons: Icons.clear,
                          colors: ChatHelpers.white,
                          height: 50,
                          width: 50,
                          shapeRec: true,),
                      ],
                    ),
                  ],
                ),
              )
          ),
        ));
  }
}
