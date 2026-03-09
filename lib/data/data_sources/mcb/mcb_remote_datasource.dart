
import '../../../domain/mcb/entities/breaker_command.dart';
import '../../dto/electric/breaker_state_response.dart';
import 'package:dio/dio.dart';

class McbRemoteDatasource {
  final Dio dio;

  McbRemoteDatasource(this.dio);


  Future<void> sendCommand({
    required BreakerCommand command,
    required String accessToken,
  }) async {
    final response = await dio.post(
      '/api/app/log-meter-breaker/command',
      data: command.toJson(),
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    if (response.statusCode == null || response.statusCode! >= 400) {
      throw Exception('Send breaker command failed');
    }
  }
  Future<BreakerStateResponse> getBreakerState({
    required String gatewaySn,   // nếu không dùng có thể bỏ
    required String breakerSn,
    required String addr,        // nếu không dùng có thể bỏ
  }) async {
    final response = await dio.post(
      '/api/app/log-meter-breaker/get-list',
      data: {
        "breakerSn": breakerSn,
        "fromDate": DateTime.now()
            .subtract(const Duration(hours: 1))
            .toUtc()
            .toIso8601String(),
        "toDate": DateTime.now().toUtc().toIso8601String(),
      },
    );

    if (response.statusCode == null || response.statusCode! >= 400) {
      throw Exception('Get breaker state failed');
    }

    final List data = response.data;
    return BreakerStateResponse.fromJson(data.first);
  }
}
