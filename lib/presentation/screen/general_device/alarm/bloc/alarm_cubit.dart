import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/dto/alarm/response/alarm_response.dart';
import '../../../../../data/repositories/alarm/alarm_repository.dart';

class AlarmCubit extends Cubit<List<AlarmResponse>> {
  final AlarmRepository repo;

  AlarmCubit(this.repo) : super([]);

  Future<void> loadAlarms() async {
    final data = await repo.getAlarms();
    emit(data);
  }
}