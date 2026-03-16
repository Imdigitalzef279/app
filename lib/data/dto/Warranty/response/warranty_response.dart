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
      id: json['id'],
      deviceId: json['deviceId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      provider: json['provider'],
    );
  }
}