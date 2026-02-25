import '../../../data/dto/electric/breaker_state_response.dart';
import '../entities/breaker_command.dart';
import '../entities/mcb_entity.dart';

abstract class McbRepository {
  Future<McbEntity> getDetail(String deviceId);

  Future<void> sendBreakerCommand(
      BreakerCommand command,
      String accessToken,
      );
  Future<BreakerStateResponse> getBreakerState({
    required String gatewaySn,
    required String breakerSn,
    required String addr,
  });
}
