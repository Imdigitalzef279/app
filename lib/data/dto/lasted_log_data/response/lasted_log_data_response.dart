import 'package:freezed_annotation/freezed_annotation.dart';

part 'lasted_log_data_response.g.dart';

part 'lasted_log_data_response.freezed.dart';

@freezed
class LastedLogDataResponse with _$LastedLogDataResponse {
  const factory LastedLogDataResponse({
    @JsonKey(name: 'ID') @Default(0) int id,
    // @JsonKey(name: 'GATEWAY_ID') @Default(0) double gatewayId,
    // @JsonKey(name: 'METER_CODE') @Default(0) double meterCode,
    @JsonKey(name: 'UPDATE_TIME') DateTime? updateTime,
    @JsonKey(name: 'METER_NAME') @Default('') String meterName,
    @JsonKey(name: 'STATUS') @Default(0) int status,
    @JsonKey(name: 'PARAM_PF') @Default('') String paramPf,
    @JsonKey(name: 'PARAM_EPI') @Default('') String paramEpi,
    @JsonKey(name: 'PARAM_EPE') @Default('') String paramEpe,
    @JsonKey(name: 'PARAM_EQL') @Default('') String paramEql,
    @JsonKey(name: 'PARAM_EQC') @Default('') String paramEqc,
    @JsonKey(name: 'PARAM_UA') @Default('') String paramUa,
    @JsonKey(name: 'PARAM_UB') @Default('') String paramUb,
    @JsonKey(name: 'PARAM_UC') @Default('') String paramUc,
    @JsonKey(name: 'PARAM_IA') @Default('') String paramIa,
    @JsonKey(name: 'PARAM_IB') @Default('') String paramIb,
    @JsonKey(name: 'PARAM_IC') @Default('') String paramIc,
    @JsonKey(name: 'PARAM_PA') @Default('') String paramPa,
    @JsonKey(name: 'PARAM_PB') @Default('') String paramPb,
    @JsonKey(name: 'PARAM_PC') @Default('') String paramPc,
    @JsonKey(name: 'PARAM_P') @Default('') String paramP,
    @JsonKey(name: 'PARAM_QA') @Default('') String paramQa,
    @JsonKey(name: 'PARAM_QB') @Default('') String paramQb,
    @JsonKey(name: 'PARAM_QC') @Default('') String paramQc,
    @JsonKey(name: 'PARAM_Q') @Default('') String paramQ,
    @JsonKey(name: 'THD') @Default('') String thd,
    @JsonKey(name: 'CT') @Default('') String ct,
    @JsonKey(name: 'THD_UA') @Default('') String thdUa,
    @JsonKey(name: 'THD_UB') @Default('') String thdUb,
    @JsonKey(name: 'THD_UC') @Default('') String thdUc,
    @JsonKey(name: 'THD_IA') @Default('') String thdIa,
    @JsonKey(name: 'THD_IB') @Default('') String thdIb,
    @JsonKey(name: 'THD_IC') @Default('') String thdIc,
  }) = _LastedLogDataResponse;

  factory LastedLogDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LastedLogDataResponseFromJson(json);
}
