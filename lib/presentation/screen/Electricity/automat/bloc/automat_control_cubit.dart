import 'package:bloc/bloc.dart';
import '../../../../../domain/mcb/entities/breaker_command.dart';
import '../../../../../domain/mcb/repositories/mcb_repository.dart';

class AutomatControlCubit extends Cubit<bool> {
  final McbRepository repo;

  AutomatControlCubit(this.repo) : super(false);

  Future<void> sendCommand({
    required String gatewaySn,
    required String breakerSn,
    required String addr,
    required String commandValue,
    bool isForce = false,
  }) async {
    emit(true);

    try {
      await repo.sendBreakerCommand(
        BreakerCommand(
          gatewaySn: gatewaySn,
          breakerSn: breakerSn,
          addr: addr,
          commandValue: commandValue,
          isForce: isForce,
          createdBy: 'admin',
        ),
        'FAKE_ACCESS_TOKEN', // sau này lấy từ AuthCubit
      );
    } finally {
      emit(false);
    }
  }
}
