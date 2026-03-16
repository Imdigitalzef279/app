import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/Warranty/response/warranty_response.dart';
class WarrantyRepository {
  final Dio dio = GetIt.instance<Dio>();
  Future<WarrantyResponse?> getWarranty(int deviceId) async {
    try {

      final response = await dio.get(
        "/api/app/warranty/current-warranty/$deviceId",
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        return WarrantyResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Warranty API error: $e");
      return null;
    }
  }
  Future<void> activateWarranty(int deviceId) async {
    try {
      await dio.post(
        "/api/app/warranty",
        data: {
          "deviceId": deviceId
        },
      );
    } catch (e) {
      print("activate warranty error: $e");
      print("Activate warranty deviceId: $deviceId");
    }
  }
}