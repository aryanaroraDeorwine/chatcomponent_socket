import 'dart:io';

import 'package:chat_component/chat_components/model/models/user_model/chat_user_model.dart';
import 'package:chat_component/chat_components/view/widgets/loader/loader_view.dart';
import 'package:chat_component/chat_components/view/widgets/pagination_view/pagination_view_screen.dart';
import 'package:chat_component/chat_components/view/widgets/users_view/users_view.dart';
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
        _appBar(context,controller),
        _searchView(context, controller),
        Align(
          alignment: Alignment.centerLeft,
          child: MaterialButton(
            onPressed: () {  },
            child: Text("View muted bids",style: ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeLarge, ChatHelpers.mainColor),).paddingSymmetric(vertical: ChatHelpers.marginSizeSmall),
          ),
        ),
        Expanded(child: _usersListView(context,controller))
      ],
    ).paddingOnly(top: MediaQuery.of(context).padding.top);
  }

  Widget _appBar(BuildContext context, T controller){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,left: 15,right: 15),
      decoration: BoxDecoration(
          color: ChatHelpers.mainColor,
      ),
      child:  Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              InkWell(
                onTap: ()=>Get.back(),
                child: const SizedBox(
                  height: 38,
                  width: 38,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back,color: ChatHelpers.black,textDirection: TextDirection.ltr,),
                  ),
                ),
              ),
            Flexible(child: Center(child: Text("Chats",style: ChatHelpers.instance.styleBold(ChatHelpers.fontSizeDoubleExtraLarge, ChatHelpers.white), overflow: TextOverflow.ellipsis,))),
          ],
        ),
      ),
    );
  }

  Widget _searchView(BuildContext context, T controller){
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15)
      ),
      padding: const EdgeInsets.symmetric(horizontal: ChatHelpers.marginSizeExtraSmall,vertical: ChatHelpers.marginSizeExtraSmall),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: CommonTextField(
              onValueChanged: (String? value) {
                return value;
              },
              marginValue: ChatHelpers.marginSizeDefault,
              controller: controller.searchBarController,
              hintText: 'Search',
              maxLines: 1,
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
          const SizedBox(width: ChatHelpers.marginSizeExtraSmall,),
          GestureDetector(onTap: (){},child: Image.asset(ChatHelpers.instance.filterIcon,package: "chat_component",height: 25,width: 25,)),
        ],
      ),
    );
  }

  Widget _usersListView(BuildContext context, T controller){
    return Obx((){
      if(controller.userPaginationController.itemList.isNotEmpty) {
        return PaginationView<ChatUserModal>(
            onRefresh: (){},
            showItemList: controller.userPaginationController.itemList,
            pagingScrollController:controller.userPaginationController,
            mainView:(BuildContext context, int index,ChatUserModal itemData) {
              return UsersView(orderId: "", userProfile: itemData.chatUser?.imageWithPath ?? "", userName: itemData.chatUser?.companyName ?? "as",resentMessages: "",resentWidget: "", onTap: () {  },);
            }
        );
      }
      else if(controller.isLoading.isFalse){
        return EmptyDataView(title: "No data found", isButton: false, image: ChatHelpers.instance.somethingWentWrong,);
      }
      else {
        return const LoaderView(loaderColor: ChatHelpers.mainColor);
      }
    });
  }

}
