// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServerFailure {
  FailureStatus get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ServerFailureCopyWith<ServerFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerFailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(
          ServerFailure value, $Res Function(ServerFailure) then) =
      _$ServerFailureCopyWithImpl<$Res, ServerFailure>;
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class _$ServerFailureCopyWithImpl<$Res, $Val extends ServerFailure>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $ServerFailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
          _$ServerFailureImpl value, $Res Function(_$ServerFailureImpl) then) =
      __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$ServerFailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
      _$ServerFailureImpl _value, $Res Function(_$ServerFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$ServerFailureImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServerFailureImpl implements _ServerFailure {
  const _$ServerFailureImpl({required this.statusCode, required this.message});

  @override
  final FailureStatus statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'ServerFailure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);
}

abstract class _ServerFailure implements ServerFailure {
  const factory _ServerFailure(
      {required final FailureStatus statusCode,
      required final String message}) = _$ServerFailureImpl;

  @override
  FailureStatus get statusCode;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InternetFailure {
  FailureStatus get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InternetFailureCopyWith<InternetFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetFailureCopyWith<$Res> {
  factory $InternetFailureCopyWith(
          InternetFailure value, $Res Function(InternetFailure) then) =
      _$InternetFailureCopyWithImpl<$Res, InternetFailure>;
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class _$InternetFailureCopyWithImpl<$Res, $Val extends InternetFailure>
    implements $InternetFailureCopyWith<$Res> {
  _$InternetFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternetFailureImplCopyWith<$Res>
    implements $InternetFailureCopyWith<$Res> {
  factory _$$InternetFailureImplCopyWith(_$InternetFailureImpl value,
          $Res Function(_$InternetFailureImpl) then) =
      __$$InternetFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class __$$InternetFailureImplCopyWithImpl<$Res>
    extends _$InternetFailureCopyWithImpl<$Res, _$InternetFailureImpl>
    implements _$$InternetFailureImplCopyWith<$Res> {
  __$$InternetFailureImplCopyWithImpl(
      _$InternetFailureImpl _value, $Res Function(_$InternetFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$InternetFailureImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InternetFailureImpl implements _InternetFailure {
  const _$InternetFailureImpl(
      {required this.statusCode, required this.message});

  @override
  final FailureStatus statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'InternetFailure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternetFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternetFailureImplCopyWith<_$InternetFailureImpl> get copyWith =>
      __$$InternetFailureImplCopyWithImpl<_$InternetFailureImpl>(
          this, _$identity);
}

abstract class _InternetFailure implements InternetFailure {
  const factory _InternetFailure(
      {required final FailureStatus statusCode,
      required final String message}) = _$InternetFailureImpl;

  @override
  FailureStatus get statusCode;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$InternetFailureImplCopyWith<_$InternetFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DataFailure {
  FailureStatus get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataFailureCopyWith<DataFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataFailureCopyWith<$Res> {
  factory $DataFailureCopyWith(
          DataFailure value, $Res Function(DataFailure) then) =
      _$DataFailureCopyWithImpl<$Res, DataFailure>;
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class _$DataFailureCopyWithImpl<$Res, $Val extends DataFailure>
    implements $DataFailureCopyWith<$Res> {
  _$DataFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataFailureImplCopyWith<$Res>
    implements $DataFailureCopyWith<$Res> {
  factory _$$DataFailureImplCopyWith(
          _$DataFailureImpl value, $Res Function(_$DataFailureImpl) then) =
      __$$DataFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class __$$DataFailureImplCopyWithImpl<$Res>
    extends _$DataFailureCopyWithImpl<$Res, _$DataFailureImpl>
    implements _$$DataFailureImplCopyWith<$Res> {
  __$$DataFailureImplCopyWithImpl(
      _$DataFailureImpl _value, $Res Function(_$DataFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$DataFailureImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DataFailureImpl implements _DataFailure {
  const _$DataFailureImpl({required this.statusCode, required this.message});

  @override
  final FailureStatus statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'DataFailure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataFailureImplCopyWith<_$DataFailureImpl> get copyWith =>
      __$$DataFailureImplCopyWithImpl<_$DataFailureImpl>(this, _$identity);
}

abstract class _DataFailure implements DataFailure {
  const factory _DataFailure(
      {required final FailureStatus statusCode,
      required final String message}) = _$DataFailureImpl;

  @override
  FailureStatus get statusCode;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$DataFailureImplCopyWith<_$DataFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UnauthorizedFailure {
  FailureStatus get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UnauthorizedFailureCopyWith<UnauthorizedFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnauthorizedFailureCopyWith<$Res> {
  factory $UnauthorizedFailureCopyWith(
          UnauthorizedFailure value, $Res Function(UnauthorizedFailure) then) =
      _$UnauthorizedFailureCopyWithImpl<$Res, UnauthorizedFailure>;
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class _$UnauthorizedFailureCopyWithImpl<$Res, $Val extends UnauthorizedFailure>
    implements $UnauthorizedFailureCopyWith<$Res> {
  _$UnauthorizedFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnauthorizedFailureImplCopyWith<$Res>
    implements $UnauthorizedFailureCopyWith<$Res> {
  factory _$$UnauthorizedFailureImplCopyWith(_$UnauthorizedFailureImpl value,
          $Res Function(_$UnauthorizedFailureImpl) then) =
      __$$UnauthorizedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FailureStatus statusCode, String message});
}

/// @nodoc
class __$$UnauthorizedFailureImplCopyWithImpl<$Res>
    extends _$UnauthorizedFailureCopyWithImpl<$Res, _$UnauthorizedFailureImpl>
    implements _$$UnauthorizedFailureImplCopyWith<$Res> {
  __$$UnauthorizedFailureImplCopyWithImpl(_$UnauthorizedFailureImpl _value,
      $Res Function(_$UnauthorizedFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$UnauthorizedFailureImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnauthorizedFailureImpl implements _UnauthorizedFailure {
  const _$UnauthorizedFailureImpl(
      {required this.statusCode, required this.message});

  @override
  final FailureStatus statusCode;
  @override
  final String message;

  @override
  String toString() {
    return 'UnauthorizedFailure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      __$$UnauthorizedFailureImplCopyWithImpl<_$UnauthorizedFailureImpl>(
          this, _$identity);
}

abstract class _UnauthorizedFailure implements UnauthorizedFailure {
  const factory _UnauthorizedFailure(
      {required final FailureStatus statusCode,
      required final String message}) = _$UnauthorizedFailureImpl;

  @override
  FailureStatus get statusCode;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ValidationFailure {
  FailureStatus get statusCode => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Map<dynamic, dynamic> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidationFailureCopyWith<ValidationFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationFailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(
          ValidationFailure value, $Res Function(ValidationFailure) then) =
      _$ValidationFailureCopyWithImpl<$Res, ValidationFailure>;
  @useResult
  $Res call(
      {FailureStatus statusCode, String message, Map<dynamic, dynamic> errors});
}

/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res, $Val extends ValidationFailure>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(_$ValidationFailureImpl value,
          $Res Function(_$ValidationFailureImpl) then) =
      __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FailureStatus statusCode, String message, Map<dynamic, dynamic> errors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$ValidationFailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(_$ValidationFailureImpl _value,
      $Res Function(_$ValidationFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? errors = null,
  }) {
    return _then(_$ValidationFailureImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as FailureStatus,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc

class _$ValidationFailureImpl implements _ValidationFailure {
  const _$ValidationFailureImpl(
      {required this.statusCode,
      required this.message,
      required final Map<dynamic, dynamic> errors})
      : _errors = errors;

  @override
  final FailureStatus statusCode;
  @override
  final String message;
  final Map<dynamic, dynamic> _errors;
  @override
  Map<dynamic, dynamic> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  String toString() {
    return 'ValidationFailure(statusCode: $statusCode, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message,
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
          this, _$identity);
}

abstract class _ValidationFailure implements ValidationFailure {
  const factory _ValidationFailure(
      {required final FailureStatus statusCode,
      required final String message,
      required final Map<dynamic, dynamic> errors}) = _$ValidationFailureImpl;

  @override
  FailureStatus get statusCode;
  @override
  String get message;
  @override
  Map<dynamic, dynamic> get errors;
  @override
  @JsonKey(ignore: true)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
