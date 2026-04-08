import 'package:dio/dio.dart';
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
      String formatDate(DateTime date) {
        return "${date.year.toString().padLeft(4, '0')}-"
            "${date.month.toString().padLeft(2, '0')}-"
            "${date.day.toString().padLeft(2, '0')}";
      }

      final time = formatDate(DateTime.now());

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
