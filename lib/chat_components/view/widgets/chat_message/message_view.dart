import 'package:chat_component/chat_components/model/models/chat_view_args/chat_view_args.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/chatHelper/chat_helper.dart';
import '../../../view_model/controller/chat_view_controller/chat_view_controller.dart';
import '../reaction_view/reaction_view.dart';
import 'dart:math' as math;

class MessageView extends StatelessWidget {
  final String message;
  final String time;
  final int index;
  final int reaction;
  final bool isSender;
  final bool isSeen;
  final bool isReaction;
  final List<String> reactionList;
  final VoidCallback onLongTap;
  final ChatViewController chatController;
  final MainViewArgs mainViewArgs;

  const MessageView(
      {super.key,
      required this.message,
      required this.time,
      required this.isSender,
      required this.index,
      required this.reaction,
      required this.isSeen,
      required this.onLongTap,
      required this.isReaction,
      required this.reactionList,
      required this.chatController, required this.mainViewArgs});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onLongPress: onLongTap,
          child: Align(
            alignment: isSender == true ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: isSender == true ? 0 :ChatHelpers.marginSizeSmall,right: isSender == true ? ChatHelpers.marginSizeSmall : 0,),
              child: Column(
                crossAxisAlignment: isSender == true
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .85, minWidth: 5),
                    child: Stack(
                      children: [
                        (mainViewArgs.customSenderView != null && mainViewArgs.customReceiverView != null) ? (isSender && (mainViewArgs.customSenderView != null && mainViewArgs.customReceiverView != null) ?
                        mainViewArgs.customSenderView!(context,chatController.messagesPaginationController.itemList[index]) :
                        mainViewArgs.customReceiverView!(context,chatController.messagesPaginationController.itemList[index])) :
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: isSender == true ? ChatHelpers.marginSizeSmall : 0,
                                right: isSender == true ? 0 : ChatHelpers.marginSizeSmall ,
                                bottom: reaction != 7 ? 10 : 0,
                                top: ChatHelpers.marginSizeExtraSmall,
                              ),
                              padding: const EdgeInsets.all(
                                  ChatHelpers.paddingSizeSmall),
                              decoration: BoxDecoration(
                                color: isSender == true
                                    ? chatController.themeArguments?.colorArguments
                                    ?.senderMessageBoxColor ??
                                    ChatHelpers.mainColor
                                    : chatController.themeArguments?.colorArguments
                                    ?.receiverMessageBoxColor ??
                                    ChatHelpers.backcolor,
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
                                crossAxisAlignment: isSender
                                    ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:ChatHelpers.marginSizeExtraSmall),
                                      child: Text(
                                        message,
                                        style: chatController
                                            .themeArguments
                                            ?.styleArguments
                                            ?.messageTextStyle ??
                                            ChatHelpers.instance.styleRegular(
                                                ChatHelpers.fontSizeDefault,
                                                isSender == true
                                                    ? chatController
                                                    .themeArguments
                                                    ?.colorArguments
                                                    ?.senderMessageTextColor ??
                                                    ChatHelpers.white
                                                    : chatController
                                                    .themeArguments
                                                    ?.colorArguments
                                                    ?.receiverMessageTextColor ??
                                                    ChatHelpers.black),
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: ChatHelpers.marginSizeExtraSmall,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: ChatHelpers.marginSizeExtraSmall,
                                      ),
                                      Text(
                                        time,
                                        style: chatController
                                            .themeArguments
                                            ?.styleArguments
                                            ?.messagesTimeTextStyle ??
                                            ChatHelpers.instance.styleLight(
                                                ChatHelpers.fontSizeExtraSmall,
                                                isSender == true
                                                    ? chatController
                                                    .themeArguments
                                                    ?.colorArguments
                                                    ?.senderMessageTextColor ??
                                                    ChatHelpers.white
                                                    : chatController
                                                    .themeArguments
                                                    ?.colorArguments
                                                    ?.receiverMessageTextColor ??
                                                    ChatHelpers.black),
                                      ),
                                      SizedBox(
                                        width: isSender == true ?ChatHelpers.marginSizeExtraSmall : 0,
                                      ),
                                      isSender == true
                                          ? Image.asset(
                                        ChatHelpers.instance.doubleTickImage,
                                        height: 15,
                                        width: 15,
                                        package: 'chat_component',
                                        color: isSeen
                                            ? chatController
                                            .themeArguments
                                            ?.colorArguments
                                            ?.tickSeenColor ??
                                            ChatHelpers.backcolor
                                            : chatController
                                            .themeArguments
                                            ?.colorArguments
                                            ?.tickUnSeenColor ??
                                            ChatHelpers.grey,
                                      )
                                          : const SizedBox()
                                    ],
                                  )
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
                        chatController.chatArguments.reactionsEnable == true ? reaction != 7
                            ? Positioned(
                              left: isSender ? 0 : null,
                              right: isSender ? null: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(ChatHelpers.marginSizeExtraSmall),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ChatHelpers.blueLight),
                                child: Text(
                                  reactionList[reaction],
                                  style: const TextStyle(
                                      fontSize: ChatHelpers.fontSizeSmall),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                            : const SizedBox() : const SizedBox()
                      ],
                    ),
                  ),
                  if (chatController.selectReactionIndex.value ==
                      index.toString() && chatController.chatArguments.reactionsEnable == true)
                    Padding(
                      padding: isReaction
                          ? const EdgeInsets.symmetric(
                          vertical: ChatHelpers.marginSizeExtraSmall)
                          : const EdgeInsets.all(0),
                      child: ReactionView(
                        isSender: isSender,
                        isChange: isReaction,
                        reactionList: reactionList,
                        chatController: chatController,
                        messageIndex: index,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CustomBubbleShape extends CustomPainter {
  final Color bgColor;

  CustomBubbleShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;
    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

