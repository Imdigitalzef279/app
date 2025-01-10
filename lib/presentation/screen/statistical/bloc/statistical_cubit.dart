import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/application/enums/search_type.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/data/dto/solar_electric/response/solar_electric_response.dart';
import 'package:solar_energy/data/repositories/solar_electric/solar_electric_repository.dart';
import 'package:solar_energy/di.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'statistical_state.dart';

part 'statistical_cubit.freezed.dart';

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData({required this.x, required this.y, required this.color});
}

class StatisticalCubit extends Cubit<StatisticalState> {
  StatisticalCubit(this.typeDate) : super(StatisticalState.init());
  final DateRangePickerView typeDate;
  final _repo = getIt.get<SolarElectricRepository>();

  Future<void> getSolarElectric() async {
    emit(state.copyWith(resultSolar: Result(status: LoadStatus.loading)));
    final response = await _repo.getSolarElectric(
        state.request.copyWith(searchValue: dateTimeFormatted));
    List<SalesData> gridPowers = [];
    List<SalesData> productionPowers = [];
    List<SalesData> loadPowers = [];
    List<ChartData> listUsed = [];
    List<ChartData> listOutput = [];
    response.when(success: (data) {
      if (data?.data == null) return;
      double totalGridPower =
          data!.data.fold(0, (previous, data) => previous += data.gridPower);
      double totalProductionPower = data.data
          .fold(0, (previous, data) => previous += data.productionPower);
      double totalLoadPower =
          data.data.fold(0, (previous, data) => previous += data.loadPower);
      listOutput = [
        ChartData(x: 'Điện lưới', y: totalGridPower, color: AppColors.greenA1),
        ChartData(
            x: "Điện mặt trời",
            y: totalProductionPower,
            color: AppColors.grey74)
      ];
      listUsed = [
        ChartData(
            x: 'Điện sử dụng', y: totalLoadPower, color: AppColors.orange43),
        ChartData(
            x: 'Tổng',
            y: totalGridPower + totalProductionPower,
            color: AppColors.green50)
      ];

      gridPowers = data.data
          .map((e) => SalesData(getTimeLine(e.timeUpdated), e.gridPower))
          .toList();
      productionPowers = data.data
          .map((e) => SalesData(getTimeLine(e.timeUpdated), e.productionPower))
          .toList();
      loadPowers = data.data
          .map((e) => SalesData(getTimeLine(e.timeUpdated), e.loadPower))
          .toList();
    });
    emit(state.copyWith(
        resultSolar: response,
        loadPowers: loadPowers,
        productionPowers: productionPowers,
        gridPowers: gridPowers,
        listUsed: listUsed,
        listOutput: listOutput));
  }

  void changeRequest(SolarElectricRequest request) {
    emit(state.copyWith(request: request));
  }

  void changDateTime(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));
    switch (typeDate) {
      case DateRangePickerView.month:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.hour,
                searchValue: dateTime.formatTime())));
      case DateRangePickerView.year:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.day,
                searchValue: dateTime.formatTime(pattern: 'MM/yyyy'))));
      case DateRangePickerView.decade:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.month,
                searchValue: dateTime.formatTime(pattern: 'yyyy'))));
      default:
    }
  }

  String get dateTimeFormatted {
    switch (typeDate) {
      case DateRangePickerView.month:
        return state.dateTime.formatTime();
      case DateRangePickerView.year:
        return state.dateTime.formatTime(pattern: 'MM/yyyy');
      case DateRangePickerView.decade:
        return state.dateTime.formatTime(pattern: 'yyyy');
      default:
        return '';
    }
  }

  SearchType getSearchType(DateRangePickerView typeDate) {
    switch (typeDate) {
      case DateRangePickerView.month:
        return SearchType.hour;
      case DateRangePickerView.year:
        return SearchType.day;
      case DateRangePickerView.decade:
        return SearchType.month;
      default:
        return SearchType.hour;
    }
  }

  String getTimeLine(DateTime? dateTime) {
    if (dateTime == null) return '';
    switch (typeDate) {
      case DateRangePickerView.month:
        return '${dateTime.hour}:${dateTime.minute}';
      case DateRangePickerView.year:
        return '${dateTime.day}';
      case DateRangePickerView.decade:
        return '${dateTime.month}';
      default:
        return '';
    }
  }
}
