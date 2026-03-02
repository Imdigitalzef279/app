import 'package:bloc/bloc.dart';

import '../../../data/dto/breaker_command/breaker_command_dto.dart';
import '../../../data/repositories/breaker/breaker_repository.dart';
import 'breaker_history_state.dart';

class BreakerHistoryCubit extends Cubit<BreakerHistoryState> {
  final BreakerRepository repository;

  BreakerHistoryCubit(this.repository)
      : super(BreakerHistoryLoading());
  Future<void> loadHistory(
      String gatewaySn,
      String breakerSn,
      ) async {
    emit(BreakerHistoryLoading());

    final logs = await repository.getHistory(
      gatewaySn: gatewaySn,
      breakerSn: breakerSn,
    );

    emit(BreakerHistoryLoaded(logs));
  }
}