import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/gen/assets.gen.dart';

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

  void changeIsEdit() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  void addToListSelected(WaterIndexModel waterIndex, bool isAdd) {
    List<WaterIndexModel> listWaterIndex = [...state.listWaterIndex];
    List<WaterIndexModel> listSelected = [...state.listSelected];
    if (isAdd) {
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
}
