class AlarmResponse {
  final String message;
  final int status;
  final DateTime time;
  final String deviceName;

  /// THÊM
  final String reason;
  final String creationTime;

  AlarmResponse({
    required this.message,
    required this.status,
    required this.time,
    required this.deviceName,

    /// THÊM
    required this.reason,
    required this.creationTime,
  });

  factory AlarmResponse.fromJson(Map<String, dynamic> json) {

    final creation =
        json['creationTime'] ??
            json['creation_time'] ??
            '';

    return AlarmResponse(

      /// API cũ
      message:
      json['message'] ??
          json['reason'] ??
          '',

      status: json['status'] ?? 0,

      time: DateTime.tryParse(creation) ?? DateTime.now(),

      deviceName:
      json['meterDto']?['name'] ??
          json['deviceName'] ??
          '',

      /// API mới
      reason: json['reason'] ?? '',

      creationTime: creation,
    );
  }
}