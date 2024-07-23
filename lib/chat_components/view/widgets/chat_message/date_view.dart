import 'package:chat_component/chat_components/model/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/chatHelper/chat_helper.dart';

class DateView extends StatelessWidget {
  final String date;
  const DateView({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Get.find<ChatServices>().chatArguments.themeArguments?.customWidgetsArguments?.customDateView != null ? Get.find<ChatServices>().chatArguments.themeArguments?.customWidgetsArguments?.customDateView!(context,date)
          :  Container(
        padding: const EdgeInsets.symmetric(horizontal: ChatHelpers.marginSizeDefault,vertical: ChatHelpers.marginSizeExtraSmall-1),
        margin: const EdgeInsets.symmetric(horizontal: ChatHelpers.marginSizeDefault,vertical: ChatHelpers.marginSizeSmall),
        decoration: BoxDecoration(
            color: ChatHelpers.mainColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(ChatHelpers.roundButtonRadius)
        ),
        child: Text(
          date,
          textAlign: TextAlign.center,
          style: ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeSmall, ChatHelpers.white),
        ),
      ),
    );
  }
}
