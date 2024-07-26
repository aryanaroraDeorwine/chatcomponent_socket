import 'package:json_annotation/json_annotation.dart';
part 'base_model.g.dart';

@JsonSerializable()
class BaseErrorResponse {
  bool? status;
  String? message;
  String? type;
  Map<dynamic,dynamic>? errors;
  BaseErrorResponse({
    this.status,
    this.message,
    this.type,
    this.errors
  });



  factory BaseErrorResponse.fromJson(Map<String, dynamic> json) => _$BaseErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseErrorResponseToJson(this);


}


@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  bool? status;
  String? message;
  String? token;

  T? data;
  String? type;
  dynamic errors;

  BaseResponse({
    this.status,
    this.message,
    this.token,
    this.data,
    this.type,
    this.errors
  });



  factory BaseResponse.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$BaseResponseFromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseToJson(this, toJsonT);


}



@JsonSerializable(genericArgumentFactories: true)
class CommonData<T> {
  T? data;

  CommonData({
    this.data,
  });



  factory CommonData.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$CommonDataFromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$CommonDataToJson(this, toJsonT);



}

@JsonSerializable(genericArgumentFactories: true)
class PagedData<T> {


  PagedData({
    this.data,
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  T? data;
  int? total;
  int? count;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;



  factory PagedData.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$PagedDataFromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PagedDataToJson(this, toJsonT);

}

@JsonSerializable(genericArgumentFactories: true)
class PagedData2<T> {


  PagedData2({
    this.data,
    this.pagination,
  });

  T? data;
  Pagination? pagination;


  factory PagedData2.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$PagedData2FromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PagedData2ToJson(this, toJsonT);

}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagedData<T> {


  CursorPagedData({
    this.data,
    this.pagination,
  });

  T? data;
  CursorPagination? pagination;


  factory CursorPagedData.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$CursorPagedDataFromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$CursorPagedDataToJson(this, toJsonT);

}



@JsonSerializable()
class Pagination {


  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  int? total;
  int? count;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'current_page')
  int? currentPage;
  @JsonKey(name: 'last_page')
  int? lastPage;


  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);

}


@JsonSerializable()
class CursorPagination {


  CursorPagination({
    this.count,
    this.perPage,
    this.cursorName,
    this.nextCursor,
    this.previousCursor,
  });

  int? count;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'cursor_name')
  String? cursorName;
  @JsonKey(name: 'nextCursor')
  dynamic nextCursor;
  @JsonKey(name: 'previousCursor')
  dynamic previousCursor;



  factory CursorPagination.fromJson(Map<String, dynamic> json) => _$CursorPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$CursorPaginationToJson(this);

}


// @JsonSerializable()
// class Pagination {
//
//
//   Pagination({
//     this.total,
//     this.count,
//     this.perPage,
//     this.currentPage,
//     this.lastPage,
//   });
//
//   int? total;
//   int? count;
//   @JsonKey(name: 'per_page')
//   int? perPage;
//   @JsonKey(name: 'current_page')
//   int? currentPage;
//   @JsonKey(name: 'last_page')
//   int? lastPage;
//
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
//   Map<String, dynamic> toJson() => _$PaginationToJson(this);
//
// }


@JsonSerializable(genericArgumentFactories: true)
class PagedDataMessages<T> {


  PagedDataMessages({
    this.data,
    this.total,
    this.count,
    this.currentPage,
    this.pageSize,
    this.sortBy,
    this.sortOrder
  });

  T? data;
  @JsonKey(name: 'total_record_count')
  int? total;
  int? count;
  @JsonKey(name: 'page_number')
  int? currentPage;
  @JsonKey(name: 'page_size')
  int? pageSize;
  @JsonKey(name: 'created_at')
  String? sortBy;
  @JsonKey(name: 'desc')
  String? sortOrder;



  factory PagedDataMessages.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) => _$PagedDataMessagesFromJson(json,fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PagedDataMessagesToJson(this, toJsonT);

}