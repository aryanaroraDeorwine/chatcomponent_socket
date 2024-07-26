import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:flutter/material.dart';

import '../cached_network_imagewidget/cached_network_image_widget.dart';

class UsersView extends StatelessWidget {
  final String userProfile;
  final String userName;
  final String orderId;
  final String? resentMessages;
  final String? resentWidget;
  final VoidCallback onTap;


  const UsersView({super.key,required this.orderId,required this.userProfile,required this.userName,this.resentMessages,this.resentWidget, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ChatHelpers.white,
            borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: ChatHelpers.mainColorLight,
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: ChatHelpers.marginSizeDefault,),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: ChatHelpers.mainColor,
                 shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: userProfile.isEmpty ? Center(child: Text(userName[0],style:  ChatHelpers.instance.styleBold(ChatHelpers.fontSizeOverExtraLarge,ChatHelpers.white),))  : cachedNetworkImage(url: userProfile,isProfile: true),
              ),
            ),
            const SizedBox(width: ChatHelpers.marginSizeSmall,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text(userName,style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)),
                  // resentMessages != null && (resentMessages?.isNotEmpty ?? false) ? Align(alignment: Alignment.bottomLeft,child: Text(resentMessages ?? "",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)) : const SizedBox()
                ],
              ),
            ),
            const SizedBox(width: ChatHelpers.marginSizeSmall,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text("Order id : $orderId",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)),
                  // resentWidget != null && (resentWidget?.isNotEmpty ?? false) ? Align(alignment: Alignment.bottomRight,child: Text(resentWidget??"",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)) : const SizedBox()
                ],
              ),
            ),
            const SizedBox(width: ChatHelpers.marginSizeDefault,),
          ],
        ),
      
      ),
    );
  }
}
