class BreakerCommand {
  final String gatewaySn;
  final String breakerSn;
  final String addr;
  final String commandValue; // "0" OFF | "1" ON
  final bool isForce;
  final String createdBy;

  BreakerCommand({
    required this.gatewaySn,
    required this.breakerSn,
    required this.addr,
    required this.commandValue,
    required this.isForce,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "gatewaySn": gatewaySn,
      "breakerSn": breakerSn,
      "addr": addr,
      "commandValue": commandValue,
      "isForce": isForce,
      "createdBy": createdBy,
    };
  }
}
