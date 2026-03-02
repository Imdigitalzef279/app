
import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_response.freezed.dart';
part 'api_response.g.dart';


@Freezed(genericArgumentFactories: true)
class PaginationResponse<T> with _$PaginationResponse<T> {
  const factory PaginationResponse({
    @JsonKey(name: 'items') @Default([]) List<T> data,
    @JsonKey(name: 'totalCount') @Default(0) int totalCount,
  }) = _PaginationResponse<T>;

  factory PaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) => _$PaginationResponseFromJson(json, fromJsonT);
}


@Freezed(genericArgumentFactories: true)
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    @JsonKey(name: 'code') int? code,
    @JsonKey(name: 'message') @Default('') String message,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(
      Map<String, dynamic> json,
      ) => _$ErrorResponseFromJson(json);
}