import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_station_request.g.dart';

part 'power_station_request.freezed.dart';

@freezed
class PowerStationRequest with _$PowerStationRequest {
  const factory PowerStationRequest(
      {
        @Default(0) int projectId,
        @Default("") String name,
        @Default("") String code,
        @Default("") String description,
        @Default("") String longitude,
        @Default("") String latitude,
        @Default("") String planViewPath,
      }) = _PowerStationRequest;

  factory PowerStationRequest.fromJson(Map<String, dynamic> json) =>
      _$PowerStationRequestFromJson(json);
}
