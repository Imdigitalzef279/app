import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/data/dto/device/request/device_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/meter/request/meter_request.dart';
import 'package:solar_energy/data/dto/meter/response/meter_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/di.dart';

import '../../../common_widgets/app_toast.dart';

part 'device_state.dart';

part 'device_cubit.freezed.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceState.init());

  final _repo = getIt.get<DeviceRepository>();

  Future<void> getDevices(
      {required int powerStationId, required ElectricType type}) async {
    emit(state.copyWith(resultDevices: Result(status: LoadStatus.loading)));
    final response = await _repo.getSolarElectric(powerStationId);
    if (response.data?.isEmpty ?? true) {
      emit(state.copyWith(resultDevices: Result(status: LoadStatus.failure)));
      return;
    }
    final rawList = response.data;

    final filteredDevices =
        rawList?.where((d) => fromMeterTypeId(d.meterTypeId) == type).toList();
    emit(state.copyWith(
        resultDevices: response.copyWith(
            data: filteredDevices, status: LoadStatus.success)));
  }

  Future<int> getDeviceFirst(
      {required int powerStationId, ElectricType? type}) async {
    emit(state.copyWith(resultDevices: Result(status: LoadStatus.loading)));
    final response = await _repo.getSolarElectric(powerStationId);
    final rawList = response.data;

    final filteredDevices =
        rawList?.where((d) => fromMeterTypeId(d.meterTypeId) == type).toList();
    return filteredDevices?.first.id ?? 0;
  }

  ElectricType? fromMeterTypeId(int id) {
    switch (id) {
      case 2:
        return ElectricType.saveElectric;
      case 21:
      case 22:
        return ElectricType.solarElectric;
      default:
        return null;
    }
  }

  int toMeterTypeIds(ElectricType type) {
    switch (type) {
      case ElectricType.saveElectric:
        return 2;
      case ElectricType.solarElectric:
        return 22;
      default:
        return 2;
    }
  }


  Future<bool> createPowerStation(
      MeterRequest requestBody) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await _repo.createElectricMeter(requestBody);
      if (response.isSuccess) {
        emit(state.copyWith(
          status: LoadStatus.success,
        ));
        AppToast.showToastSuccess(
            title: "Đăng ký thiết bị thành công");
        return true;
      }
      AppToast.showToastSuccess(
          title: "Đăng ký thiết bị không thành công");
      return false;
    } catch (e) {
      if (e is DioException) {
        AppToast.showToastError(title: "Xảy ra lỗi Dio");
        return false;
      }
      AppToast.showToastError(title: "Xảy ra lỗi");
      return false;
    }
  }

}
