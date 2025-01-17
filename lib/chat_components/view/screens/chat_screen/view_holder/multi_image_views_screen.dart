import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:chat_component/chat_components/model/models/message_model/message_model.dart';
import 'package:chat_component/chat_components/view/widgets/icon_button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/controller/chat_view_controller/chat_view_controller.dart';
import '../../../widgets/cached_network_imagewidget/cached_network_image_widget.dart';
import '../../../widgets/chat_message/image_zoom_view.dart';

class MultiImageViewsScreen extends StatelessWidget {
  final List<Message> imagesList;
  final ChatViewController chatController;
  final bool isSender;
  const MultiImageViewsScreen({super.key, required this.imagesList, required this.chatController, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ChatHelpers.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              color: ChatHelpers.mainColorLight.withOpacity(.8),
              child: Row(
                children: [
                  const SizedBox(width: ChatHelpers.marginSizeSmall,),
                  CircleIconButton(onTap: () => Get.back(), isImage: false,shapeRec: false,icons: Icons.arrow_back,colors: ChatHelpers.white,iconsSize: 25,boxColor: ChatHelpers.transparent,),
                  const SizedBox(width: ChatHelpers.marginSizeSmall,),
                  Text("${imagesList.length} photos",style: ChatHelpers.instance.styleMedium(ChatHelpers.fontSizeDefault, ChatHelpers.white),)
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(
                    imagesList.length,
                    (index) => GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              ViewImageAndPlayVideoScreen(
                                file: imagesList[index].file ?? '',
                                chatController: chatController,
                              )
                          );
                        },
                        child: Hero(
                            tag: imagesList[index].file ?? "",
                            child: cachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                isProfile: false,
                                url: imagesList[index].file ?? ""))).paddingSymmetric(vertical: ChatHelpers.marginSizeExtraSmall).marginOnly(top: ChatHelpers.marginSizeExtraSmall,left: ChatHelpers.marginSizeExtraSmall,right: ChatHelpers.marginSizeExtraSmall)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
