import 'package:chat_component/chat_components/model/models/chat_view_args/chat_view_args.dart';
import 'package:chat_component/chat_components/view/widgets/chat_message/message_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/chatHelper/chat_helper.dart';
import '../../../model/models/message_model/message_model.dart';
import '../../../view_model/controller/chat_view_controller/chat_view_controller.dart';
import 'dart:math' as math;

import '../cached_network_imagewidget/cached_network_image_widget.dart';
import '../reaction_view/reaction_view.dart';

class MultiImagesViews extends StatelessWidget {
  final List<Message> multiImageList;
  final int index;
  final int reaction;
  final bool isSender;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ChatViewController chatController;
  final bool isSeen;
  final String time;
  final MainViewArgs mainViewArgs;
  const MultiImagesViews({super.key, required this.multiImageList, required this.index, required this.reaction, required this.isSender, required this.onTap, required this.onLongPress, required this.chatController, required this.isSeen, required this.time, required this.mainViewArgs});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Align(
        alignment:
        isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: isSender == true ? 0 : ChatHelpers.marginSizeSmall,right: isSender == true ? ChatHelpers.marginSizeSmall : 0,),
          child: Column(
            crossAxisAlignment: isSender == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: (mainViewArgs.customMultiImageSenderView != null && mainViewArgs.customMultiImageReceiverView != null) ? BoxConstraints(minHeight: 220, minWidth: 220, maxWidth: MediaQuery.of(context).size.width * .85) : const BoxConstraints(minHeight: 220, minWidth: 220, maxWidth: 220),
                child: Stack(
                  children: [
                    (mainViewArgs.customMultiImageSenderView != null && mainViewArgs.customMultiImageReceiverView != null) ? (isSender && (mainViewArgs.customMultiImageSenderView != null && mainViewArgs.customMultiImageReceiverView != null) ?
                    mainViewArgs.customMultiImageSenderView!(context,chatController.messagesPaginationController.itemList[index]) :
                    mainViewArgs.customMultiImageReceiverView!(context,chatController.messagesPaginationController.itemList[index])) :
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: ChatHelpers.marginSizeExtraSmall,
                            left: isSender == true
                                ? ChatHelpers.marginSizeSmall
                                : 0,
                            right: isSender == true
                                ? 0
                                : ChatHelpers.marginSizeSmall,
                            bottom: reaction != 7 ? 10 : 0,
                          ),
                          decoration: BoxDecoration(
                            color: isSender == true ? chatController.themeArguments?.colorArguments?.senderMessageBoxColor ?? ChatHelpers.mainColor : chatController.themeArguments?.colorArguments?.receiverMessageBoxColor ?? ChatHelpers.backcolor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: isSender == true
                                  ? Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxSenderBottomLeftRadius ??
                                  ChatHelpers.cornerRadius)
                                  : Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxReceiverBottomLeftRadius ??
                                  ChatHelpers.cornerRadius),
                              topRight: isSender == true
                                  ? Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxSenderTopRightRadius ??
                                  0)
                                  : Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxReceiverTopRightRadius ??
                                  ChatHelpers.cornerRadius),
                              topLeft: isSender == true
                                  ? Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxSenderTopLeftRadius ??
                                  ChatHelpers.cornerRadius)
                                  : Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxReceiverTopLeftRadius ??
                                  0),
                              bottomRight: isSender == true
                                  ? Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxSenderBottomRightRadius ??
                                  ChatHelpers.cornerRadius)
                                  : Radius.circular(chatController
                                  .themeArguments
                                  ?.borderRadiusArguments
                                  ?.messageBoxReceiverBottomRightRadius ??
                                  ChatHelpers.cornerRadius),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 220,
                                margin: const EdgeInsets.all(
                                    ChatHelpers.marginSizeExtraSmall),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ChatHelpers.marginSizeDefault),
                                  color: isSender == true
                                      ? chatController
                                      .themeArguments
                                      ?.colorArguments
                                      ?.senderMessageBoxColor ??
                                      ChatHelpers.mainColor
                                      : chatController
                                      .themeArguments
                                      ?.colorArguments
                                      ?.receiverMessageBoxColor ??
                                      ChatHelpers.backcolor,
                                ),
                                child: Wrap(
                                  children: List.generate(4,(index) =>
                                      index == 3 && (multiImageList.length > 4) ?
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              ChatHelpers.marginSizeSmall),
                                          child:
                                          Stack(
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                        ChatHelpers.marginSizeExtraSmall),
                                                ),
                                                child: cachedNetworkImage(
                                                    isProfile: false,
                                                    url: multiImageList[index].file ?? ""),
                                              ),
                                              Container(
                                                height: 100,
                                                width: 100,
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: ChatHelpers.black.withOpacity(.3),
                                                    borderRadius: BorderRadius.circular(
                                                        ChatHelpers.marginSizeExtraSmall),
                                                ),
                                                child: Text(
                                                  "+${(multiImageList.length - 4).toString()}",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.white),
                                                ),
                                              )
                                            ],
                                          )
                                      )
                                          :
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              ChatHelpers.marginSizeSmall),
                                          child:
                                          Container(
                                            height: 100,
                                            width: 100,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    ChatHelpers.marginSizeExtraSmall),
                                            ),
                                            child: cachedNetworkImage(
                                                isProfile: false,
                                                url: multiImageList[index].file ?? ""),
                                          )
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: ChatHelpers.marginSizeSmall),
                                margin: const EdgeInsets.only(
                                    bottom: ChatHelpers.marginSizeExtraSmall),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height:
                                      ChatHelpers.marginSizeExtraSmall,
                                    ),
                                    Container(
                                      alignment: isSender
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: ChatHelpers
                                              .marginSizeExtraSmall),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(time,
                                                textAlign: TextAlign.start,
                                                style: chatController
                                                    .themeArguments
                                                    ?.styleArguments
                                                    ?.messagesTimeTextStyle ??
                                                    ChatHelpers.instance.styleLight(
                                                        ChatHelpers
                                                            .fontSizeExtraSmall,
                                                        isSender == true
                                                            ? chatController
                                                            .themeArguments
                                                            ?.colorArguments
                                                            ?.senderMessageTextColor ??
                                                            ChatHelpers
                                                                .white
                                                            : chatController
                                                            .themeArguments
                                                            ?.colorArguments
                                                            ?.receiverMessageTextColor ??
                                                            ChatHelpers
                                                                .black)),
                                          ),
                                          const SizedBox(
                                            width: ChatHelpers
                                                .marginSizeExtraSmall,
                                          ),
                                          isSender == true
                                              ? Image.asset(
                                            ChatHelpers.instance
                                                .doubleTickImage,
                                            height: 15,
                                            width: 15,
                                            package: 'chat_component',
                                            color: isSeen
                                                ? chatController
                                                .themeArguments
                                                ?.colorArguments
                                                ?.tickSeenColor ??
                                                ChatHelpers
                                                    .backcolor
                                                : chatController
                                                .themeArguments
                                                ?.colorArguments
                                                ?.tickUnSeenColor ??
                                                ChatHelpers.grey,
                                          )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: isSender ? 0 : null,
                          left: isSender ? null : 0,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(isSender ? math.pi : 0), // flip the bubble shape for receiver side
                            child: CustomPaint(
                              size: const Size(20, 20),
                              painter: CustomBubbleShape(isSender == true
                                  ? chatController.themeArguments?.colorArguments
                                  ?.senderMessageBoxColor ??
                                  ChatHelpers.mainColor
                                  : chatController.themeArguments?.colorArguments
                                  ?.receiverMessageBoxColor ??
                                  ChatHelpers.backcolor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    chatController.chatArguments.reactionsEnable == true ?
                    reaction != 7
                        ? Positioned(
                      left: isSender ? 0 : null,
                      right: isSender ? null : 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(
                            ChatHelpers.marginSizeExtraSmall),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ChatHelpers.blueLight),
                        child: Text(
                          chatController.emoji[reaction],
                          style: const TextStyle(fontSize: ChatHelpers.fontSizeSmall),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                        : const SizedBox() : const SizedBox(),
                  ],
                ),
              ),
              if (chatController.selectReactionIndex.value == index.toString() && chatController.chatArguments.reactionsEnable == true)
                Padding(
                  padding: chatController.isReaction.isTrue
                      ? const EdgeInsets.symmetric(
                      vertical: ChatHelpers.marginSizeExtraSmall)
                      : const EdgeInsets.all(0),
                  child: ReactionView(
                    messageIndex: index,
                    isSender: isSender,
                    isChange: chatController.isReaction.value,
                    reactionList: chatController.emoji,
                    chatController: chatController,
                  ),
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
