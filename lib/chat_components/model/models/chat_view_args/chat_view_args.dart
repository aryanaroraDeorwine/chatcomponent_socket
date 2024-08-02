import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../message_model/message_model.dart';




class HeaderViewArgs{

  String userName;
  String userProfile;
  VoidCallback? onBack;
  VoidCallback? onAudioCallTap;
  VoidCallback? onVideoCallTap;
  bool isVideoCallEnable;
  bool isAudioCallEnable;

  Widget Function({required String userName, required String userProfile,required VoidCallback onBack,required VoidCallback onAudioCallTap,required VoidCallback onVideoCallTap})? customTopView;

  HeaderViewArgs({required this.userName,required this.userProfile,this.onBack,this.onAudioCallTap,this.onVideoCallTap,this.customTopView,required this.isVideoCallEnable,required this.isAudioCallEnable});

}

class MainViewArgs{

  Widget Function(BuildContext context, Message messageModal)? customSenderView;
  Widget Function(BuildContext context, Message messageModal)? customReceiverView;
  Widget Function(BuildContext context, Message messageModal)? customImageSenderView;
  Widget Function(BuildContext context, Message messageModal)? customImageReceiverView;
  Widget Function(BuildContext context, Message messageModal)? customMultiImageSenderView;
  Widget Function(BuildContext context, Message messageModal)? customMultiImageReceiverView;

  Widget? customLoader;
  bool messageSuggestionEnable;
  WizardWidget? wizardWidget;
  bool? reactionsEnable;

  MainViewArgs({this.customSenderView,this.customReceiverView,this.customLoader,required this.messageSuggestionEnable,this.wizardWidget,this.customImageReceiverView,this.reactionsEnable,this.customImageSenderView,this.customMultiImageReceiverView,this.customMultiImageSenderView});
}

class BottomViewArgs{

  bool isAttachmentSendEnable;
  bool isCameraImageSendEnable;
  bool isVideoSendEnable;
  bool isImageWithText;

  Widget Function(BuildContext context,VoidCallback onSendTap)? customSendBtn;
  Widget Function(BuildContext context,VoidCallback onCameraTap)? customCameraBtn;
  Widget Function({required BuildContext context,required VoidCallback onCameraTap,required VoidCallback onSendTap,required TextEditingController messageController,VoidCallback? onDocumentTap,VoidCallback? onAttachmentTap})? customBottomView;
  Widget Function({required BuildContext context,required VoidCallback onCameraTap,required VoidCallback? onGalleryTap,required VoidCallback? onDocumentTap,required VoidCallback? onRecorderTap})? customAttachmentView;

  BottomViewArgs({required this.isImageWithText,this.customSendBtn,this.customCameraBtn,required this.isAttachmentSendEnable,required this.isCameraImageSendEnable,required this.isVideoSendEnable,this.customBottomView,this.customAttachmentView});

}

class WizardWidget{
  bool isWizardWidgetEnable;
  Widget? wizardWidget;

  WizardWidget({required this.isWizardWidgetEnable,this.wizardWidget});
}

