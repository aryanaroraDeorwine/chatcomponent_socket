import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/chatHelper/chat_helper.dart';
import '../../../view_model/controller/chat_users_controller/chat_users_controller.dart';
import '../../widgets/empty_data_view/empty_data_view.dart';
import '../../widgets/icon_button/icon_button.dart';
import '../../widgets/text_field_view/common_textfield.dart';

class ChatUsersScreen<T extends ChatUsersController> extends GetView<ChatUsersController>{

  final T viewControl;
  final String? tag;
  final Color? backgroundColor;
  final String? errorImage;
  final String? errorText;

  const ChatUsersScreen({super.key,required this.viewControl, this.tag, this.backgroundColor, this.errorImage, this.errorText, });

  @override
  Widget build(BuildContext context) {
    final T controller = (tag != null)?Get.put(viewControl,tag: tag):Get.put(viewControl);


    return SafeArea(
        left: true,
        top: false,
        bottom: Platform.isIOS?false:true,
        right: true,
        child: buildChild(context,controller)
    );
  }


  buildChild(BuildContext context,T controller){
    return  Obx(() => Scaffold(
      backgroundColor: backgroundColor ?? ChatHelpers.white,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: ChatHelpers.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0))),
          child:  Stack(children: [
            Visibility(
                visible: controller.isError.isFalse,
                child: _buildMainView(context,controller)),
            Visibility(
              visible: controller.isError.value,
              child: EmptyDataView(
                  title: errorText ?? ChatHelpers.instance.errorMissingData,
                  isButton: false,
                  image: errorImage ?? ChatHelpers.instance.somethingWentWrong),
            )
          ])),
    ));
  }

  Widget _buildMainView(BuildContext context, T controller){
    return Column(
      children: [
        _searchView(context, controller),
        MaterialButton(
          onPressed: () {  },
          child: Text("View muted bids",style: ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeLarge, ChatHelpers.mainColor),).paddingSymmetric(vertical: ChatHelpers.marginSizeSmall,horizontal: ChatHelpers.marginSizeExtraSmall),
        ),
      ],
    );
  }


  Widget _searchView(BuildContext context, T controller){
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.symmetric(horizontal: ChatHelpers.marginSizeExtraSmall,vertical: ChatHelpers.marginSizeSmall),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: CommonTextField(
              onValueChanged: (String? value) {
                return value;
              },
              marginValue: ChatHelpers.marginSizeDefault,
              controller: controller.searchBarController,
              hintText: 'Search',
              validator: (String? value) {
                return '';
              },
              prefixIcon: CircleIconButton(
                boxColor: ChatHelpers.transparent,
                isImage: false,
                height: 15,
                width: 15,
                shapeRec: false,
                icons: Icons.search,
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(width: ChatHelpers.marginSizeSmall,),
          GestureDetector(onTap: (){},child: Image.asset(ChatHelpers.instance.filterIcon)),
        ],
      ),
    );
  }

  Widget _usersListView(BuildContext context, T controller){
    return Column(
      children: List.generate(, generator),
    );
  }

}
