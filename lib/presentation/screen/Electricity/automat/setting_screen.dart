import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:solar_energy/data/dto/meter_config/request/meter_config_request.dart';
import 'package:solar_energy/data/repositories/meter_config/meter_config_repository.dart';

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
          configValue: customThreshold ? 1 : 0,
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
        title: Text(widget.device.name ?? widget.device.code ?? "Cài đặt"),
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
            onChanged: (v) => setState(() => overVoltage = v),
          ),

          const SizedBox(height: 25),

          _buildSliderTile(
            title: "Thấp áp",
            unit: "V",
            value: underVoltage,
            min: 180,
            max: 240,
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

  Widget _buildSliderTile({
    required String title,
    required String unit,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              "${value.toInt()} $unit",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: kPrimaryColor,
            thumbColor: kPrimaryColor,
            inactiveTrackColor: kPrimaryColor.withOpacity(.2),
            overlayColor: kPrimaryColor.withOpacity(.1),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            onChanged: onChanged,
          ),
        ),

        Text(
          "Min: ${min.toInt()} | Max: ${max.toInt()}",
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