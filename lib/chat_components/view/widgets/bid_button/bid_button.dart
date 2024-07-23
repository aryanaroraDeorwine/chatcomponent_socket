import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:flutter/material.dart';

class BidButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColorColor;
  final TextStyle? textStyle;
  const BidButton({super.key, required this.text, required this.onTap, this.buttonColor, this.textColorColor, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: ChatHelpers.marginSizeExtraSmall,bottom: ChatHelpers.marginSizeExtraSmall,left: ChatHelpers.marginSizeSmall),
        padding: const EdgeInsets.symmetric(vertical: ChatHelpers.marginSizeExtraSmall,horizontal: ChatHelpers.marginSizeDefault),
        decoration: BoxDecoration(
          color: buttonColor ?? ChatHelpers.mainColorLight,
          borderRadius: BorderRadius.circular(ChatHelpers.circularImage)
        ),
        child: Text(text,style: ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeDefault, ChatHelpers.white),),
      ),
    );
  }
}
