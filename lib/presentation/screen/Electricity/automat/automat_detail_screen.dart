import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/atomat/atomat_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';

import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';

import '../../../../application/meter_realtime/meter_realtime_cubit.dart';

import '../../../../data/dto/atomat/atomat_log_response.dart';

import '../../../../data/services/signalr_service.dart';

import '../../device/bloc/device_cubit.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';
import 'automat_chart_screen.dart';

class AutomatDetailScreen extends StatefulWidget {
  final DeviceResponse device;

  const AutomatDetailScreen({
    super.key,
    required this.device,
  });

  @override
  State<AutomatDetailScreen> createState() => _AutomatDetailScreenState();
}

class _AutomatDetailScreenState extends State<AutomatDetailScreen> {
  bool isForceMode = false;
  late DeviceResponse currentDevice;
  late AtomatDetailCubit cubit;
  final formatted = DateFormat("yyyy-MM-dd'T'00:00:00");
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    currentDevice = widget.device;
    cubit = context.read<AtomatDetailCubit>();
    cubit.getBreakerLog(currentDevice.code ?? "");

    // ===== SignalR giữ nguyên nếu cần realtime =====
    final signalR = SignalRService();

    signalR.connect(
      meterCode: currentDevice.code ?? "",
    );

    signalR.stream.listen(_handleRealtime);

    // ⏱ AUTO REFRESH 5 PHÚT
    _timer = Timer.periodic(
      const Duration(minutes: 5),
          (_) => cubit.getBreakerLog(currentDevice.code ?? ""),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  void _handleRealtime(Map<String, dynamic> data) {
    try {
      final event = data["event"];
      if (event == "ReceiveCommand") {
        if (data["status"] == 1) {
          context.read<DeviceCubit>().setSwitching(false);
        }
        return;
      }
      if (event != "ReceiveChart" && event != "ReceiveLog") {

        return;
      }
      final dto = data["breakerMeterDataDto"];
      if (dto == null) {
        return;
      }
      final raw = Map<String, dynamic>.from(dto);
      // =========================================================
      // 3️⃣ DEBUG REALTIME STATE
      // =========================================================

      // Convert String number -> num
      raw.updateAll((key, value) {
        if (value is String) {
          final numValue = num.tryParse(value);
          return numValue ?? value;
        }
        return value;
      });

      raw["updatedAt"] = data["updatedAt"];

      final log = AtomatLogResponse.fromJson(raw);



      // =========================================================
      // 4️⃣ UPDATE DEVICE
      // =========================================================
      context.read<DeviceCubit>().updateRealtimeLogByCode(
        currentDevice.code,
        log,
      );

    } catch (e) {
      print("❌ Parse realtime error: $e");
    }
  }
  void _showForceOffOptions(
      BuildContext context,
      DeviceResponse device,
      ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                title: const Text("Nhập mật khẩu"),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: mở dialog password
                },
              ),

              ListTile(
                title: const Text("Xác nhận Email"),
                onTap: () async {
                  Navigator.pop(context);

                  await context
                      .read<DeviceCubit>();
                },
              ),

