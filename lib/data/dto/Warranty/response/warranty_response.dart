class WarrantyResponse {
  final int id;
  final int deviceId;
  final String? startDate;
  final String? endDate;
  final String? provider;

  WarrantyResponse({
    required this.id,
    required this.deviceId,
    this.startDate,
    this.endDate,
    this.provider,
  });

  factory WarrantyResponse.fromJson(Map<String, dynamic> json) {
    return WarrantyResponse(
      id: json['id'] ?? 0,
      deviceId: json['deviceId'] ?? 0,
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
      provider: json['provider']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deviceId': deviceId,
      'startDate': startDate,
      'endDate': endDate,
      'provider': provider,
    };
  }
}