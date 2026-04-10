import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/data/dto/energy_report/energy_report_response.dart';

import '../../../../../../data/repositories/EnergyRepository/EnergyRepository.dart';


class ElectricHistoryState {
  final bool isLoading;
  final List<EnergyReportResponse> data;

  ElectricHistoryState({
    this.isLoading = false,
    this.data = const [],
  });

  ElectricHistoryState copyWith({
    bool? isLoading,
    List<EnergyReportResponse>? data,
  }) {
    return ElectricHistoryState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
    );
  }
}

class ElectricHistoryCubit extends Cubit<ElectricHistoryState> {
  final EnergyRepository repo;

  ElectricHistoryCubit(this.repo) : super(ElectricHistoryState());

  Future<void> load({
    required int stationId,
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) async {
    emit(state.copyWith(isLoading: true));

    try {
      final res = await repo.getByDateRange(
        stationId: stationId,
        deviceId: deviceId,
        from: from,
        to: to,
      );

      emit(state.copyWith(
        isLoading: false,
        data: res,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("❌ Cubit error: $e");
    }

  }

}