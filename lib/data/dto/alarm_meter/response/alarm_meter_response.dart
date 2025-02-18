import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/alarm_config/response/alarm_config_response.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';

part 'alarm_meter_response.g.dart';

part 'alarm_meter_response.freezed.dart';

@freezed
class AlarmMeterResponse with _$AlarmMeterResponse {
  const factory AlarmMeterResponse(
      {@Default(0) int id,
      @Default(0) int status,
      @JsonKey(name: 'meterDto') @Default(MeterResponse()) MeterResponse meter,
      @JsonKey(name: 'alarmConfigDto') @Default(AlarmConfigResponse()) AlarmConfigResponse alarmConfig,
      @Default('') String message,
      @Default('') String reason,
      DateTime? creationTime,
      DateTime? resolvedTime}) = _AlarmMeterResponse;

  factory AlarmMeterResponse.fromJson(Map<String, dynamic> json) =>
      _$AlarmMeterResponseFromJson(json);
}
