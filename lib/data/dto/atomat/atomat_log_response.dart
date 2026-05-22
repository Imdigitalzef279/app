import 'package:freezed_annotation/freezed_annotation.dart';
part 'atomat_log_response.freezed.dart';
part 'atomat_log_response.g.dart';

@freezed
class AtomatLogResponse with _$AtomatLogResponse {
  const factory AtomatLogResponse({
    String? gatewaySn,
    String? breakerSn,
    @JsonKey(name: 'name')
    String? deviceName,
    String? addr,
    String? state,

    int? rlySta,
    int? lockSta,
    int? rlyRepSta,
    int? lgFauSta,
    int? t1FauSta,
    int? t2FauSta,
    int? t3FauSta,
    int? t4FauSta,
    int? rlyFauSta,
    int? alrRcrCnt,
    int? lg,

    double? temp1,
    double? temp2,
    double? temp3,
    double? temp4,

    double? ua,
    double? ub,
    double? uc,
    double? uab,
    double? ubc,
    double? uca,
    double? u0,
    double? uub,

    double? ia,
    double? ib,
    double? ic,
    double? i0,
    double? iub,

    double? pa,
    double? pb,
    double? pc,
    double? p,

    double? qa,
    double? qb,
    double? qc,
    double? q,

    double? sa,
    double? sb,
    double? sc,
    double? s,

    double? pfa,
    double? pfb,
    double? pfc,
    double? pf,

    double? fr,

    double? epi,
    double? epe,
    double? eql,
    double? eqc,
    double? es,

    int? closeCnt,
    int? openCnt,
    double? useRate,

    String? updatedAt,
  }) = _AtomatLogResponse;

  factory AtomatLogResponse.fromJson(Map<String, dynamic> json)
  => _$AtomatLogResponseFromJson(json);
}
