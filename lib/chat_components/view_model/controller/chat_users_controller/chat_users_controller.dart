import 'package:chat_component/chat_components/model/models/user_model/chat_user_model.dart';
import 'package:chat_component/chat_components/model/network_services/networking/result/language_extensions.dart';
import 'package:chat_component/chat_components/view/widgets/pagination_view/pagination_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../model/network_services/networking/base_model/base_model.dart';
import '../../../model/network_services/networking/repo/api_repo.dart';
import '../../../model/network_services/networking/result/apiresult.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';

class ChatUsersController extends GetxController with WidgetsBindingObserver {
  RxBool isError = false.obs;

  TextEditingController searchBarController = TextEditingController();

  ApiRepo apiRepo = GetIt.instance();

  RxBool isLoading = true.obs;


  PaginationViewController<ChatUserModal> userPaginationController =
  PaginationViewController(
      showMessage: "No more users found",
      totalPageCont: 0,
      onScrollDownDone: (bool value, int pageNumber) {},
      itemList: <ChatUserModal>[].obs);

  Future<void> getUsers() async {
    try {
      isLoading.call(true);
      await apiRepo.getUsersList(messagesBody: {
        "page_number": "1",
        "page_size": "20",
        "sort_by": "company_name",
        "sort_order": "asc"
      }).mapSuccess((value, msg) {
        isLoading.call(true);
        PagedDataMessages<List<ChatUserModal>> pagedDataMessages = value;
        userPaginationController.itemList.value = pagedDataMessages.data ?? [];
        userPaginationController.totalPageCont = pagedDataMessages.total ?? 0;
        return ApiResult.success(data: value, message: msg);
      }).mapFailure((failure) async {
        isLoading.call(false);
        return ApiResult.failure(failure: failure);
      });
      return;
    } catch (e) {
      isLoading.call(true);
      logPrint("error message fetch : $e");
    }
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    await getUsers();
  }

}
