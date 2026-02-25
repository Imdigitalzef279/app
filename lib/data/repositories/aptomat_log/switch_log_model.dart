class SwitchLogModel {
  final int id;
  final String action;
  final String method;
  final DateTime time;
  final String? user;
  final String status;
  SwitchLogModel({
    required this.id,
    required this.action,
    required this.method,
    required this.time,
    required this.status,
    this.user,
  });

  factory SwitchLogModel.fromJson(Map<String, dynamic> json) {
    return SwitchLogModel(
      id: json['id'],
      action: json['commandValue'] == "1" ? "ĐÓNG" : "MỞ",
      method: json['isForce'] == true ? "FORCE" : "APP",
      time: DateTime.parse(json['sentAt']),
      user: json['createdBy'],
      status: json['status'] ?? "",
    );
  }
}