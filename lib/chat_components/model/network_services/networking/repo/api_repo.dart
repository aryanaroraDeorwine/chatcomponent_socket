import 'dart:io';

import 'package:chat_component/chat_components/model/models/message_model/message_model.dart';
import 'package:chat_component/chat_components/model/models/user_model/chat_user_model.dart';
import 'package:chat_component/chat_components/model/network_services/networking/result/apiresult.dart';
import 'package:dio/dio.dart';
import '../../../models/chat_model/chat_model.dart';
import '../base_model/base_model.dart';
import '../client/rest_client.dart';


class ApiRepo {
  final ApiClient client;
  CancelToken token = CancelToken();

  ApiRepo({required this.client});

  Future<ApiResult<PagedDataMessages<List<MessageModel>>>> getMessagesList({required String chatRoomId,required Map<String, dynamic> messagesBody}) async =>
      client.getMessagesList(
          chatRoomId,
          messagesBody
      ).then((response) async {
        return ApiResult.compileMap(response);
      }).catchError((error)  {
        return  ApiResult.compileFailureError<PagedDataMessages<List<MessageModel>>>(error);
      });

  Future<ApiResult<PagedDataMessages<List<ChatUserModal>>>> getUsersList({required Map<String, dynamic> messagesBody}) async =>
      client.getUsersList(
          messagesBody
      ).then((response) async {
        return ApiResult.compileMap(response);
      }).catchError((error)  {
        return  ApiResult.compileFailureError<PagedDataMessages<List<ChatUserModal>>>(error);
      });

  Future<ApiResult<FileUploadModel>> fileUpload({required File file,required String type}) async =>
      client.uploadFile(file,type).then((response) async {
        return ApiResult.compileMap(response);
      }).catchError((error)  {
        return  ApiResult.compileFailureError<FileUploadModel>(error);
      });

}