              ListTile(
                title: const Text("Không cần xác thực"),
                onTap: () async {
                  Navigator.pop(context);

                  await context
                      .read<DeviceCubit>();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _reloadDevice() async {
    await context.read<DeviceCubit>().getAllDevices(
      powerStationId: currentDevice.powerStationId,
    );
  }
  void _reloadRealTime() {
    cubit.getBreakerLog(currentDevice.code ?? "");
  }
  Future<String?> _showPasswordDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _PinDialog();
      },
    );
  }
  String _getStatusText(int status) {
    switch (status) {
      case 1:
        return "Đang bật";
      case 0:
        return "Đang tắt";
      case 2:
        return "Đang bảo trì";
      default:
        return "Không xác định";
    }
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 0:
        return Colors.red;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
  Widget _deviceImage() {
    String path;

    switch (currentDevice.meterTypeId) {

      case 81:
        path = "assets/images/mm50h_1p.png";
        break;

      case 82:
        path = "assets/images/mm50h_3p.png";
        break;

      case 61:
        path = "assets/images/mccb_3p.png";
        break;

      default:
        path = "assets/images/mm50h_1p.png";
    }

    return Image.asset(
      path,
      height: 130,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.electrical_services,
        size: 80,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, deviceState) {

        final device = deviceState.resultDevices.data
            ?.firstWhere(
              (d) => d.id == widget.device.id,
          orElse: () => widget.device,
        );

        if (device == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        print("UI STATUS: ${device?.status}");
        print("UI RLYREP: ${device?.rlyRepSta}");
        print("===== BUILD DEBUG =====");
        print("BUILD STATUS: ${device.status}");
        final int status = device.status ?? 0;
        final isTurningOn = status == 1;
        final log = context.watch<AtomatDetailCubit>().state.logData;
        final isOn = device.status == 1;
        final isMaintenance = device.rlyRepSta == 1;
        final isSwitching = context.watch<DeviceCubit>().state.isForceLoading;
        return Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Chi tiết thiết bị"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [

              const SizedBox(height: 16),

              /// ================= HEADER BUTTONS =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                /// ===== ON / OFF (THƯỜNG) =====
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: isSwitching
                          ? Colors.grey
                          : isOn
                          ? Colors.red
                          : const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (isSwitching || isMaintenance)
                        ? null
                        : () async {
                      final password = await _showPasswordDialog(context);
                      if (password == null) return;

                      await context.read<DeviceCubit>().togglePower(
                        device,
                        password: password,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isOn ? Icons.power_off : Icons.flash_on,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isOn ? "OFF" : "ON",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: isSwitching
                          ? Colors.grey
                          : device.status == 1
                          ? const Color(0xFFC62828) // đang ON → force OFF
                          : const Color(0xFF2E7D32), // đang OFF → force ON
                      foregroundColor: Colors.white,
                    ),
                    onPressed: isSwitching
                        ? null
                        : () async {
                      final password = await _showPasswordDialog(context);
                      if (password == null) return;

                      await context.read<DeviceCubit>().forcePower(
                        device, //
                        password: password,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flash_on, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Force",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ===== MAINTENANCE =====
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor:
                //     isMaintenance ? Colors.white : const Color(0xFFF57C00),
                //     foregroundColor:
                //     isMaintenance ? Colors.red : Colors.white,
                //     side: isMaintenance
                //         ? const BorderSide(color: Colors.red)
                //         : BorderSide.none,
                //   ),
                //   onPressed: isSwitching
                //       ? null
                //       : () async {
                //     final password = await _showPasswordDialog(context);
                //     if (password == null) return;
                //
                //     await context.read<DeviceCubit>().toggleMaintenance(
                //       device,
                //       password: password,
                //     );
                //   },
                //   child: Text(
                //     isMaintenance ? "Thoát bảo trì" : "Bảo trì",
                //     style: const TextStyle(fontWeight: FontWeight.w600),
                //   ),
                // ),
              ],
              ),

              const SizedBox(height: 20),

              /// ===== CHART BUTTON =====
              ElevatedButton.icon(
                onPressed: log == null
                    ? null
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => AutomatChartCubit(),
                        child: AutomatChartScreen(
                          meterCode: device.code ?? "",
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.show_chart),
                label: const Text("Xem biểu đồ"),
              ),

              /// ================= DEVICE CARD =================
              Card(
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [

                      _deviceImage(),
                      const SizedBox(height: 16),

                      /// DEVICE NAME
                      MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: Text(
                          device.name.isNotEmpty
                              ? device.name
                              : device.code ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            height: 1.2,
                            color: Color(0xFF1C1C1E),
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// DEVICE CODE
                      Text(
                        device.code ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8E8E93),
                          letterSpacing: 0.3,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// INFO SECTION
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          _infoRow("Tên thiết bị", device.name),
                          _infoRow("Sơ đồ mạch điện", device.code ?? ""),

                          _infoRow(
                            "Trạng thái",
                            "",
                            valueWidget: _buildStatusWidget(
                              status: device.status,
                              rlyRepSta: device.rlyRepSta,
                            ),
                          ),

                          _infoRow(
                            "Alarm",
                            log?.alrRcrCnt?.toString() ?? "--",
                          ),

                          _infoRow(
                            "Updated",
                            log?.updatedAt?.toString() ?? "-",
                          ),

                          const SizedBox(height: 10),

                          if (log != null) ...[
                            _infoRow("Điện áp định mức",
                                log.ua?.toString() ?? "--"),
                            _infoRow("Dòng điện định mức",
                                log.ia?.toString() ?? "--"),
                          ] else ...[
                            const Text(
                              "Không có dữ liệu realtime",
                              style:
                              TextStyle(color: Colors.grey),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 12),

                      _buildRealtimeMini(log),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },

    );

  }

  // ================= GRID SECTION =================
  Widget _buildRealtimeMini(AtomatLogResponse? log) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          _miniRow([
            _miniMetric("Ua", log?.ua, "V"),
            _miniMetric("Ub", log?.ub, "V"),
            _miniMetric("Uc", log?.uc, "V"),
          ]),

          const SizedBox(height: 8),

          _miniRow([
            _miniMetric("Ia", log?.ia, "A"),
            _miniMetric("Ib", log?.ib, "A"),
            _miniMetric("Ic", log?.ic, "A"),
          ]),

          const SizedBox(height: 8),

          _miniRow([
            _miniMetric("P", log?.p, "W"),
            _miniMetric("kWh", log?.epi, ""),
            _miniMetric("PF", log?.pf, ""),
          ]),
        ],
      ),
    );
  }
  Widget _miniRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _miniMetric(String label, dynamic value, String unit) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value != null ? "$value $unit" : "--",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPhaseSection(String title,
      List<_MetricItem> items,) {
    if (items.isEmpty) return const SizedBox();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _metricCard(
              item.label,
              item.value ?? "-",
              item.unit,
            );
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }


  Widget _metricCard(String label, String value, String unit) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9E9E9E),
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                  height: 1.1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (unit.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
Widget _infoRow(
    String title,
    String value, {
      Widget? valueWidget,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: valueWidget ??
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStatusWidget({

  required int status,
  required int rlyRepSta,
}) {

  final bool isMaintenance = rlyRepSta == 1;
  final bool isOn = status == 1;

  String text;
  Color color;

  if (isMaintenance) {
    text = "Đang bảo trì";
    color = const Color(0xFFF57C00); // Cam giống nút bảo trì
  } else if (isOn) {
    text = "ON";
    color = const Color(0xFF2E7D32); // Xanh giống nút ON
  } else {
    text = "OFF";
    color = const Color(0xFFC62828); // Đỏ giống nút OFF
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

  class _MetricItem {
  final String label;
  final String? value;
  final String unit;

  _MetricItem(this.label, this.value, this.unit);
}

class _PinDialog extends StatefulWidget {
  @override
  State<_PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<_PinDialog> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNodes[0].requestFocus();
  }

  void _checkPin() {
    String pin = _controllers.map((c) => c.text).join();

    if (pin.length == 4) {
      Navigator.pop(context, pin);
    }
  }

  Widget _buildPinBox(int index) {
    return SizedBox(
      width: 55,
      height: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        obscureText: true,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
            }
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }

          _checkPin();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: const Center(
        child: Text(
          "Nhập mã PIN",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => _buildPinBox(index)),
          ),

          const SizedBox(height: 12),

          const Text(
            "PIN mặc định: 9999",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
