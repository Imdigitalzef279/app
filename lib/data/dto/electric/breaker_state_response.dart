import 'package:freezed_annotation/freezed_annotation.dart';

part 'breaker_state_response.freezed.dart';
part 'breaker_state_response.g.dart';

@freezed
class BreakerStateResponse with _$BreakerStateResponse {
  const factory BreakerStateResponse({
    @JsonKey(name: 'gatewaySn') @Default('') String gatewaySn,
    @JsonKey(name: 'breakerSn') @Default('') String breakerSn,
    @JsonKey(name: 'addr') @Default('') String addr,
    @JsonKey(name: 'state') @Default('') String state,

    @JsonKey(name: 'rlySta') @Default(0) int rlySta,
    @JsonKey(name: 'rlyRepSta') @Default(0) int rlyRepSta,
    @JsonKey(name: 'lockSta') @Default(0) int lockSta,

    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _BreakerStateResponse;

  factory BreakerStateResponse.fromJson(Map<String, dynamic> json) =>
      _$BreakerStateResponseFromJson(json);
}