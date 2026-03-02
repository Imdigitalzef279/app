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

import '../../../../data/dto/atomat/atomat_log_response.dart';
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

    print("=== CALL getAllDevices ===");
    print("PowerStationId: $powerStationId");

    emit(state.copyWith(
      resultDevices: Result(status: LoadStatus.loading),
    ));

    try {

      print("➡️ Calling API...");
      final response = await _repo.getSolarElectric(powerStationId);

      print("⬅️ API Response:");
      print("Status: ${response.status}");
      print("Data: ${response.data}");
      print("Error: ${response.error}");

      if (response.status != LoadStatus.success ||
          response.data == null ||
          response.data!.isEmpty) {

        print("❌ API FAIL OR EMPTY");

        emit(state.copyWith(
          resultDevices: Result(
            status: LoadStatus.failure,
            error: response.error.isNotEmpty
                ? response.error
                : "Không có thiết bị",
          ),
        ));
        return;
      }

      print("✅ API SUCCESS - EMIT SUCCESS");

      emit(state.copyWith(
        resultDevices: response,
      ));

    } catch (e, stack) {

      print("🔥 EXCEPTION:");
      print(e);
      print(stack);

      emit(state.copyWith(
        resultDevices: Result(
          status: LoadStatus.failure,
          error: e.toString(),
        ),
      ));
    }
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

    if (state.isForceLoading) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isForceLoading: true));

    try {

      /// 🔥 Toggle theo relay thật
      final currentRelay = device.rlyRepSta; // int
      final commandValue = currentRelay == 0 ? 1 : 0;

      print("Current relay: $currentRelay");
      print("Send switch: $commandValue");

      final success = await switchCbsWithForce(
        device,
        commandValue.toString(),
        false,
      );

      if (!success) {
        emit(state.copyWith(isForceLoading: false));
        AppToast.showToastError(title: "Không ON/OFF được");
        return;
      }

      /// ✅ Optimistic update theo relay
      final currentList = state.resultDevices.data ?? [];

      final updatedList = currentList.map((d) {
        if (d.id == device.id) {
          return d.copyWith(
            rlyRepSta: commandValue,
          );
        }
        return d;
      }).toList();

      emit(state.copyWith(
        resultDevices: state.resultDevices.copyWith(
          data: updatedList,
        ),
        isForceLoading: false,
      ));

      /// Reload nền
      await getAllDevices(
        powerStationId: device.powerStationId,
      );

    } catch (e) {
      emit(state.copyWith(isForceLoading: false));
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }
  }
  // ============================================================
// TOGGLE MAINTENANCE
// ============================================================
  Future<void> toggleMaintenance(
      DeviceResponse device, {
        required String password,
      }) async {

    if (state.isForceLoading) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isForceLoading: true));

    try {

      final isMaintenance = device.rlyRepSta == "1";
      final commandValue = isMaintenance ? "0" : "1";

      final success = await switchCbsWithForce(
        device,
        commandValue,
        true, // maintenance luôn force
      );

      if (!success) {
        AppToast.showToastError(title: "Không đổi bảo trì được");
        emit(state.copyWith(isForceLoading: false));
        return;
      }

      await getAllDevices(powerStationId: device.powerStationId);

    } catch (_) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }

    emit(state.copyWith(isForceLoading: false));
  }
  Future<void> forcePower(
      DeviceResponse device, {
        required String password,
      }) async {

    if (state.isForceLoading) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isForceLoading: true));

    try {
      final currentStatus = device.status ?? 0;
      final commandValue = currentStatus == 1 ? "0" : "1";

      final success = await switchCbsWithForce(
        device,
        commandValue,
        true, // ✅ force
      );

      if (!success) {
        AppToast.showToastError(title: "Force thất bại");
        emit(state.copyWith(isForceLoading: false));
        return;
      }

      await getAllDevices(powerStationId: device.powerStationId);

    } catch (_) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }

    emit(state.copyWith(isForceLoading: false));
  }
  // ============================================================
  // TÍnh năng đóng cắt
  // ============================================================

  Future<bool> switchCbsWithForce(
      DeviceResponse device,
      String commandValue,
      bool isForce,
      ) async {
    try {
      print("===== SWITCH DEBUG =====");
      print("serialNumber: ${device.serialNumber}");
      print("breakerSn: ${device.code}");
      print("gatewaySn: ${device.gatewayNumber}");
      print("commandValue: $commandValue");
      print("isForce: $isForce");
      print("========================");

      final response = await _cbs.sendCbsCommand(
        CbsMeterRequest(
          addr: device.serialNumber,
          breakerSn: device.code,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue,
          isForce: isForce,
        ),
      );

      print("RESPONSE: $response");

      if (response == -1) return false;

      return true;
    } catch (e) {
      print("ERROR SWITCH: $e");
      return false;
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
  void updateRealtimeLogByCode(String code, AtomatLogResponse log) {
    final currentList = state.resultDevices.data;
    if (currentList == null) return;

    final updatedList = currentList.map((device) {
      if (device.code == code) {
        return device.copyWith(realtimeLog: log);
      }
      return device;
    }).toList();
    void setSwitching(bool value) {
      emit(state.copyWith(isForceLoading: value));
    }
    emit(
      state.copyWith(
        resultDevices: state.resultDevices.copyWith(data: updatedList),
      ),
    );
  }
  void setSwitching(bool value) {
    emit(state.copyWith(isForceLoading: value));
  }
  Future<bool> _verifyForceAuth({
    String? password,
    bool emailVerified = false,
  }) async {
    const authType = "password";

    if (authType == "none") return true;

    if (authType == "password") {
      if (password == null || password.length != 4) return false;
      return password == "9999";
    }

    if (authType == "email") {
      return emailVerified;
    }

    return false;
  }
}
