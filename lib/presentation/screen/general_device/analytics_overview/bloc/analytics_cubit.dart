import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/data_sources/api/api_client.dart';
import '../../../../../data/dto/energy_report/energy_report_response.dart';


class AnalyticsState {
  final List<EnergyReportResponse> data;
  final bool isLoading;

  AnalyticsState({
    this.data = const [],
    this.isLoading = false,
  });

  AnalyticsState copyWith({
    List<EnergyReportResponse>? data,
    bool? isLoading,
  }) {
    return AnalyticsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final ApiClient api;

  AnalyticsCubit(this.api) : super(AnalyticsState());

  Future<void> loadEnergy({
    required int powerStationId,
    required int deviceId,
    String type = "day",
  }) async {
    print("CALL ENERGY API");
    emit(state.copyWith(isLoading: true));

    try {
      final res = await api.getEnergyReport(
        powerStationId,
        deviceId,
        type,
        DateTime.now().toString().split(".").first,
      );

      print("DATA LENGTH: ${res.length}");

      emit(state.copyWith(
        data: res,
        isLoading: false,
      ));
    } catch (e) {
      print("ERROR: $e");

      emit(state.copyWith(
        data: [],
        isLoading: false,
      ));
    }
  }
}