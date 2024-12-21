
import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_response.freezed.dart';
part 'api_response.g.dart';
//
// @Freezed(genericArgumentFactories: true)
// class ApiResponse<T> with _$ApiResponse<T> {
//   const factory ApiResponse({
//     T? data,
//   }) = _ApiResponse<T>;
//
//   factory ApiResponse.fromJson(
//       Map<String, dynamic> json,
//       T Function(Object?) fromJsonT,
//       ) => _$ApiResponseFromJson(json, fromJsonT);
// }

@Freezed(genericArgumentFactories: true)
class PaginationResponse<T> with _$PaginationResponse<T> {
  const factory PaginationResponse({
    @JsonKey(name: 'items') List<T>? data,
    @JsonKey(name: 'totalCount') @Default(0) int totalCount,
  }) = _PaginationResponse<T>;

  factory PaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) => _$PaginationResponseFromJson(json, fromJsonT);
}