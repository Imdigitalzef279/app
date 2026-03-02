import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_config_request.freezed.dart';
part 'meter_config_request.g.dart';

@freezed
class MeterConfigRequest with _$MeterConfigRequest {
  const factory MeterConfigRequest({
    required int meterId,
    required String configKey,
    required int configValue,
  }) = _MeterConfigRequest;

  factory MeterConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$MeterConfigRequestFromJson(json);
}