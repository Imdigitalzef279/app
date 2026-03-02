import '../../../data/dto/breaker_command/breaker_command_dto.dart';

abstract class BreakerHistoryState {}

class BreakerHistoryLoading extends BreakerHistoryState {}

class BreakerHistoryLoaded extends BreakerHistoryState {
  final List<BreakerCommandModel> logs;

  BreakerHistoryLoaded(this.logs);
}

class BreakerHistoryError extends BreakerHistoryState {
  final String message;

  BreakerHistoryError(this.message);
}