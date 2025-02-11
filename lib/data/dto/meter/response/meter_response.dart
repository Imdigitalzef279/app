import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/meter_type/response/meter_type_response.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

part 'meter_response.g.dart';

part 'meter_response.freezed.dart';

@freezed
class MeterResponse with _$MeterResponse {
  const factory MeterResponse({
    @Default(0) int id,
    @Default(0) int status,
    @Default(MeterTypeResponse()) MeterTypeResponse meterType,
    @Default(PowerStationResponse()) PowerStationResponse powerStation,
    @Default('') String name,
    @Default('') String code,
    @Default('') String description,
  }) = _MeterResponse;

  factory MeterResponse.fromJson(Map<String, dynamic> json) =>
      _$MeterResponseFromJson(json);
}
