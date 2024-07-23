
import 'package:chat_component/chat_components/model/network_services/networking/base_model/base_model.dart';
import 'package:chat_component/chat_components/model/services/chat_services.dart';
import 'package:chat_component/chat_components/view/widgets/log_print/log_print_condition.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

import '../../../models/message_model/message_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  factory ApiClient.create() => ApiClient(_createDio(),baseUrl: Get.find<ChatServices>().chatArguments.apiBaseUrl);


  @GET("chats/{id}/messages")
  Future<PagedDataMessages<List<MessageModel>>> getMessagesList(
      @Path('id') String chatRoomId,
      @Queries() Map<String, dynamic> queries
      );


}








Dio _createDio() {
  final dio = Dio();




  //connect time out
  dio.options.connectTimeout = 60000; //5s
  dio.options.receiveTimeout = 60000; //3s

  // config your dio headers globally
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
         options.headers['Accept'] = 'application/json';
         String userToken = Get.find<ChatServices>().chatArguments.userToken;
         logPrint("userToken======>$userToken");
         if(userToken!=""){
           options.headers['Authorization'] = 'Bearer $userToken';
         }




         //options.headers['device_info'] = await Util.deviceInformationAsBase64();
        return handler.next(options);
      },
      onResponse:(response,handler) {
         logPrint('intercept response ${response.extra}');
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      },
        onError: (DioError e, handler) {
          logPrint('intercept error e.message');
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ),
  );

  //intercept in k debug mode
  if(kDebugMode) {
   // dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
  }


  return dio;
}
