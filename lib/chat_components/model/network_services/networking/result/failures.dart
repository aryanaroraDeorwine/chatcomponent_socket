import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';




enum FailureStatus {
  errorCanceled,
  errorTimeOut,
  sendTimeOut,
  receiveTimeout,
  internetDisconnected,
  error_401, //logout
  error_422,
  error_400,
  serverError_500,
  dataError,
  validationError,
  noError }



abstract class Failure {
    final String message = "";
     final FailureStatus statusCode= FailureStatus.noError ;
}

@freezed
class ServerFailure extends Failure with _$ServerFailure {
  const factory ServerFailure({required FailureStatus statusCode,required String message}) = _ServerFailure;
}

@freezed
class InternetFailure extends Failure with _$InternetFailure {
  const factory InternetFailure({required FailureStatus statusCode ,required String message}) = _InternetFailure;
}

@freezed
class DataFailure extends Failure with _$DataFailure {
  const factory DataFailure({required FailureStatus statusCode ,required String message}) = _DataFailure;
}


@freezed
class UnauthorizedFailure extends Failure with _$UnauthorizedFailure {
  const factory UnauthorizedFailure({required FailureStatus statusCode ,required String message}) = _UnauthorizedFailure;
}


@freezed
class ValidationFailure extends Failure with _$ValidationFailure {
  const factory ValidationFailure({required FailureStatus statusCode ,required String message,required Map<dynamic,dynamic> errors }) = _ValidationFailure;
}

