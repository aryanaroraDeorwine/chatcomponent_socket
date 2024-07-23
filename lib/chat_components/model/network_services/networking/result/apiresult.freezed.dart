// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apiresult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApiResult<S> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data, String message) success,
    required TResult Function(Failure failure) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data, String message)? success,
    TResult? Function(Failure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data, String message)? success,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S> value) success,
    required TResult Function(_Failure<S> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<S> value)? success,
    TResult? Function(_Failure<S> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S> value)? success,
    TResult Function(_Failure<S> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResultCopyWith<S, $Res> {
  factory $ApiResultCopyWith(
          ApiResult<S> value, $Res Function(ApiResult<S>) then) =
      _$ApiResultCopyWithImpl<S, $Res, ApiResult<S>>;
}

/// @nodoc
class _$ApiResultCopyWithImpl<S, $Res, $Val extends ApiResult<S>>
    implements $ApiResultCopyWith<S, $Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<S, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<S> value, $Res Function(_$SuccessImpl<S>) then) =
      __$$SuccessImplCopyWithImpl<S, $Res>;
  @useResult
  $Res call({S data, String message});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<S, $Res>
    extends _$ApiResultCopyWithImpl<S, $Res, _$SuccessImpl<S>>
    implements _$$SuccessImplCopyWith<S, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<S> _value, $Res Function(_$SuccessImpl<S>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = null,
  }) {
    return _then(_$SuccessImpl<S>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as S,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<S> with DiagnosticableTreeMixin implements _Success<S> {
  const _$SuccessImpl({required this.data, required this.message});

  @override
  final S data;
  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApiResult<$S>.success(data: $data, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApiResult<$S>.success'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<S> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<S, _$SuccessImpl<S>> get copyWith =>
      __$$SuccessImplCopyWithImpl<S, _$SuccessImpl<S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data, String message) success,
    required TResult Function(Failure failure) failure,
  }) {
    return success(data, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data, String message)? success,
    TResult? Function(Failure failure)? failure,
  }) {
    return success?.call(data, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data, String message)? success,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S> value) success,
    required TResult Function(_Failure<S> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<S> value)? success,
    TResult? Function(_Failure<S> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S> value)? success,
    TResult Function(_Failure<S> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<S> implements ApiResult<S> {
  const factory _Success(
      {required final S data,
      required final String message}) = _$SuccessImpl<S>;

  S get data;
  String get message;
  @JsonKey(ignore: true)
  _$$SuccessImplCopyWith<S, _$SuccessImpl<S>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<S, $Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl<S> value, $Res Function(_$FailureImpl<S>) then) =
      __$$FailureImplCopyWithImpl<S, $Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<S, $Res>
    extends _$ApiResultCopyWithImpl<S, $Res, _$FailureImpl<S>>
    implements _$$FailureImplCopyWith<S, $Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl<S> _value, $Res Function(_$FailureImpl<S>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$FailureImpl<S>(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$FailureImpl<S> with DiagnosticableTreeMixin implements _Failure<S> {
  const _$FailureImpl({required this.failure});

  @override
  final Failure failure;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApiResult<$S>.failure(failure: $failure)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApiResult<$S>.failure'))
      ..add(DiagnosticsProperty('failure', failure));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl<S> &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<S, _$FailureImpl<S>> get copyWith =>
      __$$FailureImplCopyWithImpl<S, _$FailureImpl<S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data, String message) success,
    required TResult Function(Failure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data, String message)? success,
    TResult? Function(Failure failure)? failure,
  }) {
    return failure?.call(this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data, String message)? success,
    TResult Function(Failure failure)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<S> value) success,
    required TResult Function(_Failure<S> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<S> value)? success,
    TResult? Function(_Failure<S> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<S> value)? success,
    TResult Function(_Failure<S> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure<S> implements ApiResult<S> {
  const factory _Failure({required final Failure failure}) = _$FailureImpl<S>;

  Failure get failure;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<S, _$FailureImpl<S>> get copyWith =>
      throw _privateConstructorUsedError;
}
