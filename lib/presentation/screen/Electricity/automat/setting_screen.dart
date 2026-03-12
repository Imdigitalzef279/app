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
      backgroundColor: kBackgroundColor,
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
                  foregroundColor: Colors.white, // 👈 QUAN TRỌNG
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("Bảo vệ dòng điện",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),

          const SizedBox(height: 16),

          _buildSliderTile(
            title: "Quá dòng",
            unit: "A",
            value: overCurrent,
            min: 10,
            max: 100,
            onChanged: (v) => setState(() => overCurrent = v),
          ),

          const SizedBox(height: 25),

          _buildSliderTile(
            title: "Dòng rò",
            unit: "mA",
            value: leakageCurrent,
            min: 10,
            max: 300,
            onChanged: (v) => setState(() => leakageCurrent = v),
          ),

          const SizedBox(height: 25),

          const Text("Bảo vệ điện áp",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),

          const SizedBox(height: 16),

          _buildSliderTile(
            title: "Quá áp",
            unit: "V",
            value: overVoltage,
            min: 200,
            max: 280,
            isVoltage: true, // 👈 thêm dòng này
            onChanged: (v) => setState(() => overVoltage = v),
          ),

          const SizedBox(height: 25),

          _buildSliderTile(
            title: "Thấp áp",
            unit: "V",
            value: underVoltage,
            min: 180,
            max: 240,
            isVoltage: true, // 👈 thêm dòng này
            onChanged: (v) => setState(() => underVoltage = v),
          ),

          const SizedBox(height: 25),

          _buildSliderTile(
            title: "Quá công suất",
            unit: "kW",
            value: overPower,
            min: 1,
            max: 20,
            onChanged: (v) => setState(() => overPower = v),
          ),
          const SizedBox(height: 25),

          _buildSliderTile(
            title: "Quá nhiệt",
            unit: "°C",
            value: overTemperature,
            min: 40,
            max: 120,
            onChanged: (v) => setState(() => overTemperature = v),
          ),
          const SizedBox(height: 30),

          const Divider(),

          const SizedBox(height: 20),

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

          _buildModernSwitch("Xuất báo cáo lịch sử cảnh báo", exportReport,
                  (v) => setState(() => exportReport = v)),
        ],
      ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: valueColor.withOpacity(.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${value.toInt()} $unit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            )
          ],
        ),

        const SizedBox(height: 12),

        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final activeWidth = width * percent;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [

                /// BACKGROUND TRACK (xám)
                Container(
                  height: 6,
                  width: width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                /// GRADIENT ACTIVE TRACK (chỉ điện áp)
                if (isVoltage)
                  Container(
                    height: 6,
                    width: activeWidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1ABC9C),
                          Color(0xFFFFB74D),
                          Color(0xFFE57373),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )
                else
                  Container(
                    height: 6,
                    width: activeWidth,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                /// SLIDER
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6,
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    thumbShape: const _ModernThumbShape(),
                    overlayColor: valueColor.withOpacity(.08),
                    overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 18),
                  ),
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: (max - min).toInt(),
                    onChanged: onChanged,
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 6),

        Text(
          "Min ${min.toInt()}        Max ${max.toInt()}",
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
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
  final double radius;
  const _ModernThumbShape({this.radius = 9});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
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

    canvas.drawShadow(
      Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
      Colors.black.withOpacity(.25),
      4,
      true,
    );

    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, paint);
  }
}
