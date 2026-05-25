import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/data/dto/meter_config/request/meter_config_request.dart';
import 'package:solar_energy/data/repositories/meter_config/meter_config_repository.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/AlarmConfigMeter/alarm_config_meter_response.dart';
import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import '../../general_device/analytics_overview/bloc/analytics_cubit.dart';
import 'device_info_screen/device_info_screen.dart';
import '../../../../data/dto/energy_report/energy_report_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../device/bloc/device_cubit.dart';
import 'package:dio/dio.dart';
import 'dart:async';
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;
Map<String, double> minMap = {};
Map<String, double> maxMap = {};
Map<String, double> deviceOverrideMap = {};
Map<String, double> thresholdMap = {};
final leakageLevels = [
  {"value": 0.0, "label": "An toàn"},
  {"value": 30.0, "label": "Dân dụng "},
  {"value": 100.0, "label": "Nguy hiểm"},
  {"value": 300.0, "label": "Rất nguy hiểm"},
];
Map<String, String> queryTypeMap = {};
Map<String, String> conditionMap = {};
const kPrimaryColor = Color(0xFF1ABC9C);
const kBackgroundColor = Color(0xFFF4F7F8);
class SettingScreen extends StatefulWidget {
  final dynamic device;

  const SettingScreen({
    super.key,
    required this.device,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool autoCutOverCurrent = false;
  bool autoCutOverVoltage = false;
  bool autoCutUnderVoltage = false;
  bool autoCutLeakage = false;
  bool autoCutTemperature = false;
  Timer? _timer;
  bool isTripped = false;
  String pricingType = "tiered";
  bool showPricingDetail = false;
  String userRole = "user"; // admin / manager / user
  bool pricingLocked = false;
  DateTime? lastProtectionTrip;
  List<Map<String, dynamic>> tierPrices = [
    {"from": 0, "to": 50, "price": 1806},
    {"from": 51, "to": 100, "price": 1866},
    {"from": 101, "to": 200, "price": 2167},
    {"from": 201, "to": 300, "price": 2729},
    {"from": 301, "to": 400, "price": 3050},
    {"from": 401, "to": 999999, "price": 3151},
  ];

  Map<String, double> touPrices = {
    "off_peak": 1200,
    "normal": 2200,
    "peak": 4000,
  };
  final _repo = GetIt.instance<MeterConfigRepository>();
  String energyType = "DAY";
  double energyThreshold = 10;
  bool autoCut = false;
  double overCurrent = 63;
  double leakageCurrent = 30;
  double overVoltage = 240;
  double underVoltage = 220;
  double overPower = 5;
  double overTemperature = 70;
  bool phaseLoss = false;
  bool customThreshold = false;
  bool notifyApp = false;
  bool notifyEmail = false;
  bool saveLog = false;
  bool exportReport = false;
  bool isLoading = true;
  bool enableOverPower = false;
  double currentPower = 0;
  bool hasUnsavedChanges = false;
  bool hasSentOverEnergyAlert = false;
  void markChanged() {
    if (!hasUnsavedChanges) {
      setState(() {
        hasUnsavedChanges = true;
      });
    }
  }
  bool isOverPowerNow() {
    if (!enableOverPower) return false;
    return currentPower > overPower;
  }
  bool get canEditPricing {
    return userRole == "admin" || !pricingLocked;
  }
  double getMax(String param) {
    return maxMap[param] ?? defaultMax(param);
  }

  double getMin(String param) {
    return minMap[param] ?? defaultMin(param);
  }
  double defaultMin(String param) {
    switch (param) {

    ///  Quá dòng (100% → 63A)
      case "I":
        return 0;

    ///  Dòng rò
      case "PARAM_LG":
        return 0;

    ///  Điện áp (40% của 220V)
      case "PARAM_U":
        return 88;

    ///  Nhiệt độ
      case "PARAM_TEMP1":
        return 45;

    ///  Công suất (nếu có dùng)
      case "PARAM_P":
        return 0;

      default:
        return 0;
    }
  }

  double defaultMax(String param) {
    switch (param) {

    ///  Quá dòng (120% × 63)
      case "I":
        return 63;

    ///  Dòng rò
      case "PARAM_LG":
        return 300;

    ///  Điện áp (140% × 220)
      case "PARAM_U":
        return 308;

    ///  Nhiệt độ
      case "PARAM_TEMP1":
        return 140;

    ///  Công suất
      case "PARAM_P":
        return 100;

      default:
        return 100;
    }
  }

  String getLeakageDescription(double value) {
    if (value < 10) return "An toàn";
    if (value < 20) return "Giật nhẹ";
    if (value < 50) return "Khó thở, co giật";
    if (value < 100) return "Nguy hiểm";
    return "Nguy cơ ngừng tim";
  }
  // void checkPowerAlert() {
  //   print("👉 checkOverEnergy CALLED");
  //
  //   if (!enableOverPower) {
  //     print("❌ OverPower OFF");
  //     return;
  //   }
  //   checkOverEnergy();
  // }
  @override
  void initState() {
    super.initState();

    loadAll();

    startProtectionMonitor();
  }
  Future<List<EnergyReportResponse>> loadEnergyData() async {
    final cubit = context.read<AnalyticsCubit>();

    await cubit.loadEnergy(
      powerStationId: widget.device.powerStationId,
      deviceId: widget.device.id,
      type: energyType,
    );

    return cubit.state.data;
  }
  // Future<void> checkOverEnergy() async {
  //   if (!enableOverPower) {
  //     print("❌ OverPower OFF");
  //     return;
  //   }
  //
  //   print("🚀 CHECK OVER ENERGY");
  //   print("👉 Type: $energyType");
  //   print("👉 Threshold: $energyThreshold kWh");
  //
  //   final data = await loadEnergyData();
  //
  //   print("📊 Data length: ${data.length}");
  //
  //   if (data.isEmpty) {
  //     print("❌ No data");
  //     return;
  //   }
  //
  //   final total = data.fold(0.0, (a, b) => a + b.epi);
  //
  //   print("TOTAL ENERGY: $total kWh");
  //
  //   if (total > energyThreshold) {
  //
  //     /// tránh spam mỗi 10s
  //     if (!hasSentOverEnergyAlert) {
  //
  //       hasSentOverEnergyAlert = true;
  //
  //       print("🔥 VƯỢT NGƯỠNG");
  //
  //       /// lưu notification local
  //       await saveLocalNotification(
  //         title: widget.device.name ?? "Thiết bị",
  //         message:
  //         "⚠ Điện năng vượt ngưỡng "
  //             "$energyThreshold kWh ($energyType)",
  //       );
  //
  //       /// snackbar app
  //       if (notifyApp && mounted) {
  //
  //         print("📢 SHOW ALERT");
  //
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "⚠ Điện năng vượt ngưỡng",
  //             ),
  //             backgroundColor: Colors.orange,
  //           ),
  //         );
  //       }
  //
  //       /// auto cut
  //       if (autoCut) {
  //
  //         print("🔌 AUTO CUT DEVICE");
  //
  //         await sendOffCommand();
  //
  //         /// log thêm
  //         await saveLocalNotification(
  //           title: widget.device.name ?? "Thiết bị",
  //           message:
  //           "🔌 Thiết bị đã tự động ngắt",
  //         );
  //       }
  //     }
  //
  //   } else {
  //
  //     /// reset để lần sau báo lại
  //     hasSentOverEnergyAlert = false;
  //
  //     print("✅ OK - chưa vượt");
  //   }
  // }
  Future<void> saveLocalNotification({
    required String title,
    required String message,
    bool isAlert = true,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    final oldData =
    prefs.getString("local_notifications");

    List list = [];

    if (oldData != null) {
      try {
        list = jsonDecode(oldData);
      } catch (e) {
        list = [];
      }
    }

    list.insert(0, {
      "title": title,
      "message": message,
      "time": DateTime.now().toIso8601String(),
      "isAlert": isAlert,
    });
    if (list.length > 200) {
      list = list.take(200).toList();
    }
    await prefs.setString(
      "local_notifications",
      jsonEncode(list),
    );
    final oldCount =
        prefs.getInt("notification_badge_count") ?? 0;

    await prefs.setInt(
      "notification_badge_count",
      oldCount + 1,
    );
  }
  Future<void> sendOffCommand() async {

    final api = GetIt.instance<ApiClient>();

    final deviceCubit =
    context.read<DeviceCubit>();

    final realtimeLog =
    deviceCubit.state.breakerLogs[
    widget.device.code
    ];

    final rawAddr =
        realtimeLog?.addr ??
            widget.device.realtimeLog?.addr ??
            "";

    print("RAW ADDR: $rawAddr");

    if (rawAddr.isEmpty) {
      debugPrint("ADDR NULL");
      return;
    }

    final addr = rawAddr.trim();

    print("FINAL ADDR: $addr");

    final command = {
      "method": "operate",
      "payload": {
        "status": "OFF"
      }
    };

    final request = CbsMeterRequest(
      gatewaySn: widget.device.gatewayNumber ?? '',
      breakerSn: widget.device.code,
      addr: addr,
      createdBy: "app",
      commandValue: "0",
      isForce: true,
    );

    await api.controlCircuitBreaker(request);
    lastProtectionTrip = DateTime.now();
  }
  @override
  void dispose() {

    _timer?.cancel();

    super.dispose();
  }
  Future<void> loadThreshold() async {
    final api = GetIt.instance<ApiClient>();

    try {
      final res = await api.getAlarmConfigs(0, 100);

      minMap.clear();
      maxMap.clear();

      for (var e in res.data['items'])  {
        final param = mapParam(e['logParam']);
        final type = e['queryType'];
        final condition = e['queryCondition'];

        if (param.isEmpty) continue;

        if (type == "Max") {
          final v = double.parse(condition);

          if (!maxMap.containsKey(param) || v > maxMap[param]!) {
            maxMap[param] = v;
          }
        }

        else if (type == "Min") {
          final v = double.parse(condition);

          if (!minMap.containsKey(param) || v < minMap[param]!) {
            minMap[param] = v;
          }
        }

        else if (type == "Between") {
          final parts = condition.split("AND");
          final min = double.parse(parts[0].trim());
          final max = double.parse(parts[1].trim());

          if (!minMap.containsKey(param) || min < minMap[param]!) {
            minMap[param] = min;
          }

          if (!maxMap.containsKey(param) || max > maxMap[param]!) {
            maxMap[param] = max;
          }
        }
      }

      print("MIN MAP: $minMap");
      print("MAX MAP: $maxMap");

      setState(() {});
    } catch (e) {
      debugPrint("Load threshold error: $e");
    }
  }
  bool isOverThreshold(String param, double value) {
    final type = queryTypeMap[param];
    final condition = conditionMap[param];

    if (type == null || condition == null) return false;

    if (type == "Max") {
      return value > double.parse(condition);
    }

    if (type == "Min") {
      return value < double.parse(condition);
    }

    if (type == "Between") {
      final parts = condition.split("AND");
      final min = double.parse(parts[0].trim());
      final max = double.parse(parts[1].trim());
      return value < min || value > max;
    }

    return false;
  }
  void mapThreshold(List<AlarmConfigMeterResponse> data) {
    minMap.clear();
    maxMap.clear();

    for (var e in data) {
      final code = mapParam(e.meterCode);
      final v = double.tryParse(e.thresholdValue) ?? 0;

      if (e.thresholdType == "Max") {
        maxMap[code] = v;
      } else if (e.thresholdType == "Min") {
        minMap[code] = v;
      } else if (e.thresholdType == "Between") {
        final parts = e.thresholdValue.split("AND");
        minMap[code] = double.parse(parts[0].trim());
        maxMap[code] = double.parse(parts[1].trim());
      }
    }

    setState(() {});
  }
  String mapParam(String code) {
    switch (code) {
      case "PARAM_I": return "I";
      case "PARAM_LG": return "PARAM_LG";
      case "PARAM_U":
      case "PARAM_UA": return "PARAM_U";
      case "PARAM_P": return "PARAM_P";
      case "PARAM_TEMP1": return "PARAM_TEMP1";
      default: return code;
    }
  }
  Future<void> loadAll() async {
    await Future.wait([
      loadConfig(),
      loadThreshold(),
    ]);
  }
  void startProtectionMonitor() {

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) async {

        await checkProtection();
      },
    );
  }
  Future<void> checkProtection() async {
    if (lastProtectionTrip != null) {

      final diff =
      DateTime.now().difference(lastProtectionTrip!);

      if (diff.inSeconds < 10) {

        print("SKIP PROTECTION");

        return;
      }
    }
    try {

      final api = GetIt.instance<ApiClient>();

      /// API realtime của device
      final deviceCubit =
      context.read<DeviceCubit>();

      final realtime =
      deviceCubit.state.breakerLogs[
      widget.device.code
      ];

      final current =
          realtime?.ia ?? 0;

      final voltage =
          realtime?.ua ?? 0;
      /// hiện chưa có leakage thật
      final leakage =
      (realtime?.lg ?? 0).toDouble();
      /// hiện chưa có nhiệt độ thật
      final temperature = [
        realtime?.temp1 ?? 0,
        realtime?.temp2 ?? 0,
        realtime?.temp3 ?? 0,
        realtime?.temp4 ?? 0,
      ].reduce((a, b) => a > b ? a : b);
      print("CURRENT: $current");
      print("LIMIT: $overCurrent");
      /// ===== QUÁ DÒNG =====
      if (current > overCurrent) {

        if (autoCutOverCurrent) {
          await sendOffCommand();
        }

        await triggerProtection(
          "Quá dòng: ${current.toStringAsFixed(1)}A",
          didCut: autoCutOverCurrent,
        );

        return;
      }

      /// ===== QUÁ ÁP =====
      if (voltage > 0 &&
          voltage > overVoltage) {

        if (autoCutOverVoltage) {
          await sendOffCommand();
        }

        await triggerProtection(
          "Quá áp: ${voltage.toStringAsFixed(0)}V",
          didCut: autoCutOverVoltage,
        );

        return;
      }

      /// ===== THẤP ÁP =====
      if (voltage > 0 &&
          voltage < underVoltage) {

        if (autoCutUnderVoltage) {
          await sendOffCommand();
        }

        await triggerProtection(
          "Thấp áp: ${voltage.toStringAsFixed(0)}V",
          didCut: autoCutUnderVoltage,
        );

        return;
      }

      /// ===== DÒNG RÒ =====
      if (leakage > leakageCurrent) {

        if (autoCutLeakage) {
          await sendOffCommand();
        }

        await triggerProtection(
          "Dòng rò: ${leakage.toStringAsFixed(0)}mA",
          didCut: autoCutLeakage,
        );

        return;
      }

      /// ===== QUÁ NHIỆT =====
      if (temperature > overTemperature) {

        if (autoCutTemperature) {
          await sendOffCommand();
        }

        await triggerProtection(
          "Quá nhiệt: ${temperature.toStringAsFixed(0)}°C",
          didCut: autoCutTemperature,
        );

        return;
      }

      /// reset nếu tất cả đã ổn
      final allNormal =
          current <= overCurrent &&
              (voltage == 0 || (
                  voltage <= overVoltage &&
                      voltage >= underVoltage
              )) &&
              leakage <= leakageCurrent &&
              temperature <= overTemperature;

      if (allNormal) {
        isTripped = false;
      }

    } catch (e) {

      debugPrint("CHECK PROTECTION ERROR: $e");
    }
  }
  Future<void> triggerProtection(
      String reason, {
        bool didCut = false,
      }) async {

    /// tránh spam
    if (isTripped) return;

    isTripped = true;

    // /// auto off
    // await sendOffCommand();
    await saveLocalNotification(
      title: widget.device.name ?? "Thiết bị",
      message: didCut
          ? "$reason - Thiết bị đã tự động ngắt"
          : reason,
      isAlert: true,
    );

    /// snackbar
    if (mounted) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              didCut
                  ? "⚠ $reason\nThiết bị đã tự động ngắt"
                  : "⚠ $reason"
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }

    /// log
    debugPrint("TRIPPED: $reason");
  }

