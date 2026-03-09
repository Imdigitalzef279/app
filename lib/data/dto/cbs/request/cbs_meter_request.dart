import 'package:freezed_annotation/freezed_annotation.dart';
part 'cbs_meter_request.g.dart';
part 'cbs_meter_request.freezed.dart';
// request DTO app - server, gửi lệnh đóng cắt từ app lên backend api
@freezed
class CbsMeterRequest with _$CbsMeterRequest {
  const factory CbsMeterRequest({
    required String gatewaySn,
    required String breakerSn,
    required String addr,
    required String commandValue,
    required String createdBy,
    required bool isForce,
  }) = _CbsMeterRequest;

  factory CbsMeterRequest.fromJson(Map<String, dynamic> json)
  => _$CbsMeterRequestFromJson(json);
}
