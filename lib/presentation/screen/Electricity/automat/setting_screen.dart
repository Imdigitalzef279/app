import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/data/dto/meter_config/request/meter_config_request.dart';
import 'package:solar_energy/data/repositories/meter_config/meter_config_repository.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/AlarmConfigMeter/alarm_config_meter_response.dart';
import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import 'device_info_screen/device_info_screen.dart';
Map<String, double> minMap = {};
Map<String, double> maxMap = {};
Map<String, double> deviceOverrideMap = {};
Map<String, double> thresholdMap = {};
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
  String pricingType = "time_of_use";
  final _repo = GetIt.instance<MeterConfigRepository>();

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
  bool isOverPowerNow() {
    if (!enableOverPower) return false;
    return currentPower > overPower;
  }
  double getMax(String param) {
    return maxMap[param] ?? defaultMax(param);
  }

  double getMin(String param) {
    return minMap[param] ?? defaultMin(param);
  }
  double defaultMin(String param) {
    switch (param) {
      case "I": return 0;

      case "PARAM_LG": return 0;

      case "PARAM_U": return 180;

      case "PARAM_TEMP1": return 20;

      case "PARAM_HUMI1": return 30;

      case "PARAM_P": return 0;

      default: return 0;
    }
  }

  double defaultMax(String param) {
    switch (param) {
      case "I": return 63;

      case "PARAM_LG": return 100;

      case "PARAM_U": return 220;

      case "PARAM_TEMP1": return 30;

      case "PARAM_HUMI1": return 70;

      case "PARAM_P": return 100;

      default: return 100;
    }
  }
  void checkPowerAlert() {
    if (isOverPowerNow() && notifyApp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠ Quá công suất!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    loadAll();
  }
  Future<void> loadThreshold() async {
    final api = GetIt.instance<ApiClient>();

    try {
      final res = await api.getAlarmConfigs(0, 100);

      minMap.clear();
      maxMap.clear();

      for (var e in res['items']) {
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

  Future<void> loadConfig() async {
    try {
      final res = await _repo.getConfigs(widget.device.id);

      for (var e in res) {
        switch (e.configKey) {
          case 'over_current':
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
        }
      }
    } catch (e) {
      debugPrint("Load config error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  // ================= SAVE CONFIG =================

  Future<void> saveConfig() async {
    try {
      final configs = <MeterConfigRequest>[
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_current",
          configValue: overCurrent.toInt().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "leakage_current",
          configValue: leakageCurrent.toInt().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_voltage",
          configValue: overVoltage.toInt().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "under_voltage",
          configValue: underVoltage.toInt().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_power",
          configValue: overPower.toInt().toString(),
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
          configValue: overTemperature.toInt().toString(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "enable_over_power",
          configValue: enableOverPower.toString(),
        ),
      ];


      await _repo.saveConfigs(configs);
      final ok = await sendProtectionSetting(); // <-- QUAN TRỌNG
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("pricing_type", pricingType);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ok ? "Lưu thành công" : "Thiết bị không phản hồi"),
            backgroundColor: ok ? Colors.green : Colors.red,
          ),
        );
      }

    } catch (e) {
      debugPrint("Save error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Lưu thất bại"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.electrical_services, size: 32),
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
              height: 55,
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
                    description: "Ngưỡng cắt khi dòng vượt mức cho phép",
                    onChanged: (v) => setState(() => overCurrent = v),
                  ),
                  _buildRecommendBox(),
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
                description: "Phát hiện rò điện để đảm bảo an toàn",
                onChanged: (v) => setState(() => leakageCurrent = v),
              ),
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
              title: "Quá áp",
              child: _buildSliderTile(
                title: "Quá áp",
                unit: "V",
                value: overVoltage,
                min: getMin("PARAM_U"),
                max: getMax("PARAM_U"),
                isVoltage: true,
                description: "Ngắt khi điện áp vượt ngưỡng an toàn",
                onChanged: (v) => setState(() => overVoltage = v),
              ),
            ),

            _buildItemCard(
              title: "Thấp áp",
              child: _buildSliderTile(
                title: "Thấp áp",
                unit: "V",
                value: underVoltage,
                min: getMin("PARAM_U"),
                max: getMax("PARAM_U"),
                isVoltage: true,
                description: "Ngắt khi điện áp thấp hơn mức cho phép",
                onChanged: (v) => setState(() => underVoltage = v),
              ),
            ),


            _buildItemCard(
              title: "Quá công suất",
              child: Column(
                children: [

                  /// SWITCH
                  _buildSwitchItem(
                    "Bật bảo vệ quá công suất",
                    enableOverPower,
                        (v) => setState(() => enableOverPower = v),
                  ),

                  const SizedBox(height: 8),

                  /// SLIDER (chỉ hiện khi bật)
                  if (enableOverPower)
                    _buildSliderTile(
                      title: "Ngưỡng công suất",
                      unit: "kW",
                      value: overPower,
                      min: getMin("PARAM_P"),
                      max: getMax("PARAM_P"),
                      description: "Ngắt khi vượt ngưỡng",
                      onChanged: (v) => setState(() => overPower = v),
                    ),

                  /// CẢNH BÁO REALTIME
                  if (isOverPowerNow())
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "⚠ Quá công suất (${currentPower.toStringAsFixed(1)} kW)",
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                onChanged: (v) => setState(() => overTemperature = v),
              ),
            ),

            const SizedBox(height: 10),

            _buildItemCard(
              title: "Cài đặt bổ sung",
              child: Column(
                children: [

                  _buildSwitchItem("Mất pha", phaseLoss,
                          (v) => setState(() => phaseLoss = v)),

                  _buildSwitchItem("Set ngưỡng riêng", customThreshold,
                          (v) => setState(() => customThreshold = v)),

                  _buildSwitchItem("Cảnh báo qua App", notifyApp,
                          (v) => setState(() => notifyApp = v)),
                  _buildSwitchItem("Cảnh báo Email", notifyEmail,
                          (v) => setState(() => notifyEmail = v)),

                  _buildSwitchItem("Lưu log cảnh báo", saveLog,
                          (v) => setState(() => saveLog = v)),

                  _buildSwitchItem("Xuất báo cáo", exportReport,
                          (v) => setState(() => exportReport = v)),
              _buildItemCard(
                title: "Cài đặt biểu giá",
                child: Row(
                  children: [

                    /// HỘ GIA ĐÌNH (EVN)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => pricingType = "tiered");
                        },
                        child: Container(
                          height: 36,
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
                            child: Text(
                              "Hộ gia đình",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: pricingType == "tiered"
                                    ? kPrimaryColor
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// CÔNG NGHIỆP (3 GIÁ)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => pricingType = "time_of_use");
                        },
                        child: Container(
                          height: 36,
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
                            child: Text(
                              "Công nghiệp",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: pricingType == "time_of_use"
                                    ? kPrimaryColor
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ]
            )
            )
          ],
        )
    );
  }

  Widget _buildSwitchItem(String title,
      bool value,
      Function(bool) onChanged,) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // xanh nhạt
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Switch(
            value: value,
            activeColor: kPrimaryColor,
            activeTrackColor: kPrimaryColor.withOpacity(.4),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Future<bool> sendProtectionSetting() async {
    try {
      final api = GetIt.instance<ApiClient>();

      final command = {
        "method": "operate",
        "payload": {
          "addr": "1_1",
          "IHighVal01": overCurrent.toInt().toString(),
          "LgHighVal01": leakageCurrent.toInt().toString(),
          "UHighVal01": overVoltage.toInt().toString(),
          "ULowVal01": underVoltage.toInt().toString(),
          "PHighVal01": enableOverPower
              ? overPower.toInt().toString()
              : "0",
          "T1HighVal01": overTemperature.toInt().toString(),
        }
      };

      final request = CbsMeterRequest(
        gatewaySn: widget.device.gatewaySn,
        breakerSn: widget.device.breakerSn,
        addr: "1_1",
        createdBy: "app",
        commandValue: jsonEncode(command),
        isForce: true,
      );

      final res = await api.controlCircuitBreaker(request);

      return res != null;

    } catch (e) {
      debugPrint("CBS error: $e");
      return false;
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
    bool showValue = true,
    bool isOverCurrent = false,
    String? description,
  }) {
    final safeMax = (max <= min) ? (min + 1) : max;
    final safeValue = value.clamp(min, safeMax);

    final percent = ((safeValue - min) / (safeMax - min)).clamp(0.0, 1.0);
    Color valueColor;
    if (!isVoltage) {
      valueColor = kPrimaryColor;
    } else {
      if (percent < 0.5) {
        valueColor = const Color(0xFF1ABC9C);
      } else if (percent < 0.8) {
        valueColor = const Color(0xFFFF9800);
      } else {
        valueColor = const Color(0xFFE53935);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            if (showValue)
              GestureDetector(
                onTap: () =>
                    _showInputDialog(
                      context,
                      value,
                      unit,
                      min,
                      max,
                      onChanged,
                    ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: valueColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${value.toInt()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: valueColor,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(unit, style: TextStyle(color: valueColor)),
                      const SizedBox(width: 4),
                      Icon(Icons.edit, size: 14, color: valueColor),
                    ],
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [

              /// TRACK + SLIDER
              Stack(
                alignment: Alignment.centerLeft,
                children: [

                  /// nền xám
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  /// active
    FractionallySizedBox(
    widthFactor: percent,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: isOverCurrent
                            ? const LinearGradient(
                          colors: [
                            Color(0xFF1ABC9C), // xanh
                            Color(0xFFF69C21), // cam (max)
                          ],
                        )
                            : const LinearGradient(
                          colors: [
                            Color(0xFF1ABC9C),
                            Color(0xFFFFB74D),
                            Color(0xFFE53935),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// slider thật
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 30,
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

              const SizedBox(height: 6),

              /// LABEL
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${min.toInt()}",
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text("${(min + max) ~/ 2}",
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                  Text("${max.toInt()}",
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              if (percent > 0.8)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "⚠ Gần ngưỡng nguy hiểm",
                    style: TextStyle(color: Colors.orange, fontSize: 11),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "(${min.toInt()} - ${max.toInt()} $unit)",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          ),

        )

      ],
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
}
Widget _buildRecommendBox() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF1F5F4),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Khuyến nghị cho gia đình: 40–63A",
          style: TextStyle(fontSize: 13),
        ),
        const Icon(Icons.keyboard_arrow_down_rounded)
      ],
    ),
  );
}
Widget _buildItemCard({
  required String title,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(14),
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

        const SizedBox(height: 10),

        child,
      ],
    ),
  );
}

class _ModernThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(28, 28);
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