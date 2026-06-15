import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/Warranty/response/warranty_response.dart';
class WarrantyRepository {
  final Dio _dio = GetIt.instance<Dio>();
  /// Lấy thông tin bảo hành
  Future<WarrantyResponse?> getWarranty(int deviceId) async {
    try {
      final response = await _dio.get(
        "/api/app/warranty/current-warranty/$deviceId",
      );
      final data = response.data;
      if (data == null) return null;
      if (data is Map<String, dynamic>) {
        return WarrantyResponse.fromJson(data);
      }
      return null;
    } on DioException catch (e) {
      print("Warranty API error: ${e.response?.data}");
      return null;
    } catch (e) {
      print("Warranty unknown error: $e");
      return null;
    }
  }
  /// Kích hoạt bảo hành
  Future<bool> activateWarranty(int deviceId) async {
    try {
      final Dio dio = GetIt.instance<Dio>();
      final now = DateTime.now().toUtc();
      final end = now.add(const Duration(days: 365));
      final body = {
        "deviceId": deviceId,
        "provider": "Solar Energy",
        "startDate": now.toIso8601String(),
        "endDate": end.toIso8601String(),
        "note": "Activate from mobile app",
        "status": 0
      };
      print("Activate warranty body: $body");
      await dio.post(
        "/api/app/warranty",
        data: body,
      );
      return true;
    } on DioException catch (e) {
      print("Activate warranty API error: ${e.response?.data}");
      return false;
    } catch (e) {
      print("Activate warranty unknown error: $e");
      return false;
    }
  }
  Future<dynamic> activateViaQr({
    required String qrCode,
    int? projectId,
    int? powerStationId,
  }) async {
    try {

      debugPrint("=== ACTIVATE VIA QR ===");
      debugPrint("qrCode = $qrCode");
      debugPrint("projectId = $projectId");
      debugPrint("powerStationId = $powerStationId");

      final response = await _dio.post(
        "/api/app/warranty/activate-via-qr",
        data: {
          "qrCode": qrCode,
          "projectId": projectId,
          "powerStationId": powerStationId,
        },
      );

      debugPrint("STATUS = ${response.statusCode}");
      debugPrint("RESPONSE = ${response.data}");

      return response.data;

    } on DioException catch (e) {

      debugPrint("STATUS ERROR = ${e.response?.statusCode}");
      debugPrint("ERROR DATA = ${e.response?.data}");

      rethrow;
    }
  }
}