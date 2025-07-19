import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_request.g.dart';

part 'meter_request.freezed.dart';

@freezed
class MeterRequest with _$MeterRequest {
  const factory MeterRequest(
      {
        @Default(0) int id,
        @Default(2) int meterTypeId,
        @Default(0) int powerStationId,
        @Default("") String name,
        @Default("") String code,
        @Default("") String description,
        @Default("") String gatewayNumber,
        @Default("") String serialNumber,
      }) = _MeterRequest;

  factory MeterRequest.fromJson(Map<String, dynamic> json) =>
      _$MeterRequestFromJson(json);
}
