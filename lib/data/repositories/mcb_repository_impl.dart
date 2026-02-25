import '../../domain/mcb/entities/breaker_command.dart';
import '../../domain/mcb/entities/mcb_entity.dart';
import '../../domain/mcb/repositories/mcb_repository.dart';
import '../data_sources/mcb/mcb_mock_datasource.dart';
import '../data_sources/mcb/mcb_remote_datasource.dart';
import '../dto/electric/breaker_state_response.dart';


class McbRepositoryImpl implements McbRepository {
  final McbMockDatasource mock;
  final McbRemoteDatasource remote;

  McbRepositoryImpl({
    required this.mock,
    required this.remote,
  });

  @override
  Future<McbEntity> getDetail(String deviceId) {
    // hiện tại dùng mock
    return mock.getDetail(deviceId);
  }

  @override
  Future<void> sendBreakerCommand(
      BreakerCommand command,
      String accessToken,
      ) {
    // gửi lệnh luôn đi API thật
    return remote.sendCommand(
      command: command,
      accessToken: accessToken,
    );
  }
  @override
  Future<BreakerStateResponse> getBreakerState({
    required String gatewaySn,
    required String breakerSn,
    required String addr,
  }) {
    return remote.getBreakerState(
      gatewaySn: gatewaySn,
      breakerSn: breakerSn,
      addr: addr,
    );
  }
}
