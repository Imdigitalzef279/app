import 'package:freezed_annotation/freezed_annotation.dart';

part 'atomat_log_response.freezed.dart';
part 'atomat_log_response.g.dart';

@freezed
class AtomatLogResponse with _$AtomatLogResponse {
  const factory AtomatLogResponse({
    @JsonKey(name: 'gatewaySn') required String gatewaySn,
    @JsonKey(name: 'breakerSn') required String breakerSn,
    @JsonKey(name: 'addr') required String addr,

    @JsonKey(name: 'state') required String state,

    @JsonKey(name: 'rlySta') required int rlySta,
    @JsonKey(name: 'lockSta') required int lockSta,
    @JsonKey(name: 'rlyRepSta') required int rlyRepSta,

    @JsonKey(name: 'lgFauSta') required int lgFauSta,
    @JsonKey(name: 't1FauSta') required int t1FauSta,
    @JsonKey(name: 't2FauSta') required int t2FauSta,
    @JsonKey(name: 't3FauSta') required int t3FauSta,
    @JsonKey(name: 't4FauSta') required int t4FauSta,
    @JsonKey(name: 'rlyFauSta') required int rlyFauSta,

    @JsonKey(name: 'alrRcrCnt') required int alrRcrCnt,
    @JsonKey(name: 'lg') required int lg,

    @JsonKey(name: 'temp1') required double temp1,
    @JsonKey(name: 'temp2') required double temp2,
    @JsonKey(name: 'temp3') required double temp3,
    @JsonKey(name: 'temp4') required double temp4,

    @JsonKey(name: 'ua') required double ua,
    @JsonKey(name: 'ub') required double ub,
    @JsonKey(name: 'uc') required double uc,
    @JsonKey(name: 'uab') required double uab,
    @JsonKey(name: 'ubc') required double ubc,
    @JsonKey(name: 'uca') required double uca,
    @JsonKey(name: 'u0') required double u0,
    @JsonKey(name: 'uub') required double uub,

    @JsonKey(name: 'ia') required double ia,
    @JsonKey(name: 'ib') required double ib,
    @JsonKey(name: 'ic') required double ic,
    @JsonKey(name: 'i0') required double i0,
    @JsonKey(name: 'iub') required double iub,

    @JsonKey(name: 'pa') required double pa,
    @JsonKey(name: 'pb') required double pb,
    @JsonKey(name: 'pc') required double pc,
    @JsonKey(name: 'p') required double p,

    @JsonKey(name: 'qa') required double qa,
    @JsonKey(name: 'qb') required double qb,
    @JsonKey(name: 'qc') required double qc,
    @JsonKey(name: 'q') required double q,

    @JsonKey(name: 'sa') required double sa,
    @JsonKey(name: 'sb') required double sb,
    @JsonKey(name: 'sc') required double sc,
    @JsonKey(name: 's') required double s,

    @JsonKey(name: 'pfa') required double pfa,
    @JsonKey(name: 'pfb') required double pfb,
    @JsonKey(name: 'pfc') required double pfc,
    @JsonKey(name: 'pf') required double pf,

    @JsonKey(name: 'fr') required double fr,

    @JsonKey(name: 'epi') required double epi,
    @JsonKey(name: 'epe') required double epe,
    @JsonKey(name: 'eql') required double eql,
    @JsonKey(name: 'eqc') required double eqc,
    @JsonKey(name: 'es') required double es,

    @JsonKey(name: 'closeCnt') required int closeCnt,
    @JsonKey(name: 'openCnt') required int openCnt,
    @JsonKey(name: 'useRate') required double useRate,

    @JsonKey(name: 'updatedAt') required String updatedAt,
  }) = _AtomatLogResponse;

  factory AtomatLogResponse.fromJson(Map<String, dynamic> json) =>
      _$AtomatLogResponseFromJson(json);
}
