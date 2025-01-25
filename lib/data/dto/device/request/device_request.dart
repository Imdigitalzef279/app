import 'package:freezed_annotation/freezed_annotation.dart';
part 'device_request.g.dart';
part 'device_request.freezed.dart';

@freezed
class DeviceRequest with _$DeviceRequest {
  const factory DeviceRequest(
      {required int powerStationId,
      @Default('name asc') String sorting,
      @Default(0) int skipCount,
      @Default(10) int maxResultCount}) = _DeviceRequest;

  factory DeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRequestFromJson(json);
}
