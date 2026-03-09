import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/di.dart';

import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/atomat/atomat_log_response.dart';
import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import '../../../../data/dto/profile/profile_response.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../common_widgets/app_toast.dart';

part 'device_state.dart';
part 'device_cubit.freezed.dart';

class DeviceCubit extends Cubit<DeviceState> {

  DeviceCubit() : super(DeviceState.init());
  final _repo = getIt.get<DeviceRepository>();
  String? _cachedUserName;
  final _api = GetIt.instance<ApiClient>();
  final _cbs = getIt.get<CbsRepository>();
  final _authRepo = getIt.get<AuthRepository>();
  ProfileResponse? profile;

  double calculateElectricCost(DeviceResponse device, {double price = 3200}) {
    final kwh = device.realtimeLog?.epi ?? 0;
    return kwh * price;
  }
  // lấy usernaemn cho api đóng cắt
  void setProfile(ProfileResponse profileResponse) {
    profile = profileResponse;
  }
  // Cập nhật trạng thái thiết bị ngay trên UI mà không cần chờ API trả về.
  void updateLocalStatus(int deviceId, int newStatus) {

    final currentDevices = state.resultDevices.data ?? [];

    final updatedDevices = currentDevices.map((d) {
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

    if (state.isSwitching || state.isForceLoading) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) {
      AppToast.showToastError(title: "Sai mật khẩu");
      return;
    }

    emit(state.copyWith(isSwitching: true));

    try {

      final latestDevice = state.resultDevices.data
          ?.firstWhere((d) => d.id == device.id);

      if (latestDevice == null) return;

      final currentSwitch =
          state.breakerLog?.rlySta ??
              latestDevice.status ??
              0;

      final commandValue = currentSwitch == 1 ? "0" : "1";

      final success = await switchCbsWithForce(
        latestDevice,
        commandValue,
        false,
      );

      if (!success) {
        AppToast.showToastError(title: "Không ON/OFF được");
        return;
      }

      /// update UI ngay
      updateLocalStatus(latestDevice.id, int.parse(commandValue));

      await waitBreakerState(
        device.code,
        int.parse(commandValue),
      );

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    } finally {
      emit(state.copyWith(isSwitching: false));
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

      final isMaintenance = device.rlyRepSta == 1;
      final commandValue = isMaintenance ? "0" : "1";
      final username = profile?.userName ?? "";
      final response = await _cbs.setBreakerMaintenance(
        CbsMeterRequest(
          addr: state.breakerLog?.addr ?? device.serialNumber,
          breakerSn: device.code,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue,
          createdBy: "mobile_app",
          isForce: true,
        ),
      );

      final success = response != -1;

      if (!success) {
        AppToast.showToastError(title: "Không đổi bảo trì được");
        emit(state.copyWith(isForceLoading: false));
        return;
      }
      await waitBreakerState(
        device.code,
        int.parse(commandValue),
      );

      await getAllDevices(powerStationId: device.powerStationId);

    } catch (_) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    }

    emit(state.copyWith(isForceLoading: false));
  }
  // ============================================================
  // Force on off
  // ============================================================
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

      /// lấy device mới nhất trong state
      final latestDevice = state.resultDevices.data
          ?.firstWhere((d) => d.id == device.id);

      if (latestDevice == null) {
        emit(state.copyWith(isForceLoading: false));
        return;
      }

      final currentStatus = latestDevice.status ?? 0;
      final commandValue = currentStatus == 1 ? "0" : "1";

      final success = await switchCbsWithForce(
        latestDevice,
        commandValue,
        true,
      );

      if (!success) {
        AppToast.showToastError(title: "Force thất bại");
        emit(state.copyWith(isForceLoading: false));
        return;
      }
      await Future.delayed(const Duration(seconds: 3));
      await loadBreakerLog(device.code);
      /// update local device
      final updatedList = (state.resultDevices.data ?? []).map((d) {
        if (d.id == latestDevice.id) {
          return d.copyWith(status: int.parse(commandValue));
        }
        return d;
      }).toList();

      emit(state.copyWith(
        resultDevices: state.resultDevices.copyWith(data: updatedList),

        /// update breaker log luôn
        breakerLog: state.breakerLog?.copyWith(
          rlySta: int.parse(commandValue),
        ),

        isForceLoading: false,
      ));

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
      emit(state.copyWith(isForceLoading: false));
    }
  }
  // ============================================================
  // Gọi addr
  // ============================================================
  Future<void> loadBreakerLog(String breakerSn) async {
    try {

      final response = await _repo.getBreakerLog(breakerSn);

      if (response.data == null || response.data!.isEmpty) {
        print("Breaker log empty");
        return;
      }

      final log = response.data!.first;

      emit(
        state.copyWith(
          breakerLog: log,
        ),
      );

    } catch (e) {
      print("LOAD LOG ERROR: $e");
    }
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

      final addr =
          state.breakerLog?.addr ??
              device.realtimeLog?.addr ??
              device.serialNumber ??
              "";

      final username = profile?.userName ?? "mobile_app";

      print("DEVICE CODE: ${device.code}");
      print("GATEWAY: ${device.gatewayNumber}");
      print("ADDR: $addr");
      print("COMMAND: $commandValue");

      if (addr.isEmpty) {
        print("ADDR NULL → không gửi API");
        return false;
      }

      final response = await _cbs.sendCbsCommand(
        CbsMeterRequest(
          addr: addr,
          breakerSn: device.serialNumber,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue,
          createdBy: username,
          isForce: isForce,
        ),
      );

      if (response == -1) return false;

      return true;

    } catch (e) {
      print("ERROR SWITCH: $e");
      return false;
    }
  }
  // Future<void> waitBreakerState(
  //     String breakerSn,
  //     int expectedState,
  //     ) async {
  //
  //   for (int i = 0; i < 10; i++) {
  //
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     await loadBreakerLog(breakerSn);
  //
  //     final current = state.breakerLog?.rlySta;
  //
  //     if (current == expectedState) {
  //       break;
  //     }
  //   }
  // }
  Future<void> waitBreakerState(
      String breakerSn,
      int expectedState,
      ) async {

    int countdown = 15;

    while (countdown > 0) {

      emit(state.copyWith(
        switchCountdown: countdown,
      ));

      await Future.delayed(const Duration(seconds: 1));

      countdown--;

      await loadBreakerLog(breakerSn);

      final current = state.breakerLog?.rlySta;

      if (current == expectedState) {
        break;
      }
    }

    emit(state.copyWith(
      switchCountdown: 0,
    ));
  }
  // ============================================================
  // Tính tiền điện
  // ============================================================
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
        return device.copyWith(
          realtimeLog: log,
          status: log.rlySta ?? device.status,
        );
      }
      return device;
    }).toList();

    emit(
      state.copyWith(
        resultDevices: state.resultDevices.copyWith(data: updatedList),
      ),
    );
  }
  void setSwitching(bool value) {
    emit(state.copyWith(isSwitching: value));
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
