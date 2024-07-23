import 'package:chat_component/chat_components/model/models/message_model/message_model.dart';
import 'package:chat_component/chat_components/model/network_services/networking/result/apiresult.dart';
import 'package:dio/dio.dart';
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

}
