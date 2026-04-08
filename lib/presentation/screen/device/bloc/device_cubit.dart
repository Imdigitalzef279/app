import 'dart:async';
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
  final _timers = <int, Timer>{};
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
      print("TOKEN TRƯỚC MAINTENANCE: ${prefs.getString("access_token")}");
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
          status: LoadStatus.success,
        ),
      ));
      for (var d in updatedDevices) {
        if (d.code != null) {
          loadBreakerLog(d.code!);
        }
      }
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

    if (state.switchingDevices.containsKey(device.id)) return;

    final isValid = await _verifyForceAuth(password: password);
    if (!isValid) return;

    emit(state.copyWith(
      switchingDevices: {
        ...state.switchingDevices,
        device.id: true,
      },
    ));

    try {

      ///  load log mới nhất
      await loadBreakerLog(device.code!);

      final log = state.breakerLogs[device.code] ?? device.realtimeLog;
      if (log == null) {
        _removeSwitching(device.id);
        return;
      }
      ///  FIX QUAN TRỌNG: dùng chung logic với UI


      final realStatus = getRealStatus(device, log);

      final currentState = device.status ?? 0;

      final target = currentState == 1 ? "0" : "1";

      if (int.parse(target) == currentState) {
        AppToast.showToastError(title: "Thiết bị đã ở trạng thái này");
        _removeSwitching(device.id);
        return;
      }

      ///  không cho đóng cắt nếu:
      if (realStatus == -1) {
        AppToast.showToastError(title: "Thiết bị offline");
        _removeSwitching(device.id);
        return;
      }

      if (realStatus == 2) {
        AppToast.showToastError(title: "Đang bảo trì");
        _removeSwitching(device.id);
        return;
      }

      /// chỉ set loading
      emit(state.copyWith(
        switchingDevices: {
          ...state.switchingDevices,
          device.id: true,
        },
      ));
      startCountdown(device.id);
      final success = await switchCbsWithForce(device, target, true);

      if (!success) {
        _removeSwitching(device.id);
        AppToast.showToastError(title: "Gửi lệnh thất bại");
        return;
      }


      updateLocalStatus(device.id, int.parse(target));
      await Future.delayed(const Duration(seconds: 2));
      await loadBreakerLog(device.code!);

      await waitBreakerState(
        device.id,
        device.code!,
        int.parse(target),
      );

      /// countdown
      final expectedUi = int.parse(target);


    } catch (e) {
      AppToast.showToastError(title: "Lỗi");
    }

  }
  void _removeSwitching(int id) {
    final map = Map<int, bool>.from(state.switchingDevices);
    map.remove(id);
    emit(state.copyWith(switchingDevices: map));
  }
  void startCountdown(int deviceId) {

    _timers[deviceId]?.cancel();

    int count = 20;

    emit(state.copyWith(
      switchCountdowns: {
        ...state.switchCountdowns,
        deviceId: count,
      },
    ));

    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      count--;

      if (count < 0) {
        timer.cancel();
        _timers.remove(deviceId);

        final newMap = Map<int,int>.from(state.switchCountdowns);
        newMap.remove(deviceId);

        emit(state.copyWith(switchCountdowns: newMap));
        return;
      }

      final map = Map<int,int>.from(state.switchCountdowns);
      map[deviceId] = count;

      emit(state.copyWith(switchCountdowns: map));
    });

    _timers[deviceId] = timer;
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
      final log = device.realtimeLog ?? state.breakerLogs[device.code];

      final addr = log?.addr ?? "";
      if (addr.isEmpty) {
        AppToast.showToastError(title: "Chưa có dữ liệu thiết bị");
        emit(state.copyWith(isForceLoading: false));
        return;
      }

      final currentMaintenance = log?.rlyRepSta ?? 0;

      final commandValue = currentMaintenance == 1 ? 2 : 1;

      print("CURRENT MAINTENANCE: $currentMaintenance");
      print("COMMAND VALUE: $commandValue");

      final authRepo = getIt<AuthRepository>() as AuthRepositoryImpl;
      final username = authRepo.currentProfile?.userName ?? "";

      print("ADDR: $addr");
      print("COMMAND VALUE: $commandValue");

      final response = await _cbs.setBreakerMaintenance(
        CbsMeterRequest(
          addr: addr,
          breakerSn: device.code,
          gatewaySn: device.gatewayNumber,
          commandValue: commandValue.toString(), //  FIX
          createdBy: username,
          isForce: true,
        ),
      );

      if (response == -1) {
        AppToast.showToastError(title: "Không đổi bảo trì được");

        emit(state.copyWith(isForceLoading: false)); //  thêm luôn
        return;
      }

      await waitBreakerMaintenance(
        device.id,
        device.code,
        commandValue,
      );

      await loadBreakerLog(device.code);

    } catch (e) {
      AppToast.showToastError(title: "Có lỗi xảy ra");
    } finally {
      ///  QUAN TRỌNG NHẤT
      emit(state.copyWith(isForceLoading: false));
    }
  }
  Future<void> waitBreakerMaintenance(
      int deviceId,
      String breakerSn,
      int expected,
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

      ///  reload mỗi vòng
      await loadBreakerLog(breakerSn);

      final log = state.breakerLogs[breakerSn];
      final current = log?.rlySta;

      if (current == expected) {
        break;
      }
    }
    _removeSwitching(deviceId);
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


      final currentStatus =
          state.breakerLogs[latestDevice.code]?.rlySta ??
              latestDevice.realtimeLog?.rlySta ??
              latestDevice.status ??
              0;
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
      final rawAddr =
          state.breakerLogs[device.code]?.addr ??
              device.realtimeLog?.addr ??
              "";

      if (rawAddr.isEmpty) {
        print("ADDR NULL → không gửi");
        return false;
      }

      final addr = rawAddr; //

      print(" ADDR: $addr");
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
        print("❌ Breaker log empty");
        return;
      }


      /// ===== SORT NEWEST FIRST =====
      final logsList = List<AtomatLogResponse>.from(response.data!);

      logsList.sort((a, b) =>
          DateTime.parse(b.updatedAt!)
              .compareTo(DateTime.parse(a.updatedAt!)));

      final log = logsList.first;

      /// ===== UPDATE STATE =====
      final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);
      final old = state.breakerLogs[breakerSn];

      if (old != null && old.updatedAt != null && log.updatedAt != null) {
        final oldTime = DateTime.parse(old.updatedAt!);
        final newTime = DateTime.parse(log.updatedAt!);

        if (newTime.isBefore(oldTime)) {
          print("⚠ bỏ log cũ hơn");
          return;
        }

        if (newTime.isAtSameMomentAs(oldTime)) {
          if (log.rlySta == old.rlySta) {
            print("⚠ duplicate log");
            return;
          }
        }
      }

      logs[breakerSn] = log;

      final updatedDevices = (state.resultDevices.data ?? []).map((d) {
        if (d.code == breakerSn) {
          return d.copyWith(
            status: state.switchingDevices.containsKey(d.id)
                ? d.status
                : (log.rlySta ?? d.status ?? 0),
          );
        }
        return d;
      }).toList();

      emit(state.copyWith(
        breakerLogs: logs,
        resultDevices: state.resultDevices.copyWith(
          data: updatedDevices,
        ),
      ));

    } catch (e) {
      print("❌ LOAD LOG ERROR: $e");
    }
  }
  Future<void> waitBreakerState(
      int deviceId,
      String breakerSn,
      int expectedState,
      ) async {

    int retry = 20;
    await Future.delayed(const Duration(seconds: 3));

    bool success = false;

    while (retry > 0) {

      await Future.delayed(const Duration(seconds: 1));
      retry--;

      await loadBreakerLog(breakerSn);

      final log = state.breakerLogs[breakerSn];
      final current = log?.rlySta ?? 0;

      print("WAIT STATE: current=$current | expected=$expectedState");

      if (current == expectedState) {
        updateLocalStatus(deviceId, expectedState);

        success = true;
        break;
      }
    }

    if (success) {
      _removeSwitching(deviceId);
    }
    if (!success) {
      AppToast.showToastError(title: "Thiết bị không phản hồi");
    }
  }
  // ============================================================
  // HELPER
  // ============================================================
  int getRealStatus(DeviceResponse device, AtomatLogResponse? log) {
    if (state.switchingDevices.containsKey(device.id)) {
      return device.status ?? log?.rlySta ?? 0;
    }

    if (log == null) return -1;

    if (log.rlyRepSta == 1) return 2;

    if (log.state != null) {
      final s = log.state!.toLowerCase();
      if (!(s == "online" || s == "1" || s == "connected")) {
        return -1;
      }
    }
    // return device.status ?? log.rlySta ?? 0; này sai
    return log.rlySta ?? device.status ?? 0;
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
    return state.switchingDevices.containsKey(deviceId);
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
    final device = state.resultDevices.data
        ?.where((e) => e.code == code)
        .firstOrNull;

    if (device == null) return;

    final logs = Map<String, AtomatLogResponse>.from(state.breakerLogs);
    logs[code] = log;

    final updatedDevices = (state.resultDevices.data ?? []).map((d) {
      if (d.code == code) {
        return d.copyWith(
          realtimeLog: log,
          status: state.switchingDevices.containsKey(d.id)
              ? d.status
              : (log.rlySta ?? d.status ?? 0),
        );
      }
      return d;
    }).toList();

    emit(state.copyWith(
      breakerLogs: logs,
      resultDevices: state.resultDevices.copyWith(data: updatedDevices),
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