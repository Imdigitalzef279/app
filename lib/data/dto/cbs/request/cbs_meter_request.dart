import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/data/dto/cbs/request/cbs_item.dart';
part 'cbs_meter_request.g.dart';
part 'cbs_meter_request.freezed.dart';

@freezed
class CbsMeterRequest with _$CbsMeterRequest {
  const factory CbsMeterRequest(
      {
        required int stationId,
        @Default(81) int typeId,
        @Default("KRAPOWER_KEY") String apiKey,
        @Default([]) List<CbsItem> cbsList,
      }) = _CbsMeterRequest;

  factory CbsMeterRequest.fromJson(Map<String, dynamic> json) =>
      _$CbsMeterRequestFromJson(json);
}
