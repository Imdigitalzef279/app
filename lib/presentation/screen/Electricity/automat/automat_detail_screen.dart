import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/atomat/atomat_request.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/switch_log/switch_log_screen.dart';
import '../../../../application/meter_realtime/meter_realtime_cubit.dart';
import '../../../../application/switch_log/switch_log_cubit.dart';
import '../../../../data/dto/atomat/atomat_log_response.dart';
import '../../../../data/repositories/switch_log/switch_log_repository.dart';
import '../../../../data/services/signalr_service.dart';
import '../../../../di.dart';
import '../../device/bloc/device_cubit.dart';
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
    print("code: ${currentDevice.code}");
    print("serial: ${currentDevice.serialNumber}");
    print("gateway: ${currentDevice.gatewayNumber}");
    // ===== LOAD LOG NGÀY HÔM NAY (GIỮ NGUYÊN) =====
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final to = DateTime(now.year, now.month, now.day, 23, 59, 59);

    cubit.getLogAtomat(
      AtomatRequest(
        breakerSn: currentDevice.code,
        fromDate: from.toIso8601String(),
        toDate: to.toIso8601String(),
      ),
    );

    // ===== 🔥 CONNECT REALTIME =====
    SignalRService().connect(
      meterCode: currentDevice.gatewayNumber,
      onData: (data) {
        _handleRealtime(data);
      },
    );
  }
  void _handleRealtime(Map<String, dynamic> data) {
    print("📡 Detail realtime: $data");

    try {
      // 🔥 chỉ xử lý khi có dữ liệu điện
      if (!data.containsKey("breakerMeterDataDto")) {
        return;
      }

      final meterData =
      Map<String, dynamic>.from(data["breakerMeterDataDto"]);

      final log = AtomatLogResponse.fromJson(meterData);

      context.read<DeviceCubit>().updateRealtimeLog(
        currentDevice.id,
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
    final now = DateTime.now();
    final from = now.subtract(const Duration(minutes: 30));

    cubit.getLogAtomat(
      AtomatRequest(
        breakerSn: currentDevice.code,
        fromDate: from.toIso8601String(),
        toDate: now.toIso8601String(),
      ),
    );
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
    return BlocListener<DeviceCubit, DeviceState>(
      listener: (context, state) {
        if (state.resultDevices.status == LoadStatus.success) {
          final list = state.resultDevices.data;

          if (list != null) {
            final updated =
            list.where((d) => d.id == currentDevice.id).toList();

            if (updated.isNotEmpty) {
              setState(() {
                currentDevice = updated.first;
              });
            }
          }
        }
      },
      child: BlocBuilder<AtomatDetailCubit, AtomatDetailState>(
        builder: (context, atomatState) {

          final deviceState = context.watch<DeviceCubit>().state;

          final updatedDevice = deviceState.resultDevices.data
              ?.firstWhere((d) => d.id == currentDevice.id,
              orElse: () => currentDevice);

          final relayStatus = updatedDevice?.status ?? 0;

          final isMaintenance = relayStatus == 2;
          final isOn = relayStatus == 1;
          final isOff = relayStatus == 0;
          final isForceLoading = deviceState.isForceLoading;

          if (atomatState.load == LoadStatus.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final realtimeDevice = deviceState.resultDevices.data
              ?.firstWhere(
                (d) => d.id == currentDevice.id,
            orElse: () => currentDevice,
          );

          final log = realtimeDevice?.realtimeLog;


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
                // ================= HEADER =================
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    /// ===== TOGGLE POWER =====
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOn
                            ? Colors.green
                            : Colors.red,
                      ),
                      onPressed: (isMaintenance || isForceLoading)
                          ? null
                          : () async {
                        final password = await _showPasswordDialog(context);
                        if (password == null) return;

                        await context.read<DeviceCubit>().togglePower(
                          currentDevice,
                          password: password,
                        );
                      },
                      child: Text(
                        isOn ? "Đóng" : "Cắt",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    /// ===== TOGGLE MAINTENANCE =====
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMaintenance
                            ? Colors.white
                            : const Color(0xFFFFF3E0), // cam rất nhạt
                        foregroundColor: isMaintenance
                            ? Colors.red
                            : const Color(0xFFFB8C00), // cam đậm hơn chữ
                        side: isMaintenance
                            ? const BorderSide(color: Colors.red)
                            : BorderSide.none,
                        elevation: 0,
                      ),
                      onPressed: isForceLoading
                          ? null
                          : () async {
                        final password = await _showPasswordDialog(context);
                        if (password == null) return;

                        // 🔥 Nếu đang bảo trì -> delay 10 giây trước khi thoát
                        if (isMaintenance) {
                          await Future.delayed(const Duration(seconds: 13));
                        }

                        await context.read<DeviceCubit>().toggleMaintenance(
                          currentDevice,
                          password: password,
                        );
                      },
                      child: Text(
                        isMaintenance ? "Thoát bảo trì" : "Bảo trì",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),


                ElevatedButton.icon(
                  onPressed: log == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => MeterRealtimeCubit(SignalRService()),
                          child: AutomatChartScreen(
                            meterCode: atomatState.logData?.breakerSn ?? "",
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.show_chart),
                  label: const Text("Xem biểu đồ"),
                ),

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

// ===== DEVICE NAME =====
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                          child: Text(
                            currentDevice.name.isNotEmpty
                                ? currentDevice.name
                                : currentDevice.code,
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

// ===== DEVICE CODE SUBTITLE =====
                        Text(
                          currentDevice.code ?? '',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// ===== LUÔN HIỂN THỊ =====
                            _infoRow("Tên thiết bị", currentDevice.name),
                            _infoRow("Sơ đồ mạch điện", currentDevice.code ?? ''),

                            _infoRow(
                              "Trạng thái",
                              "",
                              valueWidget: _buildStatusWidget(relayStatus),
                            ),

                            _infoRow(
                              "Alarm",
                              log?.alrRcrCnt?.toString() ?? "--",
                            ),

                            _infoRow(
                              "Updated",
                              log?.updatedAt ?? "--",
                            ),

                            const SizedBox(height: 10),

                            /// ===== CHỈ PHẦN REALTIME MỚI PHỤ THUỘC LOG =====
                            if (log != null) ...[
                              _infoRow("Điện áp định mức", log.ua.toString()),
                              _infoRow("Dòng điện định mức", log.ia.toString()),
                              _infoRow("Alarm", log.alrRcrCnt.toString()),
                              _infoRow("Updated", log.updatedAt),
                            ] else ...[
                              const Text(
                                "Không có dữ liệu realtime",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 12),
                        const SizedBox(height: 10),
                        _buildRealtimeMini(log),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                // l,ic

              ],
            ),
          );
        },
      ),
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
Widget _buildStatusWidget(int status) {
  String text;
  Color bgColor;
  Color textColor;

  switch (status) {

  /// 1 = ĐÓNG (ON)
    case 1:
      text = "Đóng";
      bgColor = Colors.green.withOpacity(0.15);
      textColor = Colors.green;
      break;

  /// 0 = CẮT (OFF)
    case 0:
      text = "Cắt";
      bgColor = Colors.red.withOpacity(0.15);
      textColor = Colors.red;
      break;

  /// 2 = BẢO TRÌ
    case 2:
      text = "Chế độ bảo trì";
      bgColor = Colors.red.withOpacity(0.1);
      textColor = Colors.red;
      break;

    case 3:
      text = "Ngoại tuyến";
      bgColor = Colors.grey.withOpacity(0.15);
      textColor = Colors.grey;
      break;

    default:
      text = "Không xác định";
      bgColor = Colors.grey.withOpacity(0.15);
      textColor = Colors.grey;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: textColor,
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
