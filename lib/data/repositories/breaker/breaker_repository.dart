import 'package:dio/dio.dart';

import '../../dto/breaker_command/breaker_command_dto.dart';

class BreakerRepository {
  final Dio dio;

  BreakerRepository(this.dio);

  Future<List<BreakerCommandModel>> getHistory({
    required String gatewaySn,
    required String breakerSn,
  }) async {
    final response = await dio.get(
      '/api/app/breaker-command',
      queryParameters: {
        'GatewaySn': gatewaySn,
        'BreakerSn': breakerSn,
        'SkipCount': 0,
        'MaxResultCount': 20,
      },
    );

    final List items = response.data['items'];

    return items
        .map((e) => BreakerCommandModel.fromJson(e))
        .toList();
  }
}