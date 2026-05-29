import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/data_sources/api/api_client.dart';
import '../../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';
import '../../../../../data/dto/energy_report/energy_report_response.dart';


class AnalyticsState {
  final List<EnergyReportResponse> data;
  final List<BreakerChartResponse>? breakerData;
  final bool isLoading;

  AnalyticsState({
    this.data = const [],
    this.breakerData,
    this.isLoading = false,
  });
  AnalyticsState copyWith({
    List<EnergyReportResponse>? data,
    List<BreakerChartResponse>? breakerData,
    bool? isLoading,
  }) {
    return AnalyticsState(
      data: data ?? this.data,
      breakerData: breakerData ?? this.breakerData,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final ApiClient api;

  AnalyticsCubit(this.api) : super(AnalyticsState());
  Future<void> loadBreakerChart({required String breakerSn}) async {
    try {
      emit(state.copyWith(isLoading: true));

      final res = await api.getBreakerChartData(breakerSn);

      emit(state.copyWith(
        breakerData: res,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
  Future<void> loadEnergy({
    required int powerStationId,
    required int deviceId,
    String type = "day",
  }) async {
    print("CALL ENERGY API");

    emit(state.copyWith(isLoading: true));

    try {
      String formatDate(DateTime date) {
        return "${date.year.toString().padLeft(4, '0')}-"
            "${date.month.toString().padLeft(2, '0')}-"
            "${date.day.toString().padLeft(2, '0')}";
      }

      final now = DateTime.now().toUtc().add(Duration(hours: 7));
      final time = formatDate(now);

      print("REQUEST:");
      print("powerStationId: $powerStationId");
      print("deviceId: $deviceId");
      print("type: $type");
      print("time: $time");

      final data = await api.getEnergyReport(
        powerStationId,
        deviceId,
        type.toUpperCase(),
        time,
      );
      print("========== ENERGY DATA ==========");
      print("COUNT = ${data.length}");

      for (final e in data) {
        print(
            "time=${e.time} "
                "p=${e.p} "
                "epi=${e.epi}"
        );
      }
      emit(state.copyWith(
        data: data,
        isLoading: false,
      ));
    } catch (e) {
      print("❌ ERROR: $e");

      if (e is DioException) {
        print("👉 STATUS: ${e.response?.statusCode}");
        print("👉 DATA: ${e.response?.data}");
        print("👉 HEADERS: ${e.response?.headers}");
      }

      emit(state.copyWith(
        data: [],
        isLoading: false,
      ));
    }
  }
}
