class BreakerCommandModel {

  final int? id;
  final String gatewaySn;
  final String breakerSn;
  final String addr;
  final String commandType;
  final String commandValue;
  final String? status;
  final String createdBy;
  final DateTime sentAt;
  final bool isForce;

  BreakerCommandModel({
    this.id,
    required this.gatewaySn,
    required this.breakerSn,
    required this.addr,
    required this.commandType,
    required this.commandValue,
    this.status,
    required this.createdBy,
    required this.sentAt,
    required this.isForce,
  });

  factory BreakerCommandModel.fromJson(Map<String, dynamic> json) {
    return BreakerCommandModel(
      id: json['id'],
      gatewaySn: json['gatewaySn'] ?? "",
      breakerSn: json['breakerSn'] ?? "",
      addr: json['addr']?.toString() ?? "",
      commandType: json['commandType'] ?? "",
      commandValue: json['commandValue'] ?? "0",
      status: json['status'],
      createdBy: json['createdBy'] ?? "",
      sentAt: json['sentAt'] != null
          ? DateTime.tryParse(json['sentAt']) ?? DateTime.now()
          : DateTime.now(),
      isForce: json['isForce'] ?? false,
    );
  }

  String get action => commandValue == "1" ? "ĐÓNG" : "CẮT";

  String get method => isForce ? "FORCE" : "APP";

  bool get isClose => commandValue == "1";
}