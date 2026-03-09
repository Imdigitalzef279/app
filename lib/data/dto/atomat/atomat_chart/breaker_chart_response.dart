class BreakerChartResponse {
  final DateTime? updatedAt;
  final double? ia;
  final double? ib;
  final double? ic;
  final double? ua;
  final double? ub;
  final double? uc;
  final double? lg;
  final double? temp1;
  final double? temp2;
  final double? temp3;
  final double? temp4;
  final double? p;
  BreakerChartResponse({
    this.updatedAt,
    this.ia,
    this.ib,
    this.ic,
    this.ua,
    this.ub,
    this.uc,
    this.lg,
    this.p,
    this.temp1,
    this.temp2,
    this.temp3,
    this.temp4,
  });

  factory BreakerChartResponse.fromJson(Map<String, dynamic> json) {
    return BreakerChartResponse(
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      ia: (json['ia'] as num?)?.toDouble(),
      ib: (json['ib'] as num?)?.toDouble(),
      ic: (json['ic'] as num?)?.toDouble(),
      ua: (json['ua'] as num?)?.toDouble(),
      ub: (json['ub'] as num?)?.toDouble(),
      uc: (json['uc'] as num?)?.toDouble(),
      lg: (json['lg'] as num?)?.toDouble(),
      p: (json['p'] as num?)?.toDouble(),
      temp1: (json['temp1'] as num?)?.toDouble(),
      temp2: (json['temp2'] as num?)?.toDouble(),
      temp3: (json['temp3'] as num?)?.toDouble(),
      temp4: (json['temp4'] as num?)?.toDouble(),
    );
  }
}