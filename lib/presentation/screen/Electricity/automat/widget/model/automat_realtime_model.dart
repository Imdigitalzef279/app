class AutomatRealtimeModel {
  final double ua, ub, uc;
  final double ia, ib, ic;
  final double pa, pb, pc, pTotal;
  final double qa, qb, qc;
  final double sa, sb, sc;
  final double pfa, pfb, pfc;
  final double frequency;
  final double temp1, temp2, temp3;
  final String state;
  final String relayState;

  AutomatRealtimeModel({
    required this.ua,
    required this.ub,
    required this.uc,
    required this.ia,
    required this.ib,
    required this.ic,
    required this.pa,
    required this.pb,
    required this.pc,
    required this.pTotal,
    required this.qa,
    required this.qb,
    required this.qc,
    required this.sa,
    required this.sb,
    required this.sc,
    required this.pfa,
    required this.pfb,
    required this.pfc,
    required this.frequency,
    required this.temp1,
    required this.temp2,
    required this.temp3,
    required this.state,
    required this.relayState,
  });

  factory AutomatRealtimeModel.fromJson(Map<String, dynamic> json) {
    double d(String k) => double.tryParse(json[k]?.toString() ?? '0') ?? 0;

    return AutomatRealtimeModel(
      ua: d('Ua'),
      ub: d('Ub'),
      uc: d('Uc'),

      ia: d('Ia'),
      ib: d('Ib'),
      ic: d('Ic'),

      pa: d('Pa'),
      pb: d('Pb'),
      pc: d('Pc'),
      pTotal: d('P'),

      qa: d('Qa'),
      qb: d('Qb'),
      qc: d('Qc'),

      sa: d('Sa'),
      sb: d('Sb'),
      sc: d('Sc'),

      pfa: d('PFa'),
      pfb: d('PFb'),
      pfc: d('PFc'),

      frequency: d('Fr'),

      temp1: d('Temp1'),
      temp2: d('Temp2'),
      temp3: d('Temp3'),

      state: json['state'] ?? '',
      relayState: json['RlySta'] ?? '',
    );
  }
}
