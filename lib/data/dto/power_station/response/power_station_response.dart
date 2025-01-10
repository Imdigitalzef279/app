import 'package:freezed_annotation/freezed_annotation.dart';
part 'power_station_response.g.dart';
part 'power_station_response.freezed.dart';
@freezed
class PowerStationResponse with _$PowerStationResponse{
  const factory PowerStationResponse({
    @Default(0) int id,
    @Default(0) int projectId,
    @Default('') String name,
    @Default('') String code,
    @Default('') String storeParam,
    @Default('') String description,
    @Default('') String planViewPath,
    @Default('') String longitude,
    @Default('') String latitude,
    @Default('') String creator,
  }) = _PowerStationResponse;

  factory PowerStationResponse.fromJson(Map<String, dynamic> json) =>
      _$PowerStationResponseFromJson(json);
}