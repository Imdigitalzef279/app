import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_water_request.g.dart';

part 'meter_water_request.freezed.dart';

@freezed
class MeterWaterRequest with _$MeterWaterRequest {
  const factory MeterWaterRequest({
    required int detailId,
    required int powerStationId,
    required String fromDate,
    required String toDate,
  }) = _MeterWaterRequest;

  factory MeterWaterRequest.fromJson(Map<String, dynamic> json) =>
      _$MeterWaterRequestFromJson(json);

}
