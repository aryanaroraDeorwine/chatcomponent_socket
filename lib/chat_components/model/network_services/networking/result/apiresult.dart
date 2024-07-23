
import 'package:chat_component/chat_components/view/widgets/log_print/log_print_condition.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

import '../base_model/base_model.dart';
import 'failures.dart';

part 'apiresult.freezed.dart';

@freezed
class ApiResult<S> with _$ApiResult<S> {

  const factory ApiResult.success({required S data,required String message}) = _Success<S>;
  const factory ApiResult.failure({required Failure failure}) = _Failure;

  factory ApiResult.noDataSuccess({required String message}) => ApiResult.success(data: (() {})(),message: message) as _Success<S>;
  factory ApiResult.completed() => ApiResult.success(data: (() {})(),message: "") as _Success<S>;



  static ApiResult<BaseResponse<T>> compileBaseSuccess<T>(BaseResponse<T> response) {
    if (response.status!) {
      return ApiResult<BaseResponse<T>>.success(data: response,message:response.message??'' );
    } else {
      if (response.errors != null) {

        logPrint('errrrorType:${response.errors.runtimeType}');

        if(response.errors is Map<dynamic,dynamic>)
          {
            return ApiResult<BaseResponse<T>>.failure(
            failure: ValidationFailure(
                statusCode: FailureStatus.validationError,
                message: "", errors: response.errors!));
          }
         else{
          return ApiResult<BaseResponse<T>>.failure(
              failure:  DataFailure(
                  statusCode: FailureStatus.dataError,
                  message: response.errors.toString()));
        }

      }
      else{
        return ApiResult<BaseResponse<T>>.failure(
            failure:  DataFailure(
                statusCode: FailureStatus.dataError,
                message: response.message!));
      }
    }
  }

  static ApiResult<T> compileMap<T>(T response) {
      return ApiResult<T>.success(data: response,message:'' );
  }


  static ApiResult<T> compileSuccess<T>(BaseResponse<T> response) {
    if (response.status! && response.data != null) {
      return ApiResult<T>.success(data: response.data!,message:response.message??'' );
    }
    else if(response.status! && response.data == null){
      return ApiResult<T>.noDataSuccess(message: response.message??'');

    }else {
      if (response.errors != null) {
        logPrint('errrrorType:${response.errors.runtimeType}');

        if(response.errors is Map<dynamic,dynamic>)
        {
          return ApiResult<T>.failure(
              failure: ValidationFailure(
                  statusCode: FailureStatus.validationError,
                  message: "", errors: response.errors!));
        }
        else{
          return ApiResult<T>.failure(
              failure:  DataFailure(
                  statusCode: FailureStatus.dataError,
                  message: response.errors.toString()));
        }

      }
      else{
        return ApiResult<T>.failure(
            failure:  DataFailure(
                statusCode: FailureStatus.dataError,
                message: response.message!));
      }
    }
  }



  static ApiResult<T> compileFailureError<T>(dynamic error) {
    logPrint('in compile failure error: ${error.toString()}');


    if (error.runtimeType == DioError) {
      switch ((error as DioError).type) {
        case DioErrorType.cancel:
          return ApiResult<T>.failure(
              failure:  ServerFailure(
                  statusCode: FailureStatus.errorCanceled, message: "Request to API server was cancelled".tr));

        case DioErrorType.connectTimeout:
          return ApiResult<T>.failure(
              failure:  ServerFailure(
                  statusCode: FailureStatus.errorTimeOut, message: "Connection timeout with API server".tr));

        case DioErrorType.other:

          return ApiResult<T>.failure(
              failure:  InternetFailure(
                  statusCode: FailureStatus.internetDisconnected, message: "Connection to API server failed due to internet connection".tr));


        case DioErrorType.receiveTimeout:
          return ApiResult<T>.failure(
              failure:  ServerFailure(
                  statusCode: FailureStatus.receiveTimeout, message: "Receive timeout in connection with API server".tr));

        case DioErrorType.sendTimeout :
          return ApiResult<T>.failure(
              failure:  ServerFailure(
                  statusCode: FailureStatus.sendTimeOut, message: "Send timeout with server".tr));


        case DioErrorType.response:

          logPrint('heyyy :==> ${error.response?.data.toString()}');


          if(error.response == null || error.response?.statusCode == null){
            return ApiResult<T>.failure(
                failure:  ServerFailure(
                    statusCode: FailureStatus.serverError_500, message: "Server Error".tr));

          }
          else if(error.response?.data == null){
           return ApiResult<T>.failure(
               failure: ServerFailure(
                     statusCode: FailureStatus.serverError_500, message:(error.response?.statusMessage??'')));
          }
          else if(error.response!.statusCode! ==  401){
            // if(AuthService.find().isLogin.value){
            //   AuthService.find().logout();
            // }

            BaseErrorResponse errorResponse = BaseErrorResponse.fromJson(error.response?.data);

            return ApiResult<T>.failure(
                failure:  UnauthorizedFailure(
                    statusCode: FailureStatus.error_401, message: errorResponse.message??''));

          }
          else if(error.response!.statusCode! ==  400){

            logPrint('heyyy :==> ${error.response?.data.toString()}');

            BaseErrorResponse errorResponse = BaseErrorResponse.fromJson(error.response?.data);

            if (errorResponse.type != null &&
                errorResponse.type == "validation" &&
                errorResponse.errors != null) {
              return ApiResult<T>.failure(
                  failure: ValidationFailure(
                      statusCode: FailureStatus.validationError,
                      message: "", errors: errorResponse.errors!));
            }
            else{
              return ApiResult<T>.failure(
                  failure:  UnauthorizedFailure(
                      statusCode: FailureStatus.error_400, message: errorResponse.message??''));

            }

          }

          else if(error.response!.statusCode! ==  422){
            BaseErrorResponse errorResponse = BaseErrorResponse.fromJson(error.response?.data);
            if (errorResponse.type != null &&
                errorResponse.type == "validation" &&
                errorResponse.errors != null) {
              return ApiResult<T>.failure(
                  failure: ValidationFailure(
                      statusCode: FailureStatus.validationError,
                      message: "", errors: errorResponse.errors!));
            }
            else{
              return ApiResult<T>.failure(
                  failure:  ServerFailure(
                      statusCode: FailureStatus.error_422,
                      message: errorResponse.message??''));
            }
          }
          else{
            return ApiResult<T>.failure(
                failure:  ServerFailure(
                    statusCode: FailureStatus.serverError_500,
                    message: error.response?.statusMessage??''));
          }

      }
    }
    else{
      return ApiResult<T>.failure(
          failure: ServerFailure(
              statusCode: FailureStatus.serverError_500, message:error.toString()));

    }

  }

}



extension AsSuccess<T> on T {
  ApiResult<T> asSuccess() => ApiResult<T>.success(data: this,message: "");
}

extension AsFailure on Failure {
  ApiResult<T> asFailure<T>() => ApiResult<T>.failure(failure: this);
}