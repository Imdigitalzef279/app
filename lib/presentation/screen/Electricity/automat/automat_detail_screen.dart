import 'dart:async';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../../data/repositories/electric_report/electric_report_repository.dart';
import '../../device/bloc/device_cubit.dart';
import 'ElectricHistoryScreen/ElectricHistoryScreen.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';
import 'full_chart/full_chart_screen.dart';

enum ChartType {
  power,
  energy,
}
enum ChartDisplayType {
  line,
  bar,
}
enum MeterType {
  household,
  business,
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
  StreamSubscription? _signalSub;
  bool isForceMode = false;
  ChartRange _selectedRange = ChartRange.month;
  ChartDisplayType chartDisplayType = ChartDisplayType.line;
  late AtomatDetailCubit cubit;
  ChartType chartType = ChartType.power;
  double todayEnergy = 0;
  double moneyToday = 0;
  double epiAtStartOfDay = 0;
  double realtimeCost = 0;
  int maintenanceCountdown = 0;
  Timer? maintenanceTimer;
  double epiAtStartOfMonth = 0;
  double epiAtStartOfRange = 0;
  bool isInitDone = false;
  double calculateHouseholdCost(double kwh) {
    double cost = 0;

    final tiers = [
      [50.0, 1984.0],
      [50.0, 2050.0],
      [100.0, 2380.0],
      [100.0, 2998.0],
      [100.0, 3350.0],
      [double.infinity, 3460.0],
    ];

    double remaining = kwh;

    for (var tier in tiers) {
      final limit = tier[0];
      final price = tier[1];

      final used = remaining > limit ? limit : remaining;

      cost += used * price;
      remaining -= used;

      if (remaining <= 0) break;
    }

    return (cost * 1.1).roundToDouble();
  }


