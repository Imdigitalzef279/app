import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/meter_config/request/meter_config_request.dart';
import 'package:solar_energy/data/repositories/meter_config/meter_config_repository.dart';

import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/cbs/request/cbs_meter_request.dart';
import 'device_info_screen/device_info_screen.dart';

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

  double getDeviceMax(String unit) {
    final name = widget.device.name ?? "";

    if (unit == "A") {
      final match = RegExp(r'(\d+)A').firstMatch(name);
      if (match != null) {
        return double.parse(match.group(1)!);
      }
    }

    if (unit == "kW") return 20;
    if (unit == "V") return 280;
    if (unit == "mA") return 300;
    if (unit == "°C") return 120;

    return 100;
  }
  double getDeviceMin(String unit) {
    final name = widget.device.name ?? "";

    // ===== DÒNG ĐIỆN =====
    if (unit == "A") {
      final match = RegExp(r'(\d+)A').firstMatch(name);
      if (match != null) {
        final max = double.parse(match.group(1)!);

        // min = ~20% max
        return (max * 0.2).clamp(5, max);
      }
    }

    // ===== ĐIỆN ÁP =====
    if (unit == "V") {
      return 180; // hoặc đọc từ device nếu có
    }

    // ===== DÒNG RÒ =====
    if (unit == "mA") return 10;

    // ===== CÔNG SUẤT =====
    if (unit == "kW") return 1;

    // ===== NHIỆT ĐỘ =====
    if (unit == "°C") return 40;

    return 0;
  }
  double getVoltageBase() {
    final name = widget.device.name ?? "";

    // nếu device có ghi 220V / 380V
    final match = RegExp(r'(\d+)V').firstMatch(name);
    if (match != null) {
      return double.parse(match.group(1)!);
    }

    return 220; // mặc định VN
  }
  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  // ================= LOAD CONFIG =================

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

          case 'export_report':
            exportReport = e.configValue == 'true';
            break;
          case 'over_temperature':
            overTemperature = double.parse(e.configValue);
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
          configValue: overCurrent.toInt(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "leakage_current",
          configValue: leakageCurrent.toInt(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_voltage",
          configValue: overVoltage.toInt(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "under_voltage",
          configValue: underVoltage.toInt(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_power",
          configValue: overPower.toInt(),
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "phase_loss",
          configValue: phaseLoss ? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "custom_threshold",
          configValue: customThreshold? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "notify_app",
          configValue: notifyApp ? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "notify_email",
          configValue: notifyEmail ? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "save_log",
          configValue: saveLog ? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "export_report",
          configValue: exportReport ? 1 : 0,
        ),
        MeterConfigRequest(
          meterId: widget.device.id,
          configKey: "over_temperature",
          configValue: overTemperature.toInt(),
        ),
      ];

      // Gửi tuần tự
      for (final config in configs) {
        await _repo.saveConfig(config);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Lưu thành công")),
        );
      }
    } catch (e) {
      debugPrint("Save error: $e");
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

            /// DEVICE CARD
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Gateway: ${widget.device.gatewayNumber ?? ''}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  )
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
        /// 🔹 QUÁ DÒNG
        _buildItemCard(
          title: "Quá dòng",
          child: Column(
            children: [
              _buildSliderTile(
                title: "Quá dòng",
                unit: "A",
                value: overCurrent,
                min: getDeviceMin("A"),
                max: getDeviceMax("A"),
                isOverCurrent: true,
                description: "Ngưỡng cắt khi dòng vượt mức cho phép",
                onChanged: (v) => setState(() => overCurrent = v),
              ),
              _buildRecommendBox(),
            ],
          ),
        ),

        /// 🔹 DÒNG RÒ
        _buildItemCard(
          title: "Dòng rò",
          child: _buildSliderTile(
            title: "Dòng rò",
            unit: "mA",
            value: leakageCurrent,
            min: getDeviceMin("mA"),
            max: getDeviceMax("mA"),
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
            const SizedBox(height: 12),

        /// 🔹 QUÁ ÁP
            _buildSliderTile(
              title: "Quá áp",
              unit: "V",
              value: overVoltage,
              min: getVoltageBase(),
              max: getVoltageBase() * 1.3,
              isVoltage: true,
              description: "Ngắt khi điện áp vượt ngưỡng an toàn",
              onChanged: (v) => setState(() => overVoltage = v),
            ),

        /// 🔹 THẤP ÁP
            _buildSliderTile(
              title: "Thấp áp",
              unit: "V",
              value: underVoltage,
              min: getVoltageBase() * 0.8,
              max: getVoltageBase(),
              isVoltage: true,
              description: "Ngắt khi điện áp thấp hơn mức cho phép",
              onChanged: (v) => setState(() => underVoltage = v),
            ),

        /// 🔹 QUÁ CÔNG SUẤT
        _buildItemCard(
          title: "Quá công suất",
          child: _buildSliderTile(
            title: "Quá công suất",
            unit: "kW",
            value: overPower,
            min: getDeviceMin("kW"),
            max: getDeviceMax("kW"),
            description: "Ngắt khi điện áp vượt ngưỡng an toàn",
            onChanged: (v) => setState(() => overPower = v),
          ),
        ),

        /// 🔹 QUÁ NHIỆT
        _buildItemCard(
          title: "Quá nhiệt",
          child: _buildSliderTile(
            title: "Quá nhiệt",
            unit: "°C",
            value: overTemperature,
            min: getDeviceMin("°C"),
            max: getDeviceMax("°C"),
            description: "Ngắt khi điện áp vượt ngưỡng an toàn",
            onChanged: (v) => setState(() => overTemperature = v),
          ),
        ),

        const SizedBox(height: 10),

        /// 🔹 SWITCH SETTINGS
        _buildItemCard(
          title: "Cài đặt bổ sung",
          child: Column(
            children: [
              _buildModernSwitch("Mất pha", phaseLoss,
                      (v) => setState(() => phaseLoss = v)),
              _buildModernSwitch("Set ngưỡng riêng", customThreshold,
                      (v) => setState(() => customThreshold = v)),
              _buildModernSwitch("Cảnh báo qua App", notifyApp,
                      (v) => setState(() => notifyApp = v)),
              _buildModernSwitch("Cảnh báo Email", notifyEmail,
                      (v) => setState(() => notifyEmail = v)),
              _buildModernSwitch("Lưu log cảnh báo", saveLog,
                      (v) => setState(() => saveLog = v)),
              _buildModernSwitch("Xuất báo cáo", exportReport,
                      (v) => setState(() => exportReport = v)),
            ],
          ),
        ),
      ],
        )
    );
  }
  Future<void> sendProtectionSetting() async {

    final api = GetIt.instance<ApiClient>();

    final command = {
      "method": "operate",
      "payload": {
        "addr": "1_1",
        "IHighVal01": overCurrent.toInt().toString(),
        "LgHighVal01": leakageCurrent.toInt().toString(),
        "UHighVal01": overVoltage.toInt().toString(),
        "ULowVal01": underVoltage.toInt().toString(),
        "PHighVal01": overPower.toString(),
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

    await api.controlCircuitBreaker(request);
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
    final percent = (value - min) / (max - min);

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
                onTap: () => _showInputDialog(
                  context,
                  value,
                  unit,
                  min,
                  max,
                  onChanged,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  /// active
                  FractionallySizedBox(
                    widthFactor: (value - min) / (max - min),
                    child: Container(
                      height: 6,
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
                      value: value,
                      min: min,
                      max: max,
                      onChanged: onChanged,
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
  void _showInputDialog(
      BuildContext context,
      double current,
      String unit,
      double min,
      double max,
      Function(double) onChanged,
      ) {
    final controller =
    TextEditingController(text: current.toInt().toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
  Widget _buildModernSwitch(
      String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
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
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
      ],
    ),
  );
}
class _ShadowThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const _ShadowThumbShape({this.thumbRadius = 12});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;

    /// Shadow
    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: thumbRadius)),
      Colors.black.withOpacity(.3),
      6,
      true,
    );

    /// White thumb
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(center, thumbRadius, paint);
  }
}
Color _getValueColor(double value, double min, double max, bool isVoltage) {
  if (!isVoltage) return kPrimaryColor;

  final percent = (value - min) / (max - min);

  if (percent < 0.4) {
    return const Color(0xFF1ABC9C); // an toàn
  } else if (percent < 0.75) {
    return const Color(0xFFFFB74D); // cảnh báo
  } else {
    return const Color(0xFFE57373); // nguy hiểm
  }
}
class _RoundedTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
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

    /// shadow

    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: 12)),
      Colors.black.withOpacity(.15),
      4,
      true,
    );

    /// vòng trắng
    canvas.drawCircle(center, 18, Paint()..color = Colors.white);

    /// viền xanh nhạt
    ///
    canvas.drawCircle(
      center,
      12,
      Paint()
        ..color = kPrimaryColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    /// chấm xanh
    canvas.drawCircle(center, 4, Paint()..color = kPrimaryColor);
  }
}