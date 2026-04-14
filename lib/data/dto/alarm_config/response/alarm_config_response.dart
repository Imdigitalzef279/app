import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_config_response.freezed.dart';
part 'alarm_config_response.g.dart';

@freezed
class AlarmConfigResponse with _$AlarmConfigResponse {
  const factory AlarmConfigResponse({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String description,

    /// 🔥 QUAN TRỌNG
    @Default('') String logParam,
    @Default('') String queryType,
    @Default('') String queryCondition,

  }) = _AlarmConfigResponse;

  factory AlarmConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$AlarmConfigResponseFromJson(json);
}