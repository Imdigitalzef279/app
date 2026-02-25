import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/di.dart';

import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import '../../../common_widgets/app_toast.dart';

part 'device_state.dart';
part 'device_cubit.freezed.dart';

class DeviceCubit extends Cubit<DeviceState> {
  DeviceCubit() : super(DeviceState.init());
  final _repo = getIt.get<DeviceRepository>();
  final _cbs = getIt.get<CbsRepository>();
  void _updateLocalStatus(int deviceId, int newStatus) {
    final updatedDevices = state.resultDevices.data?.map((d) {
      if (d.id == deviceId) {
        return d.copyWith(status: newStatus);
      }
      return d;
    }).toList();

    emit(state.copyWith(
      resultDevices: state.resultDevices.copyWith(
        data: updatedDevices,
      ),
    ));
  }
  // ============================================================
  // LOAD DEVICES THEO TYPE
  // ============================================================

  Future<void> getDevices({
    required int powerStationId,
    required ElectricType type,
  }) async {
    emit(state.copyWith(
      resultDevices: Result(status: LoadStatus.loading),
    ));

    final response = await _repo.getSolarElectric(powerStationId);

    if (response.data?.isEmpty ?? true) {
      emit(state.copyWith(
        resultDevices: Result(
          status: LoadStatus.failure,
          error: LocalizationsUtils.localizations.no_value,
        ),
      ));
      return;
    }

    final filtered = response.data!
        .where((d) => fromMeterTypeId(d.meterTypeId) == type)
        .toList();

    emit(state.copyWith(
      resultDevices: response.copyWith(
        data: filtered,
        status: LoadStatus.success,
      ),
    ));
  }

  // ============================================================
  // LOAD ALL DEVICES
  // ============================================================

  Future<void> getAllDevices({
    required int powerStationId,
  }) async {
    emit(state.copyWith(
      resultDevices: Result(status: LoadStatus.loading),
    ));

    final response = await _repo.getSolarElectric(powerStationId);

    if (response.data?.isEmpty ?? true) {
      emit(state.copyWith(
        resultDevices: Result(
          status: LoadStatus.failure,
          error: "Không có thiết bị",
        ),
      ));
      return;
    }

    emit(state.copyWith(
      resultDevices: response.copyWith(status: LoadStatus.success),
    ));
  }

  // ============================================================
  // GET FIRST DEVICE
  // ============================================================

  Future<int> getDeviceFirst({
    required int powerStationId,
    ElectricType? type,
  }) async {
    final response = await _repo.getSolarElectric(powerStationId);

    if (response.data == null || response.data!.isEmpty) {
      return 0;
    }

    if (type == null) {
      return response.data!.first.id;
    }

    final filtered = response.data!
        .where((d) => fromMeterTypeId(d.meterTypeId) == type)
        .toList();

    if (filtered.isEmpty) return 0;

    return filtered.first.id;
  }


  // ============================================================
// TOGGLE POWER (ON/OFF)
// ============================================================
  Future<void> togglePower(
      DeviceResponse device, {
        required String password,
      }) async {
    final current =
    state.resultDevices.data?.firstWhere((d) => d.id == device.id);
    if (current == null) return;

    // Không cho bật/tắt khi đang bảo trì
    if (current.status == 2) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isForceLoading: true));

    try {
      final isTurningOn = current.status == 0;

      await switchCbsWithForce(
        device,
        isTurningOn ? "1" : "0",
        false,
      );

      _updateLocalStatus(device.id, isTurningOn ? 1 : 0);

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }

    emit(state.copyWith(isForceLoading: false));
  }

  // ============================================================
// TOGGLE MAINTENANCE
// ============================================================
  Future<void> toggleMaintenance(
      DeviceResponse device, {
        required String password,
      }) async {
    final current =
    state.resultDevices.data?.firstWhere((d) => d.id == device.id);
    if (current == null) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isForceLoading: true));

    try {
      final isEnable = current.status != 2;

      // Nếu bật bảo trì mà đang ON → tắt trước
      if (isEnable && current.status == 1) {
        await switchCbsWithForce(device, "0", false);
      }

      await switchCbsWithForce(
        device,
        isEnable ? "0" : "1",
        isEnable,
      );

      _updateLocalStatus(device.id, isEnable ? 2 : 1);

      AppToast.showToastSuccess(
        title: isEnable
            ? "Đã bật chế độ bảo trì"
            : "Đã tắt chế độ bảo trì",
      );
    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }

    emit(state.copyWith(isForceLoading: false));
  }


  Future<bool> _verifyForceAuth({
    String? password,
    bool emailVerified = false,
  }) async {
    const authType = "password";

    if (authType == "none") return true;

    if (authType == "password") {
      if (password == null || password.isEmpty) return false;
      return password == "123456";
    }

    if (authType == "email") {
      return emailVerified;
    }

    return false;
  }

  // ============================================================
  // TÍnh năng đóng cắt
  // ============================================================

  Future<void> switchCbsWithForce(
      DeviceResponse device,
      String commandValue,
      bool isForce,
      ) async {
    try {
      final response = await _cbs.sendCbsCommand(
        CbsMeterRequest(
          addr: device.serialNumber,
          breakerSn: device.code,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue, // truyền trực tiếp
          isForce: isForce,
        ),
      );

      if (response == -1) {
        AppToast.showToastError(title: "Lỗi, không đóng/cắt được");
        return;
      }

      AppToast.showToastSuccess(
        title: isForce
            ? "Thành công (Force Mode)"
            : "Thành công",
      );

      await getAllDevices(
        powerStationId: device.powerStationId,
      );

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }
  }
  // ============================================================
  // HELPER
  // ============================================================

  ElectricType? fromMeterTypeId(int id) {
    switch (id) {
      case 81:
      case 82:
        return ElectricType.saveElectric;
      case 21:
      case 22:
        return ElectricType.solarElectric;
      case 41:
        return ElectricType.water;
      default:
        return null;
    }
  }

}
