import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import 'package:solar_energy/data/dto/meter_type/response/meter_type_response.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import '../../atomat/atomat_log_response.dart';

part 'device_response.g.dart';

part 'device_response.freezed.dart';

@freezed
class DeviceResponse with _$DeviceResponse {
  const factory DeviceResponse({
    @Default(0) int meterTypeId,
    @Default(0) int id,
    @Default(0) int projectId,
    @Default(0) int powerStationId,
    @Default(0) int status,
    @Default('') String name,
    @Default('') String code,
    @Default('') String description,
    @Default('') String serialNumber,
    @Default('') String creator,
    @Default(0) int parentId,
    @Default(0) int level,
    @Default("") String creationTime,
    @Default('') String gatewayNumber,
    @Default('') String avatar,
    @Default(false) bool isFavorite,
    @Default(MeterTypeResponse()) MeterTypeResponse meterType,
    @Default(PowerStationResponse()) PowerStationResponse powerStation,


    @JsonKey(name: "lastedLogData")
    LastedLogDataResponse? lastedLogData,
    AtomatLogResponse? realtimeLog,
    @Default(0) int rlyRepSta,
  }) = _DeviceResponse;

  factory DeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceResponseFromJson(json);
}
