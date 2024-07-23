import 'dart:async';

import 'apiresult.dart';
import 'failures.dart';




void doNothing({required String because}) => {};

extension FutureExtension<T> on Future<ApiResult<T>> {
  Future<R> when<R>({
    required FutureOr<R> Function(T value,String msg) success,
    required FutureOr<R> Function(Failure failure) failure,
    Function? onError,
  }) =>
      then(
        (value) => value.when(
          success: (data,msg) => success(data,msg),
          failure: (theFailure) => failure(theFailure),
        ),
      );

  Future<ApiResult<R>> mapSuccess<R>(
    FutureOr<ApiResult<R>> Function(T value,String msg) success,
  ) =>
      then(
        (value) => value.when(
          success: (data,msg) => success(data,msg),
          failure: (failure) => failure.asFailure<R>(),
        ),
      );

  Future<ApiResult<T>> mapFailure(
    FutureOr<ApiResult<T>> Function(Failure failure) failure,
  ) =>
      then(
        (value) => value.when(
          success: (data,msg) => data.asSuccess(),
          failure: (theFailure) => failure(theFailure),
        ),
      );



}
