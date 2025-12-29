import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../application/enums/load_status.dart';
import '../../../../../application/enums/search_type.dart';
import '../../../../../data/dto/api_response/api_response.dart';
import '../../../../../data/dto/electric/chart_electric/chart_electric_request.dart';
import '../../../../../data/dto/lasted_log_data/response/lasted_log_data_response.dart';
import '../../../../../data/dto/result/result.dart';
import '../../../../../data/repositories/solar_electric/solar_electric_repository.dart';
import '../../../../../di.dart';
import '../../bloc/statistical_cubit.dart';

part 'estatistical_state.dart';

part 'estatistical_cubit.freezed.dart';

class EStatisticalCubit extends Cubit<EStatisticalState> {
  EStatisticalCubit(this.typeDate, this.meterId)
      : super(EStatisticalState.init());
  final DateRangePickerView typeDate;
  final int meterId;
  final _repo = getIt.get<SolarElectricRepository>();

  Future<void> getChartElectric() async {
    emit(state.copyWith(resultChart: Result(status: LoadStatus.loading)));
    final response = await _repo.getChartElectric(state.request);
    List<SalesData> gridPowers = [];
    List<SalesData> gridThdUa = [];
    List<SalesData> gridThdUb = [];
    List<SalesData> gridThdUc = [];
    List<SalesData> gridThdIa = [];
    List<SalesData> gridThdIb = [];
    List<SalesData> gridThdIc = [];

    if (response.isSuccess) {
      if (response.data?.data.isNotEmpty ?? false) {
        final listData = response.data?.data;
        gridPowers = listData!
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.paramEpi.toString()) ?? 0.0)))
            .toList();

        gridThdUa = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdUa.toString()) ?? 0.0)))
            .toList();

        gridThdUc = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdUc.toString()) ?? 0.0)))
            .toList();

        gridThdIa = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdIa.toString()) ?? 0.0)))
            .toList();

        gridThdIb = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdIb.toString()) ?? 0.0)))
            .toList();

        gridThdIc = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdIc.toString()) ?? 0.0)))
            .toList();

        gridThdUb = listData
            .map((e) => SalesData(getTimeLine(e.updateTime),
                (double.tryParse(e.thdUb.toString()) ?? 0.0)))
            .toList();

        final result = <SalesData>[];
        for (int i = 0; i < gridPowers.length - 1; i++) {
          if (i == gridPowers.length) {
            result.add(SalesData(gridPowers[i].year, 0));
          } else {
            result.add(
              SalesData(
                gridPowers[i].year,
                (gridPowers[i].sales - gridPowers[i + 1].sales),
              ),
            );
          }
        }

        gridPowers = result;

        emit(state.copyWith(
            resultChart: response,
            loadPowers: gridPowers,
            thdUa: gridThdUa,
            thdUb: gridThdUb,
            thdUc: gridThdUc,
            thdIa: gridThdIa,
            thdIb: gridThdIb,
            thdIc: gridThdIc));
        return;
      }
      emit(state.copyWith(
          resultChart: Result(
              status: LoadStatus.failure,
              error: LocalizationsUtils.localizations.no_value)));
      return;
    }
    emit(state.copyWith(
        resultChart: Result(
            status: LoadStatus.failure,
            error: LocalizationsUtils.localizations.errorContactAdmin)));
    return;
  }

  void changeRequest(ChartElectricRequest request) {
    emit(state.copyWith(request: request));
  }

  void changeMeterId({int? meterId}) {
    emit(state.copyWith(
        meterId: meterId ?? this.meterId,
        request: state.request.copyWith(meterId: meterId ?? this.meterId)));
  }

  void changDateTime(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime, meterId: meterId));
    switch (typeDate) {
      case DateRangePickerView.month:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.hour,
                fromDate:
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}T00:00:00",
                toDate:
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}T23:59:59")));
      case DateRangePickerView.year:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.day,
                fromDate: DateFormat("MM/yyyy").format(dateTime),
                toDate: DateFormat("MM/yyyy")
                    .format(DateTime(dateTime.year, dateTime.month + 1)))));
      case DateRangePickerView.decade:
        return emit(state.copyWith(
            request: state.request.copyWith(
                searchType: SearchType.month,
                fromDate:
                    DateFormat("MM/yyyy").format(DateTime(dateTime.year, 1)),
                toDate: DateFormat("MM/yyyy")
                    .format(DateTime(dateTime.year, 12)))));
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

  void changeSelect(
      {bool? selectThdUa,
      bool? selectThdUb,
      bool? selectThdUc,
      bool? selectThdIa,
      bool? selectThdIb,
      bool? selectThdIc}) {
    emit(state.copyWith(
        selectThdUa: selectThdUa ?? state.selectThdUa,
        selectThdUb: selectThdUb ?? state.selectThdUb,
        selectThdUc: selectThdUc ?? state.selectThdUc,
        selectThdIa: selectThdIa ?? state.selectThdIa,
        selectThdIb: selectThdIb ?? state.selectThdIb,
        selectThdIc: selectThdIc ?? state.selectThdIc)
    );
    print(state.selectThdUa);
  }
}
