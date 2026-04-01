class ElectricReport {
  final String? type;
  final Tou tou;
  final List<Tier> tiers;

  ElectricReport({
    this.type,
    required this.tou,
    required this.tiers,
  });

  factory ElectricReport.fromJson(Map<String, dynamic> json) {
    return ElectricReport(
      type: json['type'],
      tou: Tou.fromJson(json['tou'] ?? {}),
      tiers: (json['tiers'] as List? ?? [])
          .map((e) => Tier.fromJson(e))
          .toList(),
    );
  }
}

class Tou {
  final double totalKwh;
  final double totalCost;
  final double totalWithVat;

  Tou({
    required this.totalKwh,
    required this.totalCost,
    required this.totalWithVat,
  });

  factory Tou.fromJson(Map<String, dynamic> json) {
    return Tou(
      totalKwh: (json['totalKwh'] ?? 0).toDouble(),
      totalCost: (json['totalCost'] ?? 0).toDouble(),
      totalWithVat: (json['totalWithVat'] ?? 0).toDouble(),
    );
  }
}

class Tier {
  final int stepOrder;
  final double price;
  final double stepCost;

  Tier({
    required this.stepOrder,
    required this.price,
    required this.stepCost,
  });

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(
      stepOrder: json['stepOrder'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      stepCost: (json['stepCost'] ?? 0).toDouble(),
    );
  }
}