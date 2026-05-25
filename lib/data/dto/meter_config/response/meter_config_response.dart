import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_config_response.freezed.dart';

@freezed
class MeterConfigResponse with _$MeterConfigResponse {
  const factory MeterConfigResponse({
    @Default(0) int id,
    @Default(0) int meterId,
    @Default('') String configKey,
    @Default('') String configValue,
  }) = _MeterConfigResponse;

  factory MeterConfigResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    print("====== RAW CONFIG JSON ======");
    print(json);

    return MeterConfigResponse(
      id: json['id'] ?? 0,
      meterId: json['meterId'] ?? 0,
      configKey: json['configKey'] ?? '',
      configValue: json['configValue'] ?? '',
    );
  }
}