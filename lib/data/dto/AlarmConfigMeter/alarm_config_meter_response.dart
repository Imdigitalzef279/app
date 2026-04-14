import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_config_meter_response.freezed.dart';
part 'alarm_config_meter_response.g.dart';

@freezed
class AlarmConfigMeterResponse with _$AlarmConfigMeterResponse {
  const factory AlarmConfigMeterResponse({
    @Default(0) int id,
    @Default(0) int meterId,
    @Default('') String meterCode,
    @Default('') String thresholdValue,
    @Default('') String thresholdType,
  }) = _AlarmConfigMeterResponse;

  factory AlarmConfigMeterResponse.fromJson(Map<String, dynamic> json) =>
      _$AlarmConfigMeterResponseFromJson(json);
}