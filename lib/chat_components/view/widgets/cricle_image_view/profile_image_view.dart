import 'package:flutter/material.dart';
import '../../../model/chatHelper/chat_helper.dart';
import '../cached_network_imagewidget/cached_network_image_widget.dart';

class ProfileImageView extends StatelessWidget {
  final double? height;
  final double? width;
  final String profileImage;
  final String? profileName;
  final bool? isStatus;
  final Color? textColor;
  final Color? boxColor;

  const ProfileImageView({super.key, required this.profileImage, this.height, this.width, this.isStatus, this.profileName, this.textColor, this.boxColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 40,
      decoration: BoxDecoration(
        border: isStatus == true?Border.all(color: boxColor ?? ChatHelpers.mainColorLight, width: 1.0):null,
        shape: BoxShape.circle,
        color: profileName != null ? boxColor ?? ChatHelpers.mainColorLight : ChatHelpers.transparent
      ),
      child: ClipOval(
        child: profileImage.isEmpty ?  Text(profileName??"",style:  ChatHelpers.instance.styleBold(ChatHelpers.fontSizeOverExtraLarge, textColor ?? ChatHelpers.white),)  : cachedNetworkImage(url: profileImage,isProfile: true,userName: profileName,textColor: textColor)
      ),
    );
  }
}
