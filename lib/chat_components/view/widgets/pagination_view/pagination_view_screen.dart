import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../model/chatHelper/chat_helper.dart';
import '../../../model/services/chat_services.dart';
import '../loader/loader_view.dart';


class PaginationView<T> extends StatelessWidget {
  final List<T> showItemList;
  final Widget Function(BuildContext context, int index , T itemData) mainView;
  final EdgeInsets ?sidePadding;
  final Axis? scrollDirection;
  final PaginationViewController<T> pagingScrollController;
  final Function onRefresh;
  const PaginationView({super.key, required this.showItemList,required this.mainView, this.sidePadding, this.scrollDirection,required this.pagingScrollController,required this.onRefresh});
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: pagingScrollController.scrollController,
      physics:const AlwaysScrollableScrollPhysics(),
      padding: sidePadding??EdgeInsets.zero,
      reverse: true,
      scrollDirection: scrollDirection ?? Axis.vertical,
      children: [
        ...List.generate(showItemList.length, (index) => mainView(context, index , pagingScrollController.itemList.elementAt(index))).reversed,
        Obx(()=>Padding(
          padding:const EdgeInsets.only(bottom: 20.0,top: 10),
          child: Visibility(
            visible: pagingScrollController.isLoading.value,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Loading".tr,style: ChatHelpers.instance.styleSemiBold(ChatHelpers.fontSizeLarge, ChatHelpers.black),),
                const SizedBox(width: ChatHelpers.marginSizeExtraSmall,),
                Get.find<ChatServices>().chatArguments.themeArguments?.customWidgetsArguments?.customLoaderWidgets ?? const LoaderView(size: 10,loaderColor: ChatHelpers.mainColor)
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class PaginationViewController<T>{
  int totalPageCont;
  Function(bool,int) onScrollDownDone;
  String ?showMessage;
  RxInt currentPage= 1.obs;
  RxBool isLoading= false.obs;
  RxList<T> itemList = <T>[].obs;

  ScrollController scrollController = ScrollController();
  PaginationViewController({required this.totalPageCont,required this.onScrollDownDone,this.showMessage,required this.itemList}){
    scrollController.addListener(_addListener);
  }
  get _addListener =>(){
    if(scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (scrollController.position.maxScrollExtent  == scrollController.position.pixels) {
        currentPage++;
        if (totalPageCont >= currentPage.value) {
          onScrollDownDone(true,currentPage.value);
        }else{
          onScrollDownDone(false,currentPage.value);
          // toastShow(massage: showMessage??"No More data found yet.");
        }
      }
    }
  };
}


