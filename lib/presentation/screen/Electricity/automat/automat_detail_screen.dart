import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/setting_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/switch_log/switch_log_screen.dart';
import '../../../../application/enums/chart_range.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/atomat/atomat_log_response.dart';
import '../../../../data/services/signalr_service.dart';
import '../../device/bloc/device_cubit.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';
import 'automat_chart_screen.dart';
/// Màn hình chi tiết thiết bị CB (Circuit Breaker)
/// Hiển thị:
/// - Trạng thái ON/OFF
/// - Điện áp / dòng / công suất
/// - Chart tải điện
/// - Tiền điện hôm nay
enum ChartType {
  power,
  energy,
}
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
  ChartType chartType = ChartType.power;
  double todayEnergy = 0;
  double moneyToday = 0;
  double pricePerKwh = 0; // có thể lấy từ API sau
  double epiAtStartOfDay = 0;
  double realtimeCost = 0;
  int maintenanceCountdown = 0;
  Timer? maintenanceTimer;
  int switchCountdown = 0;
  int switchCooldown = 0;
  Timer? switchCooldownTimer;
  Timer? switchCountdownTimer;
  final formatted = DateFormat("yyyy-MM-dd'T'00:00:00");
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    currentDevice = widget.device;
    cubit = context.read<AtomatDetailCubit>();

    _loadStartOfDayEnergy();
    _loadElectricPrice();

    /// load breaker log cho màn hình
    cubit.getBreakerLog(currentDevice.code ?? "");

    /// load breaker log cho DeviceCubit (để đóng cắt)
    context.read<DeviceCubit>().loadBreakerLog(currentDevice.code);

    /// chart
    context.read<AutomatChartCubit>()
        .loadChart(currentDevice.code ?? "");

    final signalR = SignalRService();

    signalR.connect(
      meterCode: currentDevice.code ?? "",
    );

    signalR.stream.listen(_handleRealtime);
  }
  void startSwitchCountdown() {

    setState(() {
      switchCountdown = 3;
    });

    switchCooldownTimer?.cancel();

    switchCooldownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (switchCountdown == 0) {
          timer.cancel();
        } else {
          setState(() {
            switchCountdown--;
          });
        }
      },
    );
  }
  /// Huỷ timer khi thoát màn hình
  @override
  void dispose() {
    _timer?.cancel();
    maintenanceTimer?.cancel();
    switchCooldownTimer?.cancel();
    switchCountdownTimer?.cancel();
    super.dispose();
  }
  void startCooldown() {

    setState(() {
      switchCooldown = 3;
    });

    switchCountdownTimer?.cancel();

    switchCountdownTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {

        if (switchCooldown <= 1) {

          timer.cancel();

          setState(() {
            switchCooldown = 0;
          });

        } else {

          setState(() {
            switchCooldown--;
          });

        }
      },
    );
  }
  void startMaintenanceCountdown() {

    setState(() {
      maintenanceCountdown = 13;
    });

    maintenanceTimer?.cancel();

    maintenanceTimer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (maintenanceCountdown == 0) {
          timer.cancel();
        } else {
          setState(() {
            maintenanceCountdown--;
          });
        }
      },
    );
  }
  void _handleRealtime(Map<String, dynamic> data) {
    try {
      final event = data["event"];

      /// command response từ server
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
      if (dto == null) return;

      final raw = Map<String, dynamic>.from(dto);

      /// convert string -> number
      raw.updateAll((key, value) {
        if (value is String) {
          final numValue = num.tryParse(value);
          return numValue ?? value;
        }
        return value;
      });

      raw["updatedAt"] = data["updatedAt"];

      final log = AtomatLogResponse.fromJson(raw);

      /// ⚡ update trạng thái CB realtime
      if (log.rlySta != null) {
        context.read<DeviceCubit>().updateRealtimeLogByCode(
          currentDevice.code,
          log,
        );
      }

      /// tính điện năng
      if (log.epi != null) {
        double energy = log.epi! - epiAtStartOfDay;
        double money = energy * pricePerKwh;
        double realtime = (log.p ?? 0) * pricePerKwh / 3600;

        setState(() {
          todayEnergy = energy;
          moneyToday = money;
          realtimeCost += realtime;
        });
      }

    } catch (e) {
      print("❌ Parse realtime error: $e");
    }
  }
  /// Lấy điện năng tại thời điểm đầu ngày (00:00)
  /// dùng để tính điện năng hôm nay:
  ///
  /// todayEnergy = currentEpi - epiAtStartOfDay
  Future<void> _loadStartOfDayEnergy() async {
    final api = GetIt.instance<ApiClient>();

    final result = await api.getBreakerLog(currentDevice.code ?? "");

    final logs = result.data;

    if (logs == null || logs.isEmpty) return;

    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final firstLog = logs.firstWhere(
          (e) => DateTime.parse(e.updatedAt!).isAfter(startOfDay),
      orElse: () => logs.first,
    );

    epiAtStartOfDay = firstLog.epi ?? 0;
  }
  /// Lấy giá điện từ API
  /// dùng để tính tiền điện
  Future<void> _loadElectricPrice() async {
    try {
      final api = GetIt.instance<ApiClient>();

      final result = await api.getPriceConfig(currentDevice.id);

      if (result.isNotEmpty) {
        setState(() {
          pricePerKwh = result.first.priceAvr ?? 0;
        });
      }
    } catch (e) {
      print("Load price error: $e");
    }
  }
  /// Reload danh sách thiết bị từ server
  /// dùng sau khi đóng/cắt CB
  Future<void> _reloadDevice() async {
    await context.read<DeviceCubit>().getAllDevices(
      powerStationId: currentDevice.powerStationId,
    );
  }
  /// Reload log breaker realtime
  void _reloadRealTime() {
    cubit.getBreakerLog(currentDevice.code ?? "");
  }
  /// Hiển thị dialog nhập PIN
  /// dùng khi đóng/cắt CB
  Future<String?> _showPasswordDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _PinDialog();
      },
    );
  }
  /// Convert trạng thái CB -> text hiển thị
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
  /// Convert trạng thái CB -> màu hiển thị
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
  /// Chọn icon thiết bị theo meterTypeId
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
    final chartData = context.watch<AutomatChartCubit>().state;

    final maxValue = chartData.isEmpty
        ? 5
        : chartData.map((e) => e.p ?? 0).reduce((a, b) => a > b ? a : b);
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
                "Phân tích năng lượng",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
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
                    /// UI button chọn range chart (1D / 7D / 30D)
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
            height: 170,
            child: Padding(
              padding: const EdgeInsets.only(right: 4),

              child: LineChart(

                LineChartData(

                  minX: 0,
                  maxX: (chartData.length - 1).toDouble(),

                  minY: 0,
                  maxY: maxValue + 0.5,

                  lineTouchData: LineTouchData(enabled: false),

                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 0.5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.25),
                        strokeWidth: 1,
                        dashArray: [6,4],
                      );
                    },
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 0.5,
                        reservedSize: 42, // tăng chiều rộng trục Y
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toStringAsFixed(1)} kW",
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

                            final index = value.toInt();

                            if (index >= chartData.length) {
                              return const SizedBox();
                            }

                            if (index % 5 != 0) {
                              return const SizedBox();
                            }

                            final time = DateFormat("HH:mm")
                                .format(chartData[index].updatedAt ?? DateTime.now());

                            return Text(
                              time,
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                      ),
                    ),

                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),

                  borderData: FlBorderData(show: false),

                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(chartData.length, (i) {
                        final item = chartData[i];
                        return FlSpot(
                          i.toDouble(),
                          item.p ?? 0,
                        );
                      }),

                      isCurved: true,
                      curveSmoothness: 0.25,

                      barWidth: 3,

                      color: const Color(0xFF1ABC9C),

                      dotData: const FlDotData(show: false),

                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF1ABC9C).withOpacity(0.18),
                            const Color(0xFF1ABC9C).withOpacity(0.02),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
          const SizedBox(height: 10),
          /// Card hiển thị thông số
          /// ví dụ:
          /// - điện áp
          /// - dòng điện
          /// - công suất
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
                    children:  [
                      Text(
                        "Tiền điện hôm nay",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${todayEnergy.toStringAsFixed(1)} kWh • ${pricePerKwh.toInt()}đ/kWh",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                /// PRICE
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${NumberFormat("#,###").format(moneyToday)} đ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "+${realtimeCost.toStringAsFixed(0)} đ",
                      style: const TextStyle(
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
                _tabItem("Home", false, isHome: true, context: context),
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
      barsSpace: 4, // khoảng cách giữa 2 cột (nhỏ lại để sát nhau)
      barRods: [

        /// cột nhạt
        BarChartRodData(
          toY: y1,
          width: 8, // làm cột to
          borderRadius: BorderRadius.zero, // bỏ bo góc -> thành hình chữ nhật
          color: const Color(0xFFAEDDD6),
        ),

        /// cột đậm
        BarChartRodData(
          toY: y2,
          width: 6,
          borderRadius: BorderRadius.circular(3),
          color: const Color(0xFF4FA89E),
        ),
      ],
    );
  }
  Widget _tabItem(
      String text,
      bool active, {
        bool isHome = false,
        BuildContext? context,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isHome && context != null) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active
                    ? const Color(0xFF1ABC9C)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if (isHome)
                const Icon(
                  Icons.home,
                  size: 16,
                  color: Colors.grey,
                ),

              if (isHome) const SizedBox(width: 4),

              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.black : Colors.grey,
                ),
              ),
            ],
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
                  device.gatewayNumber ?? "",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// HISTORY
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SwitchLogScreen(
                    gatewaySn: device.gatewayNumber ?? '',
                    breakerSn: device.code ?? "",
                  ),
                ),
              );
            },
            child: _circleIconPremium(
              icon: Icons.history,
              bgColor: const Color(0xFF1ABC9C),
            ),
          ),

          const SizedBox(width: 10),

          /// SETTINGS
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<DeviceCubit>(),
                    child: SettingScreen(device: device),
                  ),
                ),
              );
            },
            child: _circleIconPremium(
              icon: Icons.settings,
              bgColor: const Color(0xFFB8B8C7),
            ),
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
  Widget _buildBigStatusCard(DeviceResponse device, AtomatLogResponse? log) {

    /// trạng thái thật của thiết bị


    final bool isMaintenance = device.rlyRepSta == 1;
    final realStatus =
    getRealStatus(device, context.watch<DeviceCubit>().state.breakerLog);
    final bool isOn = realStatus == 1;

    String statusText;
    IconData icon;
    List<Color> gradientColors;

    if (isMaintenance) {
      statusText = "ĐANG BẢO TRÌ";
      icon = Icons.build_circle;

      gradientColors = [
        BreakerColors.maintenance,
        BreakerColors.exitMaintenance,
      ];
    }
    else if (isOn) {
      statusText = "Đóng";
      icon = Icons.power;

      gradientColors = [
        BreakerColors.on.withOpacity(0.7),
        BreakerColors.on,
      ];
    }
    else {
      statusText = "Cắt";
      icon = Icons.power_off;

      gradientColors = [
        BreakerColors.off.withOpacity(0.7),
        BreakerColors.off,
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
        final realStatus =
        getRealStatus(device, context.watch<DeviceCubit>().state.breakerLog);
        final bool isOn = realStatus == 1;
        final isMaintenance = device.rlyRepSta == 1;
        final isSwitching = context.watch<DeviceCubit>().state.isSwitching;
        final state = context.watch<DeviceCubit>().state;
        final countdown = context.watch<DeviceCubit>().state.switchCountdown;
        final int status = device.status ?? 0;
        return Scaffold(
          backgroundColor: const Color(0xFFF3F6FB),

          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

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

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      device.gatewayNumber ?? "",
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

                  /// Card hiển thị thông tin thiết bị
                  /// - tên
                  /// - gateway
                  /// - nút history
                  /// - nút settings
                  _buildTopDeviceCard(device, log),

                  const SizedBox(height: 16),

                  /// Card trạng thái lớn
                  /// hiển thị:
                  /// - ON
                  /// - OFF
                  /// - Maintenance
                  _buildBigStatusCard(device, log),

                  const SizedBox(height: 16),

                  /// HEADER ACTION BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      /// ===== ĐÓNG / CẮT =====
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: isOn
                                ? BreakerColors.on
                                : BreakerColors.off,        // đang OFF → nút ĐÓNG (đỏ)
                            foregroundColor: Colors.white,
                          ),
                          onPressed: (isSwitching || isMaintenance || countdown > 0)
                              ? null
                              : () async {

                            final password = await _showPasswordDialog(context);
                            if (password == null) return;

                            await context.read<DeviceCubit>().togglePower(
                              device,
                              password: password,
                            );

                            startCooldown();
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
                                countdown > 0
                                    ? "${countdown}s"
                                    : (isOn ? "Đóng" : "Cắt"),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// ===== FORCE =====
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: BreakerColors.off, // Force ĐÓNG (xanh dương nhạt)
                            foregroundColor: Colors.white,
                          ),
                          onPressed: (isSwitching || switchCooldown > 0 || isMaintenance)
                              ? null
                              : () async {

                            final password = await _showPasswordDialog(context);
                            if (password == null) return;

                            await context.read<DeviceCubit>().forcePower(
                              device,
                              password: password,
                            );

                            startCooldown();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.flash_on, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                switchCooldown > 0
                                    ? "${switchCooldown}s"
                                    : "Force",
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// ===== BẢO TRÌ =====
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: isMaintenance
                                ? BreakerColors.exitMaintenance
                                : BreakerColors.maintenance,
                            foregroundColor: Colors.white,
                          ),

                          onPressed: state.isForceLoading || maintenanceCountdown > 0
                              ? null
                              : () async {

                            final password = await _showPasswordDialog(context);
                            if (password == null) return;

                            final wasMaintenance = isMaintenance;

                            await context.read<DeviceCubit>().toggleMaintenance(
                              device,
                              password: password,
                            );

                            /// chỉ countdown khi THOÁT bảo trì
                            if (wasMaintenance) {
                              startMaintenanceCountdown();
                            }
                          },

                          child: state.isForceLoading
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Text(
                            maintenanceCountdown > 0
                                ? "Chờ ${maintenanceCountdown}s"
                                : isMaintenance
                                ? "Thoát bảo trì"
                                : "Bảo trì",
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// GRID OVERVIEW
                  _buildOverviewSection(context, log, device),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future<String?> _askPassword(BuildContext context) {
    return _showPasswordDialog(context);
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
int getRealStatus(DeviceResponse device, AtomatLogResponse? log) {
  return log?.rlySta ?? device.status ?? 0;
}
class BreakerColors {

  static const on = Color(0xFF2E7D32); // xanh
  static const off = Color(0xFFD32F2F); // đỏ

  static const maintenance = Color(0xFFFF9800); // cam
  static const exitMaintenance = Color(0xFFFF9800); // cam

  static const forceOn = Color(0xFFD32F2F); // đỏ
  static const forceOff = Color(0xFFD32F2F); // đỏ
}
Widget buildStatusCard(
    DeviceResponse device,
    AtomatLogResponse? log,
    ) {

  final realStatus = getRealStatus(device, log);

  final bool isMaintenance = device.rlyRepSta == 1;
  final bool isOn = realStatus == 1;

  String text;
  Color color;

  if (isMaintenance) {
    text = "Bảo trì";
    color = BreakerColors.maintenance;
  }
  else if (isOn) {
    text = "Đóng";
    color = BreakerColors.on;
  }
  else {
    text = "Cắt";
    color = BreakerColors.off;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(Icons.power, color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
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
          /// Dialog nhập PIN 4 số
          /// mặc định: 9999
          const Text(
            "PIN mặc định: 9999",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
