class EnergyReportResponse {
  final DateTime time;
  final double p;
  final double epi;
  final double ct;
  final String source;


  EnergyReportResponse({
    required this.time,
    required this.p,
    required this.epi,
    required this.ct,
    required this.source,
  });

  factory EnergyReportResponse.fromJson(Map<String, dynamic> json) {
    return EnergyReportResponse(
      time: DateTime.parse(json['timeLabel']),
      p: (json['p'] ?? 0).toDouble(),
      epi: (json['epi'] ?? 0).toDouble(),
      ct: (json['ct'] ?? 0).toDouble(),
      source: json['source'] ?? '',
    );
  }
}