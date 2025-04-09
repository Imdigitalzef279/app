import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_type_response.g.dart';

part 'meter_type_response.freezed.dart';

@freezed
class MeterTypeResponse with _$MeterTypeResponse {
  const factory MeterTypeResponse({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String code,
    @Default('') String storeParam,
    @Default("") String creationTime,
    @Default(0) int status,
  }) = _MeterTypeResponse;

  factory MeterTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeterTypeResponseFromJson(json);
}