  final formatted = DateFormat("yyyy-MM-dd'T'00:00:00");
  Timer? _timer;
  Timer? _realtimeTimer;
  @override
  void initState() {
    super.initState();

    cubit = context.read<AtomatDetailCubit>();
    startRealtimeRefresh();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final device = widget.device;

      await context.read<AutomatChartCubit>().loadChart(
        device.code ?? "",
        _selectedRange,
      );


      await _loadElectricReport(device);
    });
  }
  @override
  void dispose() {
    _signalSub?.cancel();
    maintenanceTimer?.cancel();
    _realtimeTimer?.cancel();
    super.dispose();
  }
  void startRealtimeRefresh() {

    _realtimeTimer?.cancel();

    _realtimeTimer = Timer.periodic(
      const Duration(seconds: 3),
          (_) async {

            await context.read<DeviceCubit>().loadBreakerLog(
              widget.device.gatewayNumber ?? '',
            );

        if (mounted) {
          setState(() {});
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

  List getDisplayData(List chartData) {
    switch (_selectedRange) {

    /// 1D -> 24 giờ
      case ChartRange.day:
        return chartData.length > 24
            ? chartData.sublist(chartData.length - 24)
            : chartData;

    /// 7D -> 7 ngày
      case ChartRange.week:
        return chartData.length > 7
            ? chartData.sublist(chartData.length - 7)
            : chartData;

    /// 1M -> tất cả ngày trong tháng
      case ChartRange.month:
        return chartData;

    /// 1Y -> 12 tháng
      case ChartRange.year:
        return chartData.length > 12
            ? chartData.sublist(chartData.length - 12)
            : chartData;

      default:
        return chartData;
    }
  }

  MeterType getMeterType(DeviceResponse device) {
    if (device.meterTypeId == 81 || device.meterTypeId == 82) {
      return MeterType.household;
    }
    return MeterType.business;
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
  DateTime getStartOfWeek(DateTime now) {
    int weekday = now.weekday;
    return DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: weekday - 1));
  }
  Future<void> _loadElectricReport(DeviceResponse device) async {
    try {
      final repo = ElectricReportRepository(GetIt.instance<ApiClient>());
      final now = DateTime.now();

      DateTime from;

      switch (_selectedRange) {
        case ChartRange.day:
          from = DateTime(now.year, now.month, now.day);
          break;
        case ChartRange.week:
          from = getStartOfWeek(now);
          break;
        case ChartRange.month:
          from = DateTime(now.year, now.month, 1);
          break;
        case ChartRange.year:
          from = DateTime(now.year, 1, 1);
          break;
        default:
          from = DateTime(now.year, now.month, now.day);
      }

      final report = await repo.getElectricReport(
        meterId: device.id,
        from: from,
        to: now,
      );

      double energy = 0;
      double money = 0;

      /// ===== TIER =====
      if (report.type == "TIER" && report.tiers.isNotEmpty) {
        energy = report.tiers.fold(0, (s, e) => s + e.kwhInStep);
        money = report.tiers.fold(0, (s, e) => s + e.stepCost);
      }

      /// ===== TOU =====
      else if (report.tou != null && report.tou!.totalKwh > 0) {
        energy = report.tou!.totalKwh;
        money = report.tou!.totalWithVat;
      }

      /// ===== KHÔNG CÓ DATA =====
      else {
        energy = 0;
        money = 0;
      }


      setState(() {
        todayEnergy = energy;
        moneyToday = money;
      });

      print("✅ ENERGY: $energy kWh");
      print("💰 MONEY: $money đ");

    } catch (e) {
      print("❌ ElectricReport error: $e");
    }
  }
  double getMaxY(double maxValue) {
    switch (_selectedRange) {
      case ChartRange.day:
        return maxValue * 1.2;
      case ChartRange.week:
        return maxValue * 1.3;
      case ChartRange.month:
        return maxValue * 1.4;
      case ChartRange.year:
        return maxValue * 1.5;
      case ChartRange.quarter:
        return maxValue * 1.45;
    }
  }
  String formatTime(DateTime time) {
    switch (_selectedRange) {
      case ChartRange.day:
        return DateFormat("HH:mm").format(time);
      case ChartRange.week:
        return DateFormat("dd/MM").format(time);
      case ChartRange.month:
        return DateFormat("dd/MM").format(time);
      case ChartRange.year:
        return DateFormat("MM/yyyy").format(time);
      case ChartRange.quarter:
        return DateFormat("MM/yyyy").format(time);
    }
  }

  Widget _deviceImage(DeviceResponse device) {
    ///  Ưu tiên ảnh user chọn
    if (device.avatar.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(device.avatar),
          fit: BoxFit.cover,
        ),
      );
    }

    ///  fallback về asset
    String path;

    switch (device.meterTypeId) {
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

    return Image.asset(path, fit: BoxFit.contain);
  }
  Widget _buildOverviewSection(
      BuildContext context,
      DeviceResponse device,
      ) {
    final now = DateTime.now();
    final chartData = context.watch<AutomatChartCubit>().state;
    final yAxisLabel = chartType == ChartType.power ? "Power (kW)" : "Energy (kWh)";
    final xAxisLabel = "Time";
    final limitedData = getDisplayData(chartData);
    final latest = limitedData.isNotEmpty ? limitedData.last : null;

    final deviceState = context.watch<DeviceCubit>().state;
    final realtimeLog = deviceState.breakerLogs[device.code];
    final double maxValue = limitedData.isEmpty
        ? 5.0
        : limitedData
        .map((e) => chartType == ChartType.power
        ? (e.p ?? 0).toDouble()
        : (e.epi ?? 0).toDouble())
        .reduce((a, b) => a > b ? a : b);
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
                  setState(() {
                    chartType = chartType == ChartType.power
                        ? ChartType.energy
                        : ChartType.power;
                  });
                },
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    chartType == ChartType.power
                        ? Icons.bolt
                        : Icons.battery_charging_full,
                    color: const Color(0xFF1ABC9C),
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 6),


              Row(
                children: [
                ],
              ),
              const Text(
                "Dữ liệu năng lượng",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),

              const Spacer(),
              ///  ICON FULL SCREEN
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullChartScreen(
                        chartData: chartData,
                        selectedRange: _selectedRange,
                        chartType: chartType,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F6F3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.fullscreen,
                    size: 18,
                    color: Color(0xFF1ABC9C),
                  ),
                ),
              ),
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
                    _rangeChip("1D", ChartRange.day, device),
                    _rangeChip("7D", ChartRange.week, device),
                    _rangeChip("1M", ChartRange.month, device),
                    _rangeChip("1Y", ChartRange.year, device),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                latest != null
                    ? (chartType == ChartType.power
                    ? "${latest.p?.toStringAsFixed(2)}"
                    : "${latest.epi?.toStringAsFixed(0)}")
                    : "--",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                chartType == ChartType.power ? "kW" : "kWh",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          /// ===== CHART =====
          SizedBox(
            height: 230,
            child: Column(
              children: [

                /// Y axis label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    yAxisLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: chartDisplayType == ChartDisplayType.line
                        ? _buildLineChart(limitedData, maxValue.toDouble())
                        : _buildBarChart(limitedData, maxValue),
                  ),
                ),

                const SizedBox(height: 4),

                /// X axis label
                Text(
                  xAxisLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    chartDisplayType =
                    chartDisplayType == ChartDisplayType.line
                        ? ChartDisplayType.bar
                        : ChartDisplayType.line;
                  });
                },

                child: Container(
                  padding: const EdgeInsets.all(6),

                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F6F3),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Icon(
                    chartDisplayType == ChartDisplayType.line
                        ? Icons.show_chart
                        : Icons.bar_chart,
                    size: 18,
                    color: const Color(0xFF1ABC9C),
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _metricCard(
                  "Điện áp",
                  "${latest?.ua?.toStringAsFixed(0) ??
                      realtimeLog?.ua?.toStringAsFixed(0) ??
                      '--'}",
                  "V",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricCard(
                  "Dòng điện",
                  "${latest?.ia?.toStringAsFixed(0) ??
                      realtimeLog?.ia?.toStringAsFixed(0) ??
                      '--'}",
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

                  "${latest?.p?.toStringAsFixed(1) ??
                      realtimeLog?.p?.toStringAsFixed(1) ??
                      '--'}",
                  "kW",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricCard(
                  "Điện năng",
                  "${latest?.epi?.toStringAsFixed(0) ??
                      realtimeLog?.epi?.toStringAsFixed(0) ??
                      '--'}",
                  "kWh",
                ),
              ),
            ],
          ),
                _buildElectricCard(),



      const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                _tabItem("Tổng quan", true, device),
                _tabItem("Thông số", false, device),
                _tabItem("Lịch sử", false, device, isHistory: true, context: context),
                _tabItem("Home", false, device, isHome: true, context: context),
              ],
            ),
          ),
]
      )
    );
  }
  String getTitle() {
    switch (_selectedRange) {
      case ChartRange.day:
        return "Tiền điện hôm nay";
      case ChartRange.week:
        return "Tiền điện 7 ngày gần nhất";
      case ChartRange.month:
        return "Tiền điện từ đầu tháng";
      case ChartRange.year:
        return "Tiền điện từ đầu năm";
      default:
        return "Tiền điện";
    }
  }
  Widget _buildElectricCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== HEADER =====
          Row(
            children:  [
              Icon(Icons.savings, size: 18, color: Color(0xFF1ABC9C)),
              SizedBox(width: 6),
              Text(
                getTitle(),
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TIỀN
              Text(
    "${NumberFormat("#,###", "vi_VN").format(moneyToday)} đ",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 4),

              /// kWh
              Text(
                "${todayEnergy.toStringAsFixed(2)} kWh",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),

              const SizedBox(height: 12),

              /// BUTTON nằm ngang
              Row(
                children: [
                  Expanded(
                    child: _textBtn("Lịch sử", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ElectricHistoryScreen(device: widget.device),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _textBtn("Cài đặt", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingScreen(device: widget.device),
                        ),
                      );
                    }),
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
  Widget _textBtn(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1ABC9C),
          ),
        ),
      ),
    );
  }

  Widget _tabItem(
      String text,
      bool active,
      DeviceResponse device,{
        bool isHome = false,
        bool isHistory = false,
        BuildContext? context,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isHome && context != null) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          if (isHistory && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SwitchLogScreen(
                  gatewaySn: device.gatewayNumber ?? '',
                  breakerSn: device.code ?? "",
                ),
              ),
            );
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
  Widget _rangeChip(String text, ChartRange range, DeviceResponse device) {
    final bool active = _selectedRange == range;

    return GestureDetector(
      onTap: () async {
        setState(() {
          _selectedRange = range;
        });


        await context.read<AutomatChartCubit>().loadChart(
          device.code ?? "",
          _selectedRange,
        );

        await _loadElectricReport(device);
      },

      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),

        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFE7F6F3)
              : const Color(0xFFF0F2F6),
          borderRadius: BorderRadius.circular(10),
        ),

        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: active
                ? const Color(0xFF1ABC9C)
                : Colors.black,
          ),
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
            child: _deviceImage(device),
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

  Widget _buildBarChart(List chartData, double maxValue) {

    final limitedData = getDisplayData(chartData);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: SizedBox(
        width: _getChartWidth(limitedData.length),
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.black87,
                tooltipBorderRadius: BorderRadius.circular(10),
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 16,
                fitInsideHorizontally: true,
                fitInsideVertically: true,

                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final item = limitedData[group.x.toInt()];
                  final time = item.updatedAt;

                  String timeLabel;

                  switch (_selectedRange) {

                    case ChartRange.day:
                      timeLabel = DateFormat("HH:mm").format(time);

                  /// 7D
                    case ChartRange.week:
                      timeLabel  = DateFormat("EEE", "vi").format(time);
                      break;

                  /// 1M
                    case ChartRange.month:
                      timeLabel = DateFormat("dd").format(time);
                      break;

                  /// 1Y
                    case ChartRange.year:
                      timeLabel = DateFormat("MM").format(time);
                      break;

                    default:
                      timeLabel = "";
                  }

                  final unit = chartType == ChartType.power ? "kW" : "kWh";

                  return BarTooltipItem(
                    "$timeLabel\n",
                    const TextStyle(color: Colors.grey, fontSize: 10),
                    children: [
                      TextSpan(
                        text: "${rod.toY.toStringAsFixed(2)} $unit",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            alignment: BarChartAlignment.center,
            groupsSpace: 14,
            maxY: maxValue == 0 ? 5 : getMaxY(maxValue),
            borderData: FlBorderData(show: false),

            /// GRID
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxValue == 0 ? 1 : maxValue / 6,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.15),
                  strokeWidth: 1,
                );
              },
            ),

            /// TITLES
            titlesData: FlTitlesData(

              /// LEFT
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              /// BOTTOM
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 70,
                  getTitlesWidget: (value, meta) {

                    final index = value.toInt();
                    if (index >= limitedData.length) return const SizedBox();

                    final time = limitedData[index].updatedAt;

                    String label;

                    switch (_selectedRange) {
                      case ChartRange.day:
                        label = "${time.hour}h";
                        break;
                      case ChartRange.week:
                        label = DateFormat("EEE", "vi").format(time);
                        break;
                      case ChartRange.month:
                        label = DateFormat("dd").format(time);
                        break;
                      case ChartRange.year:
                        label = DateFormat("MM").format(time);
                        break;
                      default:
                        label = "";
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),

              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            /// BAR DATA
            barGroups: List.generate(limitedData.length, (i) {

              final item = limitedData[i];

              final y = chartType == ChartType.power
                  ? (item.p ?? 0)
                  : (item.epi ?? 0);

              return BarChartGroupData(
                x: i,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                    toY: y.toDouble(),
                    width: 8,
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1ABC9C),
                        Color(0xFF6CC3B8),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ],
              );
            }),
          ),

        ),
      ),
    );
  }
  Widget _buildLineChart(List chartData, double maxValue) {

    final data = getDisplayData(chartData);
    String timeLabel;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: SizedBox(
        width: _getChartWidth(data.length),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,

              handleBuiltInTouches: true,

              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.black87,
                tooltipBorderRadius: BorderRadius.circular(10),
                tooltipPadding: const EdgeInsets.all(8),

                fitInsideHorizontally: true,
                fitInsideVertically: true,

                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final item = data[spot.x.toInt()];
                    final time = item.updatedAt;

                    String timeLabel;

                    switch (_selectedRange) {

                      case ChartRange.day:
                        timeLabel = DateFormat("HH:mm").format(time);

                    /// 7D
                      case ChartRange.week:
                        timeLabel = DateFormat("EEE", "vi").format(time);
                        break;

                    /// 1M
                      case ChartRange.month:
                        timeLabel = DateFormat("dd").format(time);
                        break;

                    /// 1Y
                      case ChartRange.year:
                        timeLabel = DateFormat("MM").format(time);
                        break;

                      default:
                        timeLabel = "";
                    }

                    final unit = chartType == ChartType.power ? "kW" : "kWh";

                    return LineTooltipItem(
                      "$timeLabel\n",
                      const TextStyle(color: Colors.grey, fontSize: 10),
                      children: [
                        TextSpan(
                          text: "${spot.y.toStringAsFixed(2)} $unit",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),

              getTouchedSpotIndicator: (barData, spotIndexes) {
                return spotIndexes.map((index) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: Colors.transparent),
                    FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) =>
                          FlDotCirclePainter(
                            radius: 5,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: const Color(0xFF1ABC9C),
                          ),
                    ),
                  );
                }).toList();
              },
            ),
            minX: 0,
            maxX: (data.length - 1).toDouble(),

            minY: 0,
            maxY: getMaxY(maxValue),

            borderData: FlBorderData(show: false),

            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxValue == 0 ? 1 : maxValue / 6,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.12),
                  strokeWidth: 1,
                  dashArray: [4, 4],
                );
              },
            ),

            titlesData: FlTitlesData(

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    );
                  },
                ),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {

                    final index = value.toInt();
                    if (index >= data.length) return const SizedBox();

                    final time = data[index].updatedAt;

                    String label;

                    switch (_selectedRange) {
                      case ChartRange.day:
                        label = "${time.hour}h";
                        break;
                      case ChartRange.week:
                        label = DateFormat("EEE", "vi").format(time);
                        break;
                      case ChartRange.month:
                        label = DateFormat("dd").format(time);
                        break;
                      case ChartRange.year:
                        label = DateFormat("MM").format(time);
                        break;
                      default:
                        label = "";
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
              ),

              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: List.generate(data.length, (i) {
                  final item = data[i];
                  final y = chartType == ChartType.power
                      ? (item.p ?? 0)
                      : (item.epi ?? 0);
                  return FlSpot(i.toDouble(), y.toDouble());
                }),
                isCurved: true,
                curveSmoothness: 0.35,
                barWidth: 4,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF00E5C0),
                    Color(0xFF1ABC9C),
                  ],
                ),
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1ABC9C).withOpacity(0.25),
                      const Color(0xFF1ABC9C).withOpacity(0.05),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  double _getChartWidth(int length) {
    double baseWidth;

    switch (_selectedRange) {
      case ChartRange.day:
        baseWidth = 28;
        break;
      case ChartRange.week:
        baseWidth = 40;
        break;
      case ChartRange.month:
        baseWidth = 22;
        break;
      case ChartRange.year:
        baseWidth = 40;
        break;
      default:
        baseWidth = 24;
    }

    return (length * baseWidth).clamp(320, 2000).toDouble();
  }
  Widget _buildBigStatusCard(DeviceResponse device, AtomatLogResponse? log) {

    final deviceCubit = context.watch<DeviceCubit>();


    final isSwitching = deviceCubit.isDeviceSwitching(device.id);

    final realStatus = deviceCubit.getRealStatus(device, log);

    String statusText;
    IconData icon;
    List<Color> gradientColors;

    switch (realStatus) {

    /// OFFLINE
      case -1:
        statusText = "Ngoại tuyến";
        icon = Icons.cloud_off;
        gradientColors = [
          Colors.grey.shade400,
          Colors.grey.shade600,
        ];
        break;

    /// MAINTENANCE
      case 2:
        statusText = "Bảo trì";
        icon = Icons.build;
        gradientColors = [
          BreakerColors.maintenance.withOpacity(0.8),
          BreakerColors.maintenance,
        ];
        break;

    /// ON
      case 1:
        statusText = "Đóng";
        icon = Icons.flash_on;
        gradientColors = [
          BreakerColors.on.withOpacity(0.7),
          BreakerColors.on,
        ];
        break;

    /// OFF
      default:
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
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
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

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
    final state = context.watch<DeviceCubit>().state;


    final device = state.resultDevices.data
        ?.firstWhere((d) => d.id == widget.device.id);

    if (device == null) {
      return const SizedBox();
    }
    print("===== DETAIL BUILD =====");
    print("DEVICE ID: ${device?.id}");
    print("DEVICE.STATUS: ${device?.status}");
        if (device == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }


        final deviceCubit = context.watch<DeviceCubit>();
    final log = state.breakerLogs[device.code];
    print("LOG.rlySta: ${log?.rlySta}");
    final isSwitching = deviceCubit.isDeviceSwitching(device.id);

    final realStatus = deviceCubit.getRealStatus(device, log);
    print("REAL STATUS: $realStatus");
    final bool isOn = realStatus == 1;
        final bool isMaintenance = realStatus == 2;
        final countdown = state.switchCountdowns[device.id] ?? 0;
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent, // x Material 3
            systemOverlayStyle: SystemUiOverlayStyle.dark, // icon status bar đen
            centerTitle: true,
            title: const SizedBox(),
          ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF6F8FC),
                    Color(0xFFEFF3FA),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

                child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isTablet = constraints.maxWidth >= 700;

                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isTablet ? 900 : 420,
                          ),

                          child: ListView(
                            padding: EdgeInsets.fromLTRB(
                              16,
                              MediaQuery
                                  .of(context)
                                  .padding
                                  .top + 60,
                              16,
                              18,
                            ),

                            children: [


                              _buildTopDeviceCard(device, log),

                              const SizedBox(height: 16),


                              _buildBigStatusCard(device, log),

                              const SizedBox(height: 16),


                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [

                                  /// ===== ĐÓNG / CẮT =====
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                        ),
                                        backgroundColor: isOn
                                            ? BreakerColors.off
                                            : BreakerColors.on,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: (isMaintenance || isSwitching)
                                          ? null
                                          : () async {
                                        final password = await _showPasswordDialog(
                                            context);
                                        if (password == null) return;

                                        await context
                                            .read<DeviceCubit>()
                                            .togglePower(
                                          device,
                                          password: password,
                                        );
                                      },
                                      child: (isSwitching || countdown > 0)
                                          ? Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            countdown > 0
                                                ? "${countdown}s"
                                                : (isOn
                                                ? "Đang cắt..."
                                                : "Đang đóng..."),
                                          ),
                                        ],
                                      )
                                          : Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(isOn ? Icons.power_off : Icons
                                              .flash_on),
                                          SizedBox(width: 6),
                                          Text(isOn ? "Cắt" : "Đóng"),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                        ),
                                        backgroundColor: BreakerColors.off,
                                        // Force ĐÓNG (xanh dương nhạt)
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: (isMaintenance ||
                                          isSwitching || countdown > 0)
                                          ? null
                                          : () async {
                                        final password = await _showPasswordDialog(
                                            context);
                                        if (password == null) return;

                                        await context
                                            .read<DeviceCubit>()
                                            .forcePower(
                                          device,
                                          password: password,
                                        );
                                      },
                                      child: countdown > 0
                                          ? Text(
                                        "$countdown s",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                          : const Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Icon(Icons.flash_on, size: 18),
                                          SizedBox(width: 6),
                                          Text("Force"),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                        ),
                                        backgroundColor: isMaintenance
                                            ? BreakerColors.exitMaintenance
                                            : BreakerColors.maintenance,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed:
                                      state.isForceLoading ||
                                          maintenanceCountdown > 0 ||
                                          realStatus == -1 || // offline
                                          realStatus ==
                                              1 // đang ON thì không cho bảo trì
                                          ? null
                                          : () async {
                                        final password = await _showPasswordDialog(
                                            context);
                                        if (password == null) return;

                                        final wasMaintenance = realStatus == 2;

                                        await context
                                            .read<DeviceCubit>()
                                            .toggleMaintenance(
                                          device,
                                          password: password,
                                        );

                                        if (wasMaintenance) {
                                          startMaintenanceCountdown();
                                        }
                                      },
                                      child: state.isForceLoading
                                          ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
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
                              _buildOverviewSection(context, device),

                            ],
                          ),
                        ),
                      );
                    }
            ),
        ));

  }

  Widget _metricCard(String label, String value, String unit) {
    return Container(
      height: 64,
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
class BreakerColors {

  static const on = Color(0xFF2E7D32); // xanh
  static const off = Color(0xFFD32F2F); // đỏ

  static const maintenance = Color(0xFFFF9800); // cam
  static const exitMaintenance = Color(0xFFFF9800);

}
Widget buildStatusCard(
    BuildContext context,
    DeviceResponse device,
    AtomatLogResponse? log,
    DeviceState state,
    ) {
  final bool isMaintenance = log?.rlyRepSta == 1;


  final deviceCubit = context.watch<DeviceCubit>();

  final realStatus = deviceCubit.getRealStatus(device, log);
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),

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
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),

        decoration: InputDecoration(
          counterText: "",

          filled: true,
          fillColor: const Color(0xFFF5F7FB),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF1ABC9C),
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
