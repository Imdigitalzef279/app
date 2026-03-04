import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';

import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';

import '../../../../application/enums/chart_range.dart';

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
  ChartRange _selectedRange = ChartRange.day;
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
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.electrical_services,
        size: 80,
        color: Colors.grey,
      ),
    );
  }
  Widget _buildOverviewSection(
      BuildContext context,
      AtomatLogResponse? log,
      DeviceResponse device,
      ) {
    if (log == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0,6),
          )
        ],
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== HEADER + RANGE =====
          Row(
            children: [

              GestureDetector(
                onTap: () {
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
                child: const Icon(
                  Icons.bolt,
                  color: Color(0xFF1ABC9C),
                ),
              ),

              const SizedBox(width: 6),

              const Text(
                "Grid Overview",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),

              const Spacer(),

              /// RANGE SELECTOR
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _rangeChipActive("1D"),
                    _rangeChip("7D"),
                    _rangeChip("30D"),
                    _rangeChip("1Y"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// ===== CHART =====
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200,
                  barTouchData: BarTouchData(enabled: false),

                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 50,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.25),
                        strokeWidth: 1,
                        dashArray: [6,4], // dashed giống design
                      );
                    },
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 50,
                        reservedSize: 42, // tăng chiều rộng trục Y
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toInt()} kW",
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              )
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const labels = [
                            "-10:24",
                            "-9:54",
                            "-9:34",
                            "-9:24",
                          ];
                          return Text(
                            labels[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),

                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),

                  borderData: FlBorderData(show: false),

                  barGroups: [
                    _bar(0, 150, 120),
                    _bar(1, 180, 140),
                    _bar(2, 160, 130),
                    _bar(3, 190, 150),
                  ],
                ),
              )
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _metricCard(
                  "Điện áp",
                  "${log.ua?.toStringAsFixed(0) ?? '--'}",
                  "V",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricCard(
                  "Dòng điện",
                  "${log.ia?.toStringAsFixed(0) ?? '--'}",
                  "A",
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _metricCard(
                  "Công suất",
                  "${log.p?.toStringAsFixed(1) ?? '--'}",
                  "kW",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricCard(
                  "Điện năng",
                  "${log.epi?.toStringAsFixed(0) ?? '--'}",
                  "kWh",
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0,4),
                )
              ],
            ),
            child: Row(
              children: [

                /// ICON
                const Icon(
                  Icons.savings,
                  color: Color(0xFFFFB300),
                  size: 28,
                ),

                const SizedBox(width: 10),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Thành tiền hôm nay",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "182.0 kWh • 198đ/kWh",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                /// PRICE
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "36,000 đ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "+2,000",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _tabItem("Tổng quan", true),
                _tabItem("Thông số", false),
                _tabItem("Lịch sử", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rangeChipActive(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F6F3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1ABC9C),
        ),
      ),
    );
  }
  BarChartGroupData _bar(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [

        /// CỘT 1
        BarChartRodData(
          toY: y1,
          width: 10,
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB9E3DC),
              Color(0xFF4FA89E),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),

        /// CỘT 2
        BarChartRodData(
          toY: y2,
          width: 10,
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8ED1C8),
              Color(0xFF1ABC9C),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
  Widget _tabItem(String text, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? const Color(0xFF1ABC9C) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: active ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
  Widget _rangeChip(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  Widget _buildTopDeviceCard(DeviceResponse device, AtomatLogResponse? log) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [

          /// ICON DEVICE
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _deviceImage(),
          ),

          const SizedBox(width: 6),

          /// NAME + CODE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  device.name.isNotEmpty
                      ? device.name
                      : device.code ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  device.code ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// HISTORY
          _circleIconPremium(
            icon: Icons.history,
            bgColor: const Color(0xFF1ABC9C),
          ),

          const SizedBox(width: 10),

          /// SETTINGS
          _circleIconPremium(
            icon: Icons.settings,
            bgColor: const Color(0xFFB8B8C7),
          ),
        ],
      ),
    );
  }
  Widget _miniMetric(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
  Widget _buildBigStatusCard(DeviceResponse device) {
    final bool isMaintenance = device.rlyRepSta == 1;
    final bool isOn = device.status == 1;

    String statusText;
    IconData icon;
    List<Color> gradientColors;

    if (isMaintenance) {
      statusText = "ĐANG BẢO TRÌ";
      icon = Icons.build_circle;
      gradientColors = [
        const Color(0xFFFFB74D),
        const Color(0xFFFF9800),
      ];
    } else if (isOn) {
      statusText = "ĐANG ĐÓNG";
      icon = Icons.power;
      gradientColors = [
        const Color(0xFF9EDAD2),
        const Color(0xFF4FA89E),
      ];
    } else {
      statusText = "ĐANG NGẮT";
      icon = Icons.power_off;
      gradientColors = [
        const Color(0xFFE57373),
        const Color(0xFFD32F2F),
      ];
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientColors.first,
            gradientColors.last,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Stack(
        children: [


          /// noise texture
          Positioned.fill(
            child: Opacity(
              opacity: 0.06,
              child: Image.asset(
                "assets/images/noise.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TRẠNG THÁI",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _circleIconPremium({
    required IconData icon,
    required Color bgColor,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, deviceState) {

        final device = deviceState.resultDevices.data?.firstWhere(
              (d) => d.id == widget.device.id,
          orElse: () => widget.device,
        );

        if (device == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final log = context.watch<AtomatDetailCubit>().state.logData;
        final isMaintenance = device.rlyRepSta == 1;
        final isSwitching = context.watch<DeviceCubit>().state.isForceLoading;

        return Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),

          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// DEVICE NAME
                Text(
                  device.name.isNotEmpty
                      ? device.name
                      : device.code ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 2),

                /// CODE + STATUS
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      device.code ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2ECC71),
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 4),

                    const Text(
                      "Online",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF2ECC71),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

                children: [

                  /// TOP DEVICE CARD
                  _buildTopDeviceCard(device, log),

                  const SizedBox(height: 16),

                  /// STATUS CARD
                  _buildBigStatusCard(device),

                  const SizedBox(height: 16),

                  /// HEADER ACTION BUTTONS
                  Row(
                    children: [

                      /// ON / OFF
                      Expanded(
                        child: _actionButton(
                          text: "Đóng/Cắt",
                          icon: Icons.flash_on,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF4FA89E),
                              Color(0xFF6CC3B8),
                            ],
                          ),
                          onTap: (isSwitching || isMaintenance)
                              ? null
                              : () async {

                            final password =
                            await _showPasswordDialog(context);

                            if (password == null) return;

                            await context.read<DeviceCubit>().togglePower(
                              device,
                              password: password,
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// MAINTENANCE
                      Expanded(
                        child: _actionButton(
                          text: "Bảo trì",
                          icon: Icons.build,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF9A3E),
                              Color(0xFFFFB56B),
                            ],
                          ),
                          onTap: isSwitching
                              ? null
                              : () async {

                            final password =
                            await _showPasswordDialog(context);

                            if (password == null) return;

                            await context
                                .read<DeviceCubit>()
                                .toggleMaintenance(
                              device,
                              password: password,
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// FORCE
                      Expanded(
                        child: _actionButton(
                          text: "Force",
                          icon: Icons.power_settings_new,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF6B6B),
                              Color(0xFFFF8E8E),
                            ],
                          ),
                          onTap: isSwitching
                              ? null
                              : () async {

                            final password =
                            await _showPasswordDialog(context);

                            if (password == null) return;

                            await context.read<DeviceCubit>().forcePower(
                              device,
                              password: password,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// GRID OVERVIEW
                  _buildOverviewSection(context, log, device),
                  const SizedBox(height: 10),
                  _goHomeButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= GRID SECTION =================
  Widget _goHomeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF4FA89E),
              Color(0xFF6CC3B8),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Quay về Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _actionButton({
    required String text,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36, // ↓ nhỏ lại
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          gradient: onTap == null
              ? LinearGradient(
            colors: [
              Colors.grey.shade400,
              Colors.grey.shade400,
            ],
          )
              : gradient,
          borderRadius: BorderRadius.circular(22), // bo tròn hơn
          boxShadow: [
            if (onTap != null)
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16, // ↓ icon nhỏ
            ),
            const SizedBox(width: 4), // ↓ khoảng cách nhỏ
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12, // ↓ chữ nhỏ
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _metricCard(String label, String value, String unit) {
    return Container(
      height: 64, // ↓ giảm chiều dài ô
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0,3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // ↓ padding nhỏ
        child: Row(
          children: [

            Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFE7F6F3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt,
                size: 14, // ↓ icon nhỏ
                color: Color(0xFF1ABC9C),
              ),
            ),

            const SizedBox(width: 8),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11, // ↓ nhỏ hơn
                    color: Colors.grey,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16, // ↓ nhỏ hơn
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
