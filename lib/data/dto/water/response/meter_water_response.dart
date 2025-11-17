import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_water_response.g.dart';

part 'meter_water_response.freezed.dart';

@freezed
class MeterWaterResponse with _$MeterWaterResponse {
  const factory MeterWaterResponse({
    @Default(0) int id,
    @Default(0) int meterCode,
    @Default("") String updateTime,
    @Default("") String value,
    @Default("") String state,
  }) = _MeterWaterResponse;

  factory MeterWaterResponse.fromJson(Map<String, dynamic> json) =>
      _$MeterWaterResponseFromJson(json);

}
