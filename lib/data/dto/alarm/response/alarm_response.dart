class AlarmResponse {
  final String message;
  final int status;
  final DateTime time;
  final String deviceName;

  AlarmResponse({
    required this.message,
    required this.status,
    required this.time,
    required this.deviceName,
  });

  factory AlarmResponse.fromJson(Map<String, dynamic> json) {
    return AlarmResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      time: DateTime.tryParse(json['creationTime'] ?? '') ?? DateTime.now(),
      deviceName: json['meterDto']?['name'] ?? '',
    );
  }
}