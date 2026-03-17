import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/result/result.dart';
import 'package:solar_energy/data/repositories/cbs/cbs_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/di.dart';
import '../../../../application/utils/device_avatar_storage.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/atomat/atomat_log_response.dart';
import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import '../../../../data/dto/profile/profile_response.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/auth/auth_repository_impl.dart';
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

  double calculateTodayMoney({
    required double currentEpi,
    required double startOfDayEpi,
    required double price,
  }) {
    final energy = currentEpi - startOfDayEpi;
    return energy * price;
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

    emit(state.copyWith(
      resultDevices: Result(status: LoadStatus.loading),
    ));

    try {

      final response =
      await _repo.getSolarElectric(powerStationId);

      if (response.status != LoadStatus.success ||
          response.data == null ||
          response.data!.isEmpty) {

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

      final prefs = await SharedPreferences.getInstance();

      final devices = response.data!;

      final updatedDevices = <DeviceResponse>[];

      for (var d in devices) {

        final avatar =
        await DeviceAvatarStorage.getAvatar(d.id);

        final localName =
        await DeviceAvatarStorage.getDeviceName(d.id);

        final isFavorite =
            prefs.getBool("favorite_${d.id}") ?? false;

        updatedDevices.add(
          d.copyWith(
            avatar: avatar ?? "",
            name: localName ?? d.name,
            isFavorite: isFavorite,
          ),
        );
      }

      emit(state.copyWith(
        resultDevices: response.copyWith(
          data: updatedDevices,
        ),
      ));

    } catch (e) {

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

    final newMap = Map<int, bool>.from(state.switchingDevices);
    newMap[device.id] = true;

    emit(state.copyWith(switchingDevices: newMap));

    try {
      final latestDevice = state.resultDevices.data
          ?.where((d) => d.id == device.id)
          .firstOrNull;

      if (latestDevice == null) return;

      /// Lấy trạng thái hiện tại
      final currentSwitch =
          state.breakerLogs[latestDevice.code]?.rlySta ??
              latestDevice.realtimeLog?.rlySta ??
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

      /// Update UI ngay lập tức (optimistic update)
      final newStatus = int.parse(commandValue);

      final updatedDevices = (state.resultDevices.data ?? []).map((d) {

        if (d.id == latestDevice.id) {

          final newLog = (d.realtimeLog ??
              AtomatLogResponse()).copyWith(
            rlySta: newStatus,
          );

          return d.copyWith(
            status: newStatus,
            realtimeLog: newLog,
          );

        }

        return d;

      }).toList();
      final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);
      logs[latestDevice.code!] =
          (state.breakerLogs[latestDevice.code] ??
              latestDevice.realtimeLog ??
              AtomatLogResponse())
              .copyWith(rlySta: newStatus);
      emit(state.copyWith(
        breakerLogs: logs,
        resultDevices: state.resultDevices.copyWith(
          data: updatedDevices,
        ),
      ));

      await waitBreakerState(device.id, device.code!, newStatus);
      /// Reload log server
      // await loadBreakerLog(device.code);
    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    } finally {
      final newMap = Map<int, bool>.from(state.switchingDevices);
      newMap.remove(device.id);

      emit(state.copyWith(switchingDevices: newMap));
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
      final username = profile?.userName ?? "mobile_app";
      String addr =
          state.breakerLogs[device.code]?.addr ??
              device.realtimeLog?.addr ??
              device.serialNumber ??
              "";
      print("MAINTENANCE ADDR: $addr");
      print("DEVICE: ${device.code}");
      print("GATEWAY: ${device.gatewayNumber}");
      print("ADDR: $addr");
      print("======================");
      print("MQTT STATE: ${state.breakerLogs[device.code]?.rlyRepSta}");
      print("TYPE: ${state.breakerLogs[device.code]?.rlyRepSta.runtimeType}");
      if (addr.isEmpty) {
        print("ADDR NULL → không gửi API");
        return;
      }
      final isMaintenance =
          state.breakerLogs[device.code]?.rlyRepSta == 1;

      final commandValue = isMaintenance ? "0" : "1";

      final response = await _cbs.setBreakerMaintenance(
        CbsMeterRequest(
          addr: addr,
          breakerSn: device.code,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue,
          createdBy: username,
          isForce: true,
        ),
      );
      print("API RESPONSE: $response");
      if (response == -1) {
        AppToast.showToastError(title: "Không đổi bảo trì được");
        emit(state.copyWith(isForceLoading: false));
        return;
      }

      /// 🔥 chờ breaker update
      await waitBreakerState(
        device.id,
        device.code,
        commandValue == "1" ? 1 : 0,
      );

      /// reload breaker log
      await loadBreakerLog(device.code);

    } catch (e) {
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

      final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);

      logs[device.code!] =
          (logs[device.code] ?? device.realtimeLog!)
              .copyWith(rlySta: int.parse(commandValue));

      emit(state.copyWith(
        resultDevices: state.resultDevices.copyWith(data: updatedList),
        breakerLogs: logs,
        isForceLoading: false,
      ));

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
      emit(state.copyWith(isForceLoading: false));
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
          device.realtimeLog?.addr ??
              device.serialNumber ??
              "";
      // final username = profile?.userName ?? "mobile_app";
      final authRepo = getIt<AuthRepository>() as AuthRepositoryImpl;
      final username = authRepo.currentProfile?.userName ?? "";
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
          breakerSn: device.code,
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

      final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);
      logs[breakerSn] = log;

      emit(state.copyWith(
        breakerLogs: logs,
      ));

    } catch (e) {
      print("LOAD LOG ERROR: $e");
    }
  }
  Future<void> waitBreakerState(
      int deviceId,
      String breakerSn,
      int expectedState,
      ) async {

    int countdown = 5;

    while (countdown > 0) {

      final map = Map<int,int>.from(state.switchCountdowns);
      map[deviceId] = countdown;

      emit(state.copyWith(
        switchCountdowns: map,
      ));

      await Future.delayed(const Duration(seconds: 1));

      countdown--;

      final log = state.breakerLogs[breakerSn];

      final current = log?.rlySta;

      /// breaker đã đổi trạng thái
      if (current == expectedState) {
        break;
      }
    }

    final map = Map<int,int>.from(state.switchCountdowns);
    map.remove(deviceId);

    emit(state.copyWith(
      switchCountdowns: map,
    ));
  }
  // ============================================================
  // Tính tiền điện
  // ============================================================
  // ============================================================
  // HELPER
  // ============================================================
  int getRealStatus(DeviceResponse device, AtomatLogResponse? log) {

    /// nếu có realtime log → ưu tiên dùng
    if (log != null) {

      /// bảo trì
      if (log.rlyRepSta == 1) {
        return 2;
      }

      /// trạng thái đóng/cắt
      if (log.rlySta != null) {
        return log.rlySta!;
      }
    }

    /// fallback trạng thái từ device
    return device.status ?? 0;
  }
  void updateDeviceAvatar(int deviceId, String path) {

    final devices = state.resultDevices.data ?? [];

    final updated = devices.map((d) {

      if (d.id == deviceId) {
        return d.copyWith(
          avatar: path,
        );
      }

      return d;

    }).toList();

    emit(
      state.copyWith(
        resultDevices: state.resultDevices.copyWith(
          data: updated,
        ),
      ),
    );
  }
  Future<void> loadDeviceAvatars() async {

    final devices = state.resultDevices.data ?? [];

    final updated = <DeviceResponse>[];

    for (var d in devices) {

      final avatar =
      await DeviceAvatarStorage.getAvatar(d.id);

      final localName =
      await DeviceAvatarStorage.getDeviceName(d.id);

      updated.add(
        d.copyWith(
          avatar: avatar ?? "",
          name: localName ?? d.name,
        ),
      );

    }

    emit(
      state.copyWith(
        resultDevices: state.resultDevices.copyWith(
          data: updated,
        ),
      ),
    );
  }
  Future<void> updateDeviceName(int deviceId, String name) async {

    await DeviceAvatarStorage.saveDeviceName(
      deviceId,
      name,
    );

    final devices = state.resultDevices.data ?? [];

    final updatedDevices = devices.map((d) {

      if (d.id == deviceId) {
        return d.copyWith(name: name);
      }

      return d;

    }).toList();

    emit(
      state.copyWith(
        resultDevices: state.resultDevices.copyWith(
          data: updatedDevices,
        ),
      ),
    );
  }
  bool isDeviceSwitching(int deviceId) {
    return state.switchCountdowns.containsKey(deviceId);
  }
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
  Future<void> toggleFavorite(int deviceId) async {

    final prefs = await SharedPreferences.getInstance();

    final devices = state.resultDevices.data ?? [];

    final updated = devices.map((device) {

      if (device.id == deviceId) {

        final newValue = !device.isFavorite;

        if (newValue) {
          prefs.setBool("favorite_$deviceId", true);
        } else {
          prefs.remove("favorite_$deviceId");
        }

        return device.copyWith(isFavorite: newValue);
      }

      return device;

    }).toList();

    emit(
      state.copyWith(
        resultDevices: Result(
          status: LoadStatus.success,
          data: updated,
        ),
      ),
    );
  }
  void updateRealtimeLogByCode(String code, AtomatLogResponse log) {

    final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);
    logs[code] = log;

    final devices = state.resultDevices.data ?? [];
    final device = devices.where((e) => e.code == code).firstOrNull;
    if (device == null) return;
    final updated = devices.map((d) {

      if (d.code == code) {
        return d.copyWith(
          realtimeLog: log,
          status: log.rlySta ?? d.status,
        );
      }

      return d;

    }).toList();

    /// stop countdown
    final countdowns = Map<int,int>.from(state.switchCountdowns);

    countdowns.remove(device.id);

    emit(state.copyWith(
      breakerLogs: logs,
      resultDevices: state.resultDevices.copyWith(data: updated),
      switchCountdowns: countdowns,
    ));
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