  Future<void> loadConfig() async {
    try {
      final res = await _repo.getConfigs(widget.device.id);

      for (var e in res) {
        print("CONFIG KEY: ${e.configKey}");
        print("CONFIG VALUE: ${e.configValue}");
        switch (e.configKey) {
          case 'over_current':

            print("LOAD OVER CURRENT: ${e.configValue}");

            overCurrent = double.parse(e.configValue);

            break;
          case 'leakage_current':
            leakageCurrent = double.parse(e.configValue);
            break;
          case 'over_voltage':
            overVoltage = double.parse(e.configValue);
            break;
          case 'under_voltage':
            underVoltage = double.parse(e.configValue);
            break;
          case 'over_power':
            overPower = double.parse(e.configValue);
            break;
          case 'phase_loss':
            phaseLoss = e.configValue == 'true';
            break;

          case 'custom_threshold':
            customThreshold = e.configValue == 'true';
            break;

          case 'notify_app':
            notifyApp = e.configValue == 'true';
            break;

          case 'notify_email':
            notifyEmail = e.configValue == 'true';
            break;

          case 'save_log':
            saveLog = e.configValue == 'true';
            break;
          case 'pricing_type':
            pricingType = e.configValue.toString() == '1'
                ? "tiered"
                : "time_of_use";
            break;
          case 'export_report':
            exportReport = e.configValue == 'true';
            break;
          case 'over_temperature':
            overTemperature = double.parse(e.configValue);
            break;
          case 'enable_over_power':
            enableOverPower = e.configValue == 'true';
            break;
          case 'auto_cut_over_current':
            autoCutOverCurrent =
                e.configValue == 'true';
            break;

          case 'auto_cut_over_voltage':
            autoCutOverVoltage =
                e.configValue == 'true';
            break;

          case 'auto_cut_under_voltage':
            autoCutUnderVoltage =
                e.configValue == 'true';
            break;

          case 'auto_cut_leakage':
            autoCutLeakage =
                e.configValue == 'true';
            break;

          case 'auto_cut_temperature':
            autoCutTemperature =
                e.configValue == 'true';
            break;
        }
      }
    } catch (e) {
      debugPrint("Load config error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }
  String? validateConfig() {

    if (underVoltage >= overVoltage) {
      return "Thấp áp phải nhỏ hơn quá áp";
    }

    if (overCurrent <= 0) {
      return "Quá dòng không hợp lệ";
    }
    final deviceCubit = context.read<DeviceCubit>();

    final realtime =
    deviceCubit.state.breakerLogs[
    widget.device.code
    ];

    final currentRealtime =
        realtime?.ia ?? 0;

    if (overCurrent <= currentRealtime + 1) {
      return "Quá dòng phải lớn hơn dòng hiện tại (${currentRealtime.toStringAsFixed(1)}A)";
    }
    if (leakageCurrent < 0) {
      return "Dòng rò không hợp lệ";
    }

    if (overTemperature < 45) {
      return "Nhiệt độ quá thấp";
    }

    if (enableOverPower && overPower <= 0) {
      return "Ngưỡng điện năng không hợp lệ";
    }

    return null;
  }
  // ================= SAVE CONFIG =================

  Future<void> saveConfig() async {

    final error = validateConfig();

    if (error != null) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.orange,
        ),
      );

      return;
    }

    try {
      final configs = <MeterConfigRequest>[
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_current",
          configValue:
          overCurrent.round().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "leakage_current",
          configValue:
          leakageCurrent.round().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_voltage",
          configValue:
          overVoltage.round().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "under_voltage",
          configValue:
          underVoltage.round().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_power",
          configValue: overPower.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "phase_loss",
          configValue: phaseLoss.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "custom_threshold",
          configValue: customThreshold.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "notify_app",
          configValue: notifyApp.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "notify_email",
          configValue: notifyEmail.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "save_log",
          configValue: saveLog.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "export_report",
          configValue: exportReport.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "pricing_type",
          configValue: (pricingType == "tiered" ? 1 : 0).toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_temperature",
          configValue:
          overTemperature.round().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "enable_over_power",
          configValue: enableOverPower.toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "auto_cut_over_current",
          configValue: autoCutOverCurrent.toString(),
        ),

        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "auto_cut_over_voltage",
          configValue: autoCutOverVoltage.toString(),
        ),

        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "auto_cut_under_voltage",
          configValue: autoCutUnderVoltage.toString(),
        ),

        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "auto_cut_leakage",
          configValue: autoCutLeakage.toString(),
        ),

        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "auto_cut_temperature",
          configValue: autoCutTemperature.toString(),
        ),
      ];

      print("CONFIG COUNT: ${configs.length}");

      for (final c in configs) {
        print(c.toJson());
      }
      await _repo.saveConfigs(configs);
      print("SAVE OVER CURRENT: $overCurrent");
      await loadConfig();
      if (mounted) {
        setState(() {});
      }
      await checkProtection();
      hasUnsavedChanges = false;
      pricingLocked = true;
      bool ok = true;

      try {
        ok = await sendProtectionSetting();
      } catch (_) {}
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("pricing_type", pricingType);
      if (!mounted) return;

      if (ok == true) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Lưu cài đặt thành công"),
            backgroundColor: Colors.green,
          ),
        );

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Đã lưu cấu hình.\nThiết bị hiện chưa online để đồng bộ.",
            ),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 4),
          ),
        );
      }

    } catch (e, s) {

      String message = "Không thể lưu cài đặt.";

      if (e is DioException) {

        final statusCode = e.response?.statusCode;

        final authHeader =
        e.response?.headers.value("www-authenticate");

        if (statusCode == 401) {

          message =
          "Phiên đăng nhập đã hết hạn.\nVui lòng đăng nhập lại.";

        }
        else if (
        statusCode == 302 ||
            statusCode == 403 ||
            (authHeader?.contains("insufficient_access") ?? false)
        ) {

          message =
          "Tài khoản không có quyền lưu cấu hình.";

        }
        else {

          message =
          "Lưu cấu hình thất bại.\nVui lòng thử lại.";
        }

        print("STATUS CODE: $statusCode");
        print("AUTH HEADER: $authHeader");
      }

      print("SAVE ERROR: $e");
      print(s);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: !hasUnsavedChanges,

        onPopInvoked: (didPop) async {

          if (didPop) return;

          final action = await showDialog<String>(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("Chưa lưu thay đổi"),
                content: Text(
                  "Bạn có muốn lưu thay đổi trước khi thoát không?",
                ),
                actions: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, "cancel");
                    },
                    child: Text("Huỷ"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, "discard");
                    },
                    child: Text("Thoát"),
                  ),

                  ElevatedButton(
                    onPressed: () async {

                      Navigator.pop(context, "save");

                    },
                    child: Text("Lưu"),
                  ),
                ],
              );
            },
          );

          if (action == "discard") {

            if (mounted) {
              Navigator.pop(context);
            }
          }

          else if (action == "save") {

            await saveConfig();

            if (mounted) {
              Navigator.pop(context);
            }
          }
        },

        child: Scaffold(
      backgroundColor: const Color(0xFFF2F4F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.device.name ?? widget.device.code ?? "Thông tin"),

        actions: [
          IconButton(
            icon: const Icon(Icons.device_hub),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeviceInfoScreen(device: widget.device),
                ),
              );
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.electrical_services, size: 22),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.device.name ?? widget.device.code ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Gateway: ${widget.device.gatewayNumber ?? ''}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildProtectionCard(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: saveConfig,
                child: const Text("Lưu cài đặt"),
              ),
            ),
          ],
        ),
      ),
        )
    );
  }

  // ================= PROTECTION UI =================

  Widget _buildProtectionCard() {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Bảo vệ dòng điện",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildItemCard(
              title: "Quá dòng",
              child: Column(
                children: [
                  _buildSliderTile(
                    title: "Quá dòng",
                    unit: "A",
                    value: overCurrent,
                    min: getMin("I"),
                    max: getMax("I"),
                    isOverCurrent: true,
                    description: "Thiết bị sẽ ngắt nếu dòng vượt giá trị này",
                    onChanged: (v) {
                      setState(() => overCurrent = v);
                      markChanged();
                    },
                  ),
                  _buildSwitchItem(
                    "Tự động ngắt khi vượt ngưỡng",
                    autoCutOverCurrent,
                        (v) {
                      setState(() => autoCutOverCurrent = v);
                      markChanged();
                    },
                  ),
                  // _buildRecommendBox(),
                ],
              ),
            ),

            _buildItemCard(
              title: "Dòng rò",
              child: _buildSliderTile(
                title: "Dòng rò",
                unit: "mA",
                value: leakageCurrent,
                min: getMin("PARAM_LG"),
                max: getMax("PARAM_LG"),
                description: getLeakageLevel(leakageCurrent),
                onChanged: (v) {
                  setState(() => leakageCurrent = v);
                  markChanged();
                },
              ),

            ),
            _buildSwitchItem(
              "Tự động ngắt khi vượt ngưỡng",
              autoCutLeakage,
                  (v) {
                setState(() => autoCutLeakage = v);
                markChanged();
              },
            ),


            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Bảo vệ điện áp",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            _buildItemCard(
              title: "Điện áp",
              child: Column(
                children: [


                  _buildSliderTile(
                    title: "Quá áp",
                    unit: "V",
                    value: overVoltage,
                    min: getMin("PARAM_U"),
                    max: getMax("PARAM_U"),
                    isVoltage: true,
                    onChanged: (v) {
                      setState(() => overVoltage = v);
                      markChanged();
                    },
                  ),
                  _buildSwitchItem(
                    "Tự động cắt quá áp",
                    autoCutOverVoltage,
                        (v) {
                      setState(() => autoCutOverVoltage = v);
                      markChanged();
                    },
                  ),

                  const SizedBox(height: 6),

                  _buildSliderTile(
                    title: "Thấp áp",
                    unit: "V",
                    value: underVoltage,
                    min: getMin("PARAM_U"),
                    max: getMax("PARAM_U"),
                    isVoltage: true,
                    onChanged: (v) {
                      setState(() => underVoltage = v);
                      markChanged();
                    },
                  ),
                  _buildSwitchItem(
                    "Tự động cắt thấp áp",
                    autoCutUnderVoltage,
                        (v) {
                      setState(() => autoCutUnderVoltage = v);
                      markChanged();
                    },
                  ),
                ],
              ),
            ),

            _buildItemCard(
              title: "Quá nhiệt",
              child: _buildSliderTile(
                title: "Quá nhiệt",
                unit: "°C",
                value: overTemperature,
                min: getMin("PARAM_TEMP1"),
                max: getMax("PARAM_TEMP1"),
                description: "Ngắt khi nhiệt độ vượt ngưỡng",
                onChanged: (v) {
                  setState(() => overTemperature = v);
                  markChanged();
                },
              ),

            ),
            _buildSwitchItem(
              "Tự động ngắt khi vượt ngưỡng",
              autoCutTemperature,
                  (v) {
                setState(() => autoCutTemperature = v);
                markChanged();
              },
            ),
            _buildItemCard(
              title: "Quá điện năng",
              child: Column(
                children: [

                  /// SWITCH
                  _buildSwitchItem(
                    "Tính năng quá điện năng",
                    enableOverPower,
                        (v) {
                      setState(() {
                        enableOverPower = v;

                        if (!v) {
                          autoCut = false;
                        }
                      });

                      // if (v) {
                      //   checkOverEnergy();
                      // }
                    },
                  ),

                  const SizedBox(height: 8),

                  /// SLIDER (chỉ hiện khi bật)
                  if (enableOverPower) ...[

                    /// chọn thời gian
                    Row(
                      children: ["DAY", "WEEK", "MONTH", "YEAR"].map((e) {
                        final active = energyType == e;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => energyType = e),

                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              padding: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: active ? kPrimaryColor : Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: active ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 8),

                    /// input kWh
                    _buildSliderTile(
                      title: "Ngưỡng điện năng",
                      unit: "kWh",
                      value: energyThreshold,
                      min: 0,
                      max: 100,
                      description: "Nhập tổng điện năng tối đa ($energyType)",
                      onChanged: (v) {
                        setState(() => energyThreshold = v);
                        markChanged();
                      },
                    ),

                    /// auto cut
                    _buildSwitchItem(
                      "Tự động cắt thiết bị",
                      autoCut,
                          (v) => setState(() => autoCut = v),
                    ),

                  ],

                ],
              ),
            ),
            const SizedBox(height: 10),

            _buildItemCard(
              title: "Thông báo",
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                childAspectRatio: isTablet(context) ? 5.5 : 3.2,

                children: [

                  _buildSwitchItem(
                    "Mất pha",
                    phaseLoss,
                        (v) {
                      setState(() => phaseLoss = v);
                      markChanged();
                    },
                  ),

                  _buildSwitchItem(
                    "Set ngưỡng riêng",
                    customThreshold,
                        (v) {
                      setState(() => customThreshold = v);
                      markChanged();
                    },
                  ),

                  _buildSwitchItem(
                    "Cảnh báo qua App",
                    notifyApp,
                        (v) {
                      setState(() => notifyApp = v);
                      markChanged();
                    },
                  ),

                  _buildSwitchItem(
                    "Cảnh báo Email",
                    notifyEmail,
                        (v) {
                      setState(() => notifyEmail = v);
                      markChanged();
                    },
                  ),

                  _buildSwitchItem(
                    "Lưu log cảnh báo",
                    saveLog,
                        (v) {
                      setState(() => saveLog = v);
                      markChanged();
                    },
                  ),

                  _buildSwitchItem(
                    "Xuất báo cáo",
                    exportReport,
                        (v) {
                      setState(() => exportReport = v);
                      markChanged();
                    },
                  ),
                ],
              ),
            ),
              _buildItemCard(
                title: "Cài đặt biểu giá",

                child: Column(
                  children: [

                    Row(
                      children: [

                        /// HỘ GIA ĐÌNH
                        Expanded(
                          child: GestureDetector(
                            onTap: canEditPricing
                                ? () {
                              setState(() {
                                pricingType = "tiered";
                              });
                            }
                                : null,
                            child: Opacity(
                              opacity: pricingType == "tiered" ? 1 : 0.45,
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: pricingType == "tiered"
                                      ? kPrimaryColor.withOpacity(0.15)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: pricingType == "tiered"
                                        ? kPrimaryColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hộ gia đình",
                                      ),

                                      if (pricingType == "tiered" && pricingLocked) ...[
                                        SizedBox(width: 4),
                                        Icon(Icons.lock, size: 13),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        /// CÔNG NGHIỆP
                        Expanded(
                          child: GestureDetector(
                            onTap: canEditPricing
                                ? () {
                              setState(() {
                                pricingType = "time_of_use";
                              });
                            }
                                : null,
                            child: Opacity(
                              opacity: pricingType == "time_of_use" ? 1 : 0.45,
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: pricingType == "time_of_use"
                                      ? kPrimaryColor.withOpacity(0.15)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: pricingType == "time_of_use"
                                        ? kPrimaryColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text(
                                        "Công nghiệp",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: pricingType == "time_of_use"
                                              ? kPrimaryColor
                                              : Colors.black54,
                                        ),
                                      ),

                                      if (pricingType == "time_of_use" && pricingLocked) ...[
                                        const SizedBox(width: 4),
                                        Icon(
                                          pricingLocked
                                              ? Icons.lock
                                              : Icons.lock_open,
                                          size: 13,
                                          color: kPrimaryColor,
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (userRole == "admin") ...[
                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              pricingLocked = false;
                            });
                          },
                          icon: Icon(
                            Icons.lock_open,
                            size: 16,
                            color: Colors.orange,
                          ),
                          label: Text(
                            "Reset biểu giá",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showPricingDetail = !showPricingDetail;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                showPricingDetail
                                    ? "Ẩn cấu hình biểu giá"
                                    : "Hiện cấu hình biểu giá",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            AnimatedRotation(
                              turns: showPricingDetail ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (showPricingDetail) ...[
                      const SizedBox(height: 10),

                      if (pricingType == "tiered")
                        _buildTierPricing()
                      else
                        _buildTouPricing(),
                    ],
                  ],
                ),

              ),
              ]
            )
    );
  }
  String getLeakageLevel(double value) {
    double closest = 0;
    double minDiff = double.infinity;

    for (var e in leakageLevels) {
      final v = e["value"] as double;
      final diff = (value - v).abs();

      if (diff < minDiff) {
        minDiff = diff;
        closest = v;
      }
    }

    return leakageLevels
        .firstWhere((e) => e["value"] == closest)["label"]
        .toString();
  }
  bool isNearLevel(double value, double target) {
    return (value - target).abs() < 3;
  }
  Widget _buildSwitchItem(
      String title,
      bool value,
      Function(bool) onChanged,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet(context) ? 8 : 10,
        vertical: isTablet(context) ? 2 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),


          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: value,
              activeColor: kPrimaryColor,
              activeTrackColor: kPrimaryColor.withOpacity(.4),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> sendProtectionSetting() async {

    try {

      final api = GetIt.instance<ApiClient>();

      final deviceCubit =
      context.read<DeviceCubit>();

      final realtimeLog =
      deviceCubit.state.breakerLogs[
      widget.device.code
      ];

      final addr =
          realtimeLog?.addr ??
              widget.device.realtimeLog?.addr ??
              "";

      print("SEND CONFIG ADDR: $addr");

      if (addr.isEmpty) {
        return true;
      }

      /// TODO:
      /// gửi command thật ở đây

      return true;

    } catch (e) {

      print("SEND CONFIG ERROR: $e");

      /// QUAN TRỌNG
      return true;
    }
  }

  Widget _buildSliderTile({
    required String title,
    required String unit,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    bool isVoltage = false,
    bool isOverCurrent = false,
    String? description,
  }) {
    final safeMax = (max <= min) ? (min + 1) : max;
    final safeValue = value.clamp(min, safeMax);
    final percent = ((safeValue - min) / (safeMax - min)).clamp(0.0, 1.0);

    ///  GIỮ NGUYÊN LOGIC MÀU
    Color valueColor;

    if (title == "Dòng rò") {
      if (value >= 100) {
        valueColor = Colors.red;
      } else if (value >= 50) {
        valueColor = Colors.orange;
      } else if (value >= 20) {
        valueColor = Colors.amber;
      } else {
        valueColor = kPrimaryColor;
      }
    }
    else if (isVoltage) {
      if (percent < 0.5) {
        valueColor = const Color(0xFF1ABC9C);
      } else if (percent < 0.8) {
        valueColor = const Color(0xFFFF9800);
      } else {
        valueColor = const Color(0xFFE53935);
      }
    }
    else {
      valueColor = kPrimaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 11),
                    ),

                    if (description != null) ...[
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          " - $description",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              GestureDetector(
                onTap: () => _showInputDialog(
                  context,
                  value,
                  unit,
                  min,
                  max,
                  onChanged,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_alt_outlined,
                      size: 14,
                      color: valueColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${value.toInt()} $unit",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: valueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          ///  SLIDER + WARNING GỘP 1 CHỖ
          Column(
            children: [

              /// ===== SLIDER =====
              SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [

                    /// nền
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /// gradient
                    FractionallySizedBox(
                      widthFactor: percent,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: isOverCurrent
                              ? LinearGradient(
                            colors: [
                              Color(0xFF1ABC9C),
                              Color(0xFFF69C21),
                            ],
                          )
                              : LinearGradient(
                            colors: [
                              Color(0xFF1ABC9C),
                              Color(0xFFFFB74D),
                              Color(0xFFE53935),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 20,
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbShape: _ModernThumbShape(),
                        overlayShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        value: safeValue,
                        min: min,
                        max: safeMax,
                        onChanged: (v) => onChanged(v),
                      ),
                    ),
                  ],
                ),
              ),

              /// ===== MARKER (CHỈ DÒNG RÒ) =====
              if (title == "Dòng rò")
                SizedBox(
                  height: 34,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      return Stack(
                        children: [
                          for (var e in leakageLevels)
                            Positioned(
                              left: (((e["value"] as double) / max) * (width - 16))
                                  .clamp(0, width - 16),
                              child: Column(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (e["value"] as double) >= 100
                                          ? Colors.red
                                          : (e["value"] as double) >= 30
                                          ? Colors.orange
                                          : kPrimaryColor,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "${(e["value"] as double).toInt()}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

              /// ===== MIN MAX =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${min.toInt()}",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                  Text("${max.toInt()}",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showInputDialog(BuildContext context,
      double current,
      String unit,
      double min,
      double max,
      Function(double) onChanged,) {
    final controller =
    TextEditingController(text: current.toInt().toString());

    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: Text("Nhập giá trị ($unit)"),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: unit,
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Hủy"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text("OK"),
                onPressed: () {
                  final v = double.tryParse(controller.text);
                  if (v != null && v >= min && v <= max) {
                    onChanged(v);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
    );
  }
  Widget _buildItemCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFB2E6B4)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          child,
        ],
      ),
    );
  }
  Widget _buildTierPricing() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: tierPrices.map((e) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Bậc ${tierPrices.indexOf(e) + 1}"
                        " (${e["from"]}-${e["to"]} kWh)",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                  ),
                  child: Text(
                    "${e["price"]} đ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildTouPricing() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          _buildTouItem("Thấp điểm", "off_peak"),
          _buildTouItem("Bình thường", "normal"),
          _buildTouItem("Cao điểm", "peak"),
        ],
      ),
    );
  }
  Widget _buildTouItem(String title, String key) {

    final canEdit =
        pricingType == "time_of_use" &&
            userRole == "admin";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ),

          SizedBox(
            width: 110,

            child: canEdit

                ? TextFormField(
              initialValue:
              touPrices[key]!.toStringAsFixed(0),

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                isDense: true,
                suffixText: "đ",
                border: OutlineInputBorder(),
              ),

              onChanged: (v) {

                touPrices[key] =
                    double.tryParse(v) ?? 0;

                markChanged();
              },
            )

                : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Text(
                "${touPrices[key]!.toStringAsFixed(0)} đ",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(18, 18);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;



    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: 12)),
      Colors.black.withOpacity(.15),
      4,
      true,
    );


    canvas.drawCircle(center, 18, Paint()..color = Colors.white);


    canvas.drawCircle(
      center,
      12,
      Paint()
        ..color = kPrimaryColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    canvas.drawCircle(center, 4, Paint()..color = kPrimaryColor);

  }
}