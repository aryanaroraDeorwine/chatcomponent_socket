import 'package:flutter/material.dart';

import '../models/user_model/user_model.dart';

/// Chat screen Arguments
class ChatArguments {
  String firebaseServerKey;
  String userToken;
  String imageBaseUrl;
  String socketBaseUrl;
  String apiBaseUrl;
  String appType;
  String? agoraAppId;
  String? agoraAppCertificate;
  bool isVideoCallEnable;
  bool isAudioCallEnable;
  bool isAttachmentSendEnable;
  AttachmentArguments? imageArguments;
  ThemeArguments? themeArguments;
  bool isCameraImageSendEnable;
  bool isVideoSendEnable;
  List<String>? suggestionsMessages;
  List<String>? reactionsEmojisIcons;
  bool? reactionsEnable;

  ChatArguments(
      {
        required this.userToken,
        required this.apiBaseUrl,
        required this.socketBaseUrl,
        this.imageArguments,
        required this.appType,
        required this.isVideoSendEnable,
        this.themeArguments,
        this.reactionsEnable = false,
        this.suggestionsMessages,
        this.reactionsEmojisIcons,
        required this.isVideoCallEnable,
        required this.isAudioCallEnable,
        required this.isAttachmentSendEnable,
        required this.isCameraImageSendEnable,
        required this.imageBaseUrl,
        required this.agoraAppId,
        required this.agoraAppCertificate,
        required this.firebaseServerKey
      });
}

/// Image send able Arguments
class AttachmentArguments {
  bool? isImageFromGallery;
  bool? isImageFromCamera;
  bool? isDocumentsSendEnable;
  bool? isAudioRecorderEnable;

  AttachmentArguments({
    this.isAudioRecorderEnable = false,
    this.isImageFromGallery = false,
    this.isImageFromCamera = false,
    this.isDocumentsSendEnable = false,
  });
}

/// theme Arguments
class ThemeArguments {
  ColorArguments? colorArguments;
  StyleArguments? styleArguments;
  BorderRadiusArguments? borderRadiusArguments;
  CustomWidgetsArguments? customWidgetsArguments;

  ThemeArguments(
      {this.colorArguments,
      this.styleArguments,
      this.borderRadiusArguments,
      this.customWidgetsArguments});
}

/// Color change for app theme Arguments
class ColorArguments {
  Color? mainColor;
  Color? mainColorLight;
  Color? textColor;
  Color? appBarNameTextColor;
  Color? appBarPresenceTextColor;
  Color? senderMessageTextColor;
  Color? receiverMessageTextColor;
  Color? backgroundColor;
  Color? iconColor;
  Color? sendIconColor;
  Color? attachmentIconColor;
  Color? cameraIconColor;
  Color? audioCallIconColor;
  Color? videoCallIconColor;
  Color? attachmentCameraIconColor;
  Color? attachmentGalleryIconColor;
  Color? attachmentDocumentsIconColor;
  Color? senderMessageBoxColor;
  Color? receiverMessageBoxColor;
  Color? buttonColor;
  Color? callButtonsBackgroundColors;
  Color? backButtonIconColor;
  Color? reactionViewBoxColor;
  Color? reactionBoxColor;
  Color? messageTextFieldColor;
  Color? tickSeenColor;
  Color? tickUnSeenColor;

  ColorArguments(
      {this.tickSeenColor,
      this.tickUnSeenColor,
      this.messageTextFieldColor,
      this.iconColor,
      this.sendIconColor,
      this.reactionViewBoxColor,
      this.reactionBoxColor,
      this.appBarNameTextColor,
      this.appBarPresenceTextColor,
      this.senderMessageTextColor,
      this.receiverMessageTextColor,
      this.attachmentIconColor,
      this.cameraIconColor,
      this.audioCallIconColor,
      this.videoCallIconColor,
      this.backButtonIconColor,
      this.attachmentCameraIconColor,
      this.attachmentGalleryIconColor,
      this.attachmentDocumentsIconColor,
      this.senderMessageBoxColor,
      this.receiverMessageBoxColor,
      this.buttonColor,
      this.mainColor,
      this.mainColorLight,
      this.textColor,
      this.backgroundColor,
      this.callButtonsBackgroundColors});
}

/// style changes for app theme Arguments
class StyleArguments {
  TextStyle? appbarNameStyle;
  TextStyle? appbarPresenceStyle;
  TextStyle? messageTextStyle;
  TextStyle? messageTextFieldHintTextStyle;
  TextStyle? messageTextFieldTextStyle;
  TextStyle? messagesTimeTextStyle;
  TextStyle? callNameTextStyles;

  StyleArguments(
      {this.messageTextFieldHintTextStyle,
      this.messageTextFieldTextStyle,
      this.appbarNameStyle,
      this.appbarPresenceStyle,
      this.callNameTextStyles,
      this.messageTextStyle,
      this.messagesTimeTextStyle});
}

/// border Radius  changes for app  theme Arguments
class BorderRadiusArguments {
  double? messageTextFieldRadius;
  double? messageBoxSenderTopLeftRadius;
  double? messageBoxSenderTopRightRadius;
  double? messageBoxSenderBottomRightRadius;
  double? messageBoxSenderBottomLeftRadius;
  double? messageBoxReceiverTopLeftRadius;
  double? messageBoxReceiverTopRightRadius;
  double? messageBoxReceiverBottomRightRadius;
  double? messageBoxReceiverBottomLeftRadius;
  double? sendButtonRadius;
  double? iconButtonsRadius;
  double? reactionBoxRadius;

  BorderRadiusArguments(
      {this.reactionBoxRadius,
      this.messageTextFieldRadius,
      this.messageBoxSenderTopLeftRadius,
      this.messageBoxSenderTopRightRadius,
      this.messageBoxSenderBottomRightRadius,
      this.messageBoxSenderBottomLeftRadius,
      this.messageBoxReceiverTopLeftRadius,
      this.messageBoxReceiverTopRightRadius,
      this.messageBoxReceiverBottomRightRadius,
      this.messageBoxReceiverBottomLeftRadius,
      this.sendButtonRadius,
      this.iconButtonsRadius});
}

/// custom Widget changes for app theme Arguments
class CustomWidgetsArguments {
  Widget? customSendIconButtonWidgets;
  Widget? customLoaderWidgets;

  CustomWidgetsArguments({this.customLoaderWidgets, this.customSendIconButtonWidgets});
}

/// Call screen Arguments
class CallArguments {
  String userId;
  Users user;
  Users currentUser;
  String currentUserId;
  String callType;
  String callId;
  String firebaseServerKey;
  String imageBaseUrl;
  String agoraAppId;
  String agoraChannelName;
  String agoraToken;
  String agoraAppCertificate;
  bool? isMicOn;
  ThemeArguments? themeArguments;

  CallArguments(
      {required this.agoraChannelName,
      required this.agoraToken,
      this.isMicOn,
      this.themeArguments,
      required this.user,
      required this.currentUser,
      required this.callType,
      required this.callId,
      required this.imageBaseUrl,
      required this.agoraAppId,
      required this.agoraAppCertificate,
      required this.userId,
      required this.currentUserId,
      required this.firebaseServerKey});
}
