import 'package:freezed_annotation/freezed_annotation.dart';
part 'cbs_meter_request.g.dart';
part 'cbs_meter_request.freezed.dart';

@freezed
class CbsMeterRequest with _$CbsMeterRequest {
  const factory CbsMeterRequest(
      {
        required String gatewaySn,
        required String breakerSn,
        required String addr,
        required String commandValue,
        @Default("admin") String createdBy,
        required bool isForce

      }) = _CbsMeterRequest;

  factory CbsMeterRequest.fromJson(Map<String, dynamic> json) =>
      _$CbsMeterRequestFromJson(json);
}
