class PriceConfigResponse {
  final double priceMin;
  final double priceMax;
  final double priceAvr;

  PriceConfigResponse({
    required this.priceMin,
    required this.priceMax,
    required this.priceAvr,
  });

  factory PriceConfigResponse.fromJson(Map<String, dynamic> json) {
    return PriceConfigResponse(
      priceMin: (json['priceMin'] ?? 0).toDouble(),
      priceMax: (json['priceMax'] ?? 0).toDouble(),
      priceAvr: (json['priceAvr'] ?? 0).toDouble(),
    );
  }
}