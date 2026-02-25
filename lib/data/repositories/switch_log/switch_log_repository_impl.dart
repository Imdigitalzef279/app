import 'package:dio/dio.dart';
import '../aptomat_log/switch_log_model.dart';
import 'switch_log_repository.dart';

class SwitchLogRepositoryImpl implements SwitchLogRepository {
  final Dio dio;

  SwitchLogRepositoryImpl(this.dio);

  @override
  Future<List<SwitchLogModel>> getLogs(String gatewaySn) async {
    final response = await dio.get(
      "/api/app/breaker-command",
      queryParameters: {
        "GatewaySn": gatewaySn,
        "SkipCount": 0,
        "MaxResultCount": 20,
      },
    );

    final items = response.data["items"] as List;

    return items
        .map((e) => SwitchLogModel.fromJson(e))
        .toList();
  }
}