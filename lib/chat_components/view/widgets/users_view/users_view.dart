import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:flutter/material.dart';

import '../cached_network_imagewidget/cached_network_image_widget.dart';

class UsersView extends StatelessWidget {
  final String userProfile;
  final String userName;
  final String orderId;
  final String? resentMessages;
  final String? resentWidget;


  const UsersView({super.key,required this.orderId,required this.userProfile,required this.userName,this.resentMessages,this.resentWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ChatHelpers.white,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: ChatHelpers.mainColorLight,
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: ChatHelpers.marginSizeDefault,),
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
                color: ChatHelpers.mainColor,
               shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: cachedNetworkImage(url: userProfile,isProfile: false),
            ),
          ),
          const SizedBox(width: ChatHelpers.marginSizeSmall,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text(userName,style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)),
              resentMessages != null && (resentMessages?.isNotEmpty ?? false) ? Align(alignment: Alignment.bottomLeft,child: Text(resentMessages ?? "",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)) : const SizedBox()
            ],
          ),
          const SizedBox(width: ChatHelpers.marginSizeSmall,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text("Order id : $orderId",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)),
              resentWidget != null && (resentWidget?.isNotEmpty ?? false) ? Align(alignment: Alignment.bottomRight,child: Text(resentWidget??"",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeLarge, ChatHelpers.black),)) : const SizedBox()
            ],
          ),
          const SizedBox(width: ChatHelpers.marginSizeDefault,),
        ],
      ),

    );
  }
}
