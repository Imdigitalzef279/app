// ================= IMPORT =================
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../data/data_sources/api/api_client.dart';
import '../../../../../data/dto/device/response/device_response.dart';
import '../../../../../data/dto/energy_report/energy_report_response.dart';
import '../../../../../data/repositories/EnergyRepository/EnergyRepository.dart';

/// ================= CUBIT =================
class ElectricHistoryCubit extends Cubit<List<EnergyReportResponse>> {
  final EnergyRepository repo;

  ElectricHistoryCubit(this.repo) : super([]);

  Future<void> load({
    required int stationId,
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final res = await repo.getByDateRange(
        stationId: stationId,
        deviceId: deviceId,
        from: from,
        to: to,
      );
      emit(res);
    } catch (_) {}
  }
}

/// ================= SCREEN =================
class ElectricHistoryScreen extends StatefulWidget {
  final DeviceResponse device;

  const ElectricHistoryScreen({super.key, required this.device});

  @override
  State<ElectricHistoryScreen> createState() =>
      _ElectricHistoryScreenState();
}

class _ElectricHistoryScreenState extends State<ElectricHistoryScreen> {

  int selectedIndex = 1; // 0=7d,1=30d,2=90d

  DateTimeRange get range {
    final now = DateTime.now();
    if (selectedIndex == 0) {
      return DateTimeRange(start: now.subtract(const Duration(days: 7)), end: now);
    }
    if (selectedIndex == 1) {
      return DateTimeRange(start: now.subtract(const Duration(days: 30)), end: now);
    }
    return DateTimeRange(start: now.subtract(const Duration(days: 90)), end: now);
  }

  @override
  void initState() {
    super.initState();

    /// 🔥 AUTO LOAD
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ElectricHistoryCubit>().load(
        stationId: widget.device.powerStationId ?? 0,
        deviceId: widget.device.id,
        from: range.start,
        to: range.end,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ElectricHistoryCubit(
        EnergyRepository(GetIt.instance<ApiClient>()),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FC),
        appBar: AppBar(
          title: const Text("Lịch sử tiêu thụ điện"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              _filter(),

              const SizedBox(height: 16),


              Expanded(
                child: BlocBuilder<ElectricHistoryCubit, List<EnergyReportResponse>>(
                  builder: (context, data) {

                    if (data.isEmpty) {
                      return _emptyState();
                    }

                    return ListView(
                      children: [
                        _summary(data),
                        const SizedBox(height: 16),
                        _chart(data),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  DateTimeRange? selectedRange;

  Widget _filter() {
    return Column(
      children: [

        /// ROW 1
        Row(
          children: [
            Expanded(child: _dropdown("Trạm")),
            const SizedBox(width: 10),
            Expanded(child: _dropdown("Thiết bị")),
          ],
        ),

        const SizedBox(height: 10),

        /// ROW 2
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    selectedRange == null
                        ? "Chọn thời gian"
                        : "${_f(selectedRange!.start)} - ${_f(selectedRange!.end)}",
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            GestureDetector(
              onTap: _search,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1ABC9C),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
  Future<void> _pickDate() async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (result != null) {
      setState(() {
        selectedRange = result;
      });
    }
  }

  void _search() {
    if (selectedRange == null) return;

    final from = DateFormat("yyyy-MM-dd").format(selectedRange!.start);
    final to = DateFormat("yyyy-MM-dd").format(selectedRange!.end);
    print("FROM: $from");
    print("TO: $to");
    context.read<ElectricHistoryCubit>().load(
      stationId: widget.device.powerStationId ?? 0,
      deviceId: widget.device.id,
      from: DateTime.parse(from),
      to: DateTime.parse(to),
    );
  }

  String _f(DateTime d) => "${d.day}/${d.month}/${d.year}";
  Widget _dropdown(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: "1",
          items: const [
            DropdownMenuItem(value: "1", child: Text("NOVA-0017")),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }



  /// ================= SUMMARY =================
  Widget _summary(List<EnergyReportResponse> data) {
    final kwh = data.fold(0.0, (s, e) => s + e.epi);
    final money = kwh * 2500;

    /// DEMO chia tỉ lệ (sau có thể thay bằng API thật)
    final low = kwh * 0.2;
    final mid = kwh * 0.5;
    final high = kwh * 0.3;
    final percent = ((mid / kwh).clamp(0, 1)).toDouble();


    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== TITLE =====
          const Text("Tổng tiêu thụ", style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 6),

          Text(
            "${NumberFormat("#,###").format(money)} đ",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          Text("${kwh.toStringAsFixed(2)} kWh"),

          const SizedBox(height: 20),

          /// ===== SOLAR STYLE BLOCK =====
          Row(
            children: [

              /// 🔥 CIRCLE %
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: CircularProgressIndicator(
                        value: percent,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF1ABC9C)),
                      ),
                    ),
                    Text(
                      "${(percent * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(width: 20),


              Expanded(
                child: Column(
                  children: [
                    _energyItem("Thấp điểm", low, Colors.blue),
                    const SizedBox(height: 10),
                    _energyItem("Trung bình", mid, Colors.orange),
                    const SizedBox(height: 10),
                    _energyItem("Cao điểm", high, Colors.green),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _energyItem(String title, double value, Color color) {
    return Row(
      children: [

        /// màu
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 8),

        /// text
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),

        /// value
        Text(
          "${value.toStringAsFixed(2)} kWh",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  /// ==============  === CHART =================
  Widget _chart(List<EnergyReportResponse> data) {

    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.epi);
    }).toList();

    double maxY = spots.isEmpty
        ? 10
        : spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.2;

    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY,

          /// GRID (đẹp hơn)
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(0.05),
                strokeWidth: 1,
              );
            },
          ),

          /// BORDER
          borderData: FlBorderData(show: false),

          /// TITLE (trục X)
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= data.length) return const SizedBox();

                  final time = data[index].time;

                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "${time.day}/${time.month}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white38,
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

          /// TOUCH (tooltip xịn)
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black87,
              tooltipRoundedRadius: 12,
              getTooltipItems: (spots) {
                return spots.map((spot) {

                  final index = spot.x.toInt();
                  final time = data[index].time;

                  return LineTooltipItem(
                    "${time.day}/${time.month}\n",
                    const TextStyle(color: Colors.grey, fontSize: 10),
                    children: [
                      TextSpan(
                        text: "${spot.y.toStringAsFixed(2)} kWh",
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
          ),

          /// LINE
          lineBarsData: [
          LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.4,
          barWidth: 4,

          /// 🔥 gradient giống app mẫu
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF7A18),
              Color(0xFFFFB347),
            ],
          ),

          /// DOT khi touch
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: const Color(0xFFFF7A18),
              );
            },
          ),

          /// vùng fill dưới
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFF7A18).withOpacity(0.3),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        ]
      ),
    ),
    );
  }


  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.insert_chart_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text("Chưa có dữ liệu"),
        ],
      ),
    );
  }
}