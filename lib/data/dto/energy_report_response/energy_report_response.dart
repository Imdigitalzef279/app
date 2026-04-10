class Tou {
  final double totalKwh;
  final double totalCost;
  final double totalWithVat;

  final double lowKwh;
  final double midKwh;
  final double highKwh;

  Tou({
    required this.totalKwh,
    required this.totalCost,
    required this.totalWithVat,
    required this.lowKwh,
    required this.midKwh,
    required this.highKwh,
  });

  factory Tou.fromJson(Map<String, dynamic> json) {
    return Tou(
      totalKwh: (json['totalKwh'] ?? 0).toDouble(),
      totalCost: (json['totalCost'] ?? 0).toDouble(),
      totalWithVat: (json['totalWithVat'] ?? 0).toDouble(),

      lowKwh: (json['lowKwh'] ?? 0).toDouble(),
      midKwh: (json['midKwh'] ?? 0).toDouble(),
      highKwh: (json['highKwh'] ?? 0).toDouble(),
    );
  }
}