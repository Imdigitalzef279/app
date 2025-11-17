import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/application/utils/toast_utils.dart';
import 'package:solar_energy/data/dto/water/request/meter_water_request.dart';
import 'package:solar_energy/data/repositories/water/water_repository.dart';
import 'package:solar_energy/gen/assets.gen.dart';

import '../../../../data/dto/base_chart_line.dart';
import '../../../../data/dto/result/result.dart';
import '../../../../data/dto/water/response/meter_water_response.dart';

part 'manager_water_state.dart';

part 'manager_water_cubit.freezed.dart';

class WaterIndexModel {
  final String icon;
  final String title;
  final String unit;
  final double value;
  final int? limit;
  final bool isConnected;

  WaterIndexModel(
      {required this.icon,
      required this.title,
      required this.unit,
      required this.value,
      this.limit,
      this.isConnected = false});
}

class ManagerWaterCubit extends Cubit<ManagerWaterState> {
  ManagerWaterCubit() : super(ManagerWaterState.init());

  final waterRepo = GetIt.instance<WaterRepository>();

  Future<void> getValuesWater(MeterWaterRequest request) async {
    emit(state.copyWith(values: Result(status: LoadStatus.loading)));
    List<BaseChartLine> gridPowers = [];
    final preDate = DateTime.now().subtract(const Duration(days: 1));
    final date = DateTime.now();
    double preIndex = 0;
    try {
      final preRequest = MeterWaterRequest(
        detailId: request.detailId,
        powerStationId: request.powerStationId,
        fromDate: "${date.month}/${date.day}/${date.year}",
        toDate: "${preDate.month}/${preDate.day}/${preDate.year}",
      );

      final response = await waterRepo.getMeterValues(request);
      final preResponse = await waterRepo.getMeterValues(preRequest);
      if (response.isSuccess && response.data != null) {
        if (response.data!.isEmpty) {
          emit(state.copyWith(
              values: Result(
                  error: "Không có dữ liệu", status: LoadStatus.failure)));
          return;
        }

        if (preResponse.isSuccess && preResponse.data != null) {
          if (preResponse.data!.isNotEmpty) {
            preIndex = double.tryParse(preResponse.data!.last.value) ?? 0.0;
            print(preIndex.toString());
          }}

        final listData = response.data;
        gridPowers = listData!
            .map((e) => BaseChartLine(
                getTimeLine(DateTime.tryParse(e.updateTime)),
                roundDouble(double.tryParse(e.value) ?? 0.0, 2)))
            .toList();

        double currentIndex = gridPowers.last.sales;

        gridPowers = gridPowers.mapIndexed((index, current) {
          if (index == 0) return BaseChartLine(current.year, current.sales - preIndex);
          final prev = gridPowers[index - 1];
          return BaseChartLine(
              current.year, roundDouble(current.sales - prev.sales, 2));
        }).toList();

        emit(state.copyWith(
            values: response,
            loadPowers: gridPowers,
            currentIndex: currentIndex));

        return;
      }
    } catch (e) {
      emit(state.copyWith(
          values: Result(
              error: "đã có lỗi xảy ra vui lòng thử lại",
              status: LoadStatus.failure)));
      return;
    }
  }

  // water index logic
  void changeIsEdit() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  void addToListSelected(WaterIndexModel waterIndex, bool isAdd) {
    List<WaterIndexModel> listWaterIndex = [...state.listWaterIndex];
    List<WaterIndexModel> listSelected = [...state.listSelected];
    if (isAdd) {
      if (listSelected.length >= 4) {
        ToastUtils.show('Hiển thị tối đa 4 chỉ số');
        return;
      }
      listWaterIndex.remove(waterIndex);
      listSelected.add(waterIndex);
    } else {
      listWaterIndex.add(waterIndex);
      listSelected.remove(waterIndex);
    }

    emit(state.copyWith(
        listSelected: listSelected, listWaterIndex: listWaterIndex));
  }

  Color handleColorStatus(WaterIndexModel waterIndex) {
    if (!waterIndex.isConnected) return AppColors.grey73;
    if (waterIndex.limit != null) {
      double limit = waterIndex.limit!.toDouble();
      double tendToLimit = (waterIndex.limit! * 0.75);
      if (waterIndex.value > limit) return AppColors.red14;
      if (waterIndex.value <= limit && waterIndex.value >= tendToLimit) {
        return AppColors.orange43;
      }
    }
    return AppColors.green50;
  }

  String getTimeLine(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.hour}:${dateTime.minute}';
  }

  double roundDouble(double value, int places) {
    num mod = pow(10, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
