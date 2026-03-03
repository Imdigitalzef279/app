import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/aptomat_log/switch_log_model.dart';
import '../../data/repositories/switch_log/switch_log_repository.dart';

abstract class SwitchLogState {}

class SwitchLogInitial extends SwitchLogState {}
class SwitchLogLoading extends SwitchLogState {}
class SwitchLogLoaded extends SwitchLogState {
  final List<SwitchLogModel> logs;
  SwitchLogLoaded(this.logs);
}
class SwitchLogError extends SwitchLogState {}

class SwitchLogCubit extends Cubit<SwitchLogState> {
  final SwitchLogRepository repository;

  SwitchLogCubit(this.repository) : super(SwitchLogInitial());

  Future<void> fetchLogs(String gatewaySn) async {
    emit(SwitchLogLoading());

    try {
      final logs = await repository.getLogs(gatewaySn);
      emit(SwitchLogLoaded(logs));
    } catch (_) {
      emit(SwitchLogError());
    }
  }
}