// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseErrorResponse _$BaseErrorResponseFromJson(Map<String, dynamic> json) =>
    BaseErrorResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BaseErrorResponseToJson(BaseErrorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'type': instance.type,
      'errors': instance.errors,
    };

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      type: json['type'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'token': instance.token,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'type': instance.type,
      'errors': instance.errors,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

CommonData<T> _$CommonDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CommonData<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$CommonDataToJson<T>(
  CommonData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

PagedData<T> _$PagedDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedData<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      total: (json['total'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PagedDataToJson<T>(
  PagedData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'total': instance.total,
      'count': instance.count,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

PagedData2<T> _$PagedData2FromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedData2<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PagedData2ToJson<T>(
  PagedData2<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'pagination': instance.pagination,
    };

CursorPagedData<T> _$CursorPagedDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CursorPagedData<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      pagination: json['pagination'] == null
          ? null
          : CursorPagination.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CursorPagedDataToJson<T>(
  CursorPagedData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'pagination': instance.pagination,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.count,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
    };

CursorPagination _$CursorPaginationFromJson(Map<String, dynamic> json) =>
    CursorPagination(
      count: (json['count'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      cursorName: json['cursor_name'] as String?,
      nextCursor: json['nextCursor'],
      previousCursor: json['previousCursor'],
    );

Map<String, dynamic> _$CursorPaginationToJson(CursorPagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'per_page': instance.perPage,
      'cursor_name': instance.cursorName,
      'nextCursor': instance.nextCursor,
      'previousCursor': instance.previousCursor,
    };

PagedDataMessages<T> _$PagedDataMessagesFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedDataMessages<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      total: (json['total_record_count'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      currentPage: (json['page_number'] as num?)?.toInt(),
      pageSize: (json['page_size'] as num?)?.toInt(),
      sortBy: json['created_at'] as String?,
      sortOrder: json['desc'] as String?,
    );

Map<String, dynamic> _$PagedDataMessagesToJson<T>(
  PagedDataMessages<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'total_record_count': instance.total,
      'count': instance.count,
      'page_number': instance.currentPage,
      'page_size': instance.pageSize,
      'created_at': instance.sortBy,
      'desc': instance.sortOrder,
    };
