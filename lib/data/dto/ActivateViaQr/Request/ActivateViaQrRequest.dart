class ActivateViaQrRequest {
  final String qrCode;
  final int? projectId;
  final int? powerStationId;

  ActivateViaQrRequest({
    required this.qrCode,
    this.projectId,
    this.powerStationId,
  });

  Map<String, dynamic> toJson() => {
    "qrCode": qrCode,
    "projectId": projectId,
    "powerStationId": powerStationId,
  };
}