import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_response.freezed.dart';
part 'result_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ResultResponse<T> with _$ResultResponse<T> {
  const factory ResultResponse({
    T? result,
  }) = _ResultResponse<T>;

  factory ResultResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) =>
      _$ResultResponseFromJson(json, fromJsonT);
}