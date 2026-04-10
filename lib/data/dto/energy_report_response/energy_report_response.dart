class EnergyReportResponse {
  final DateTime time;
  final double epi;

  EnergyReportResponse({
    required this.time,
    required this.epi,
  });

  factory EnergyReportResponse.fromJson(Map<String, dynamic> json) {
    return EnergyReportResponse(
      time: DateTime.parse(json['timeLabel']),
      epi: (json['epi'] ?? 0).toDouble(),
    );
  }
}