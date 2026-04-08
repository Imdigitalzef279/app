import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/enums/chart_range.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../../../data/dto/energy_report/energy_report_response.dart';
import 'bloc/analytics_cubit.dart';

class AnalyticsDetailScreen extends StatefulWidget {
  final DeviceResponse device;

  const AnalyticsDetailScreen({super.key, required this.device});

  @override
  State<AnalyticsDetailScreen> createState() =>
      _AnalyticsDetailScreenState();
}

class _AnalyticsDetailScreenState extends State<AnalyticsDetailScreen> {
  ChartRange selectedRange = ChartRange.day;
  int selectedChart = 0;

  @override
  void initState() {
    super.initState();
    context.read<AnalyticsCubit>().loadEnergy(
      powerStationId: widget.device.powerStationId ?? 1,
      deviceId: widget.device.id!,
      type: "DAY",
    );
  }

  // ================= FILTER =================
  Widget buildFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _filter("Ngày", ChartRange.day),
        _filter("Tháng", ChartRange.month),
        _filter("Năm", ChartRange.year),
      ],
    );
  }

  Widget _filter(String text, ChartRange range) {
    final active = selectedRange == range;

    return GestureDetector(
      onTap: () {
        setState(() => selectedRange = range);

        context.read<AnalyticsCubit>().loadEnergy(
          powerStationId: widget.device.powerStationId ?? 1,
          deviceId: widget.device.id!,
          type: range.name.toUpperCase(),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ================= TAB =================
  Widget buildTabs() {
    final tabs = ["Công suất (kW)", "Điện năng (kWh)"];

    return Row(
      children: List.generate(tabs.length, (i) {
        final active = selectedChart == i;

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedChart = i),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: active ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
  // ================= KPI =================
  Widget buildHeader(List<EnergyReportResponse> data) {
    if (data.isEmpty) return SizedBox();


    final values = data.map((e) {
      return selectedChart == 0 ? e.p : e.epi;
    }).toList();

    final total = values.fold(0.0, (a, b) => a + b);
    final avg = values.reduce((a, b) => a + b) / values.length;
    final max = values.reduce((a, b) => a > b ? a : b);
    return Row(
      children: [
        _kpi(
          selectedChart == 0 ? "Công suất" : "Điện năng",
          total,
          selectedChart == 0 ? "kW" : "kWh",
        ),
        _kpi("TB", avg, "kW"),
        _kpi("Peak", max, "kW"),
      ],
    );
  }

  Widget _kpi(String title, double value, String unit) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF69C21),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
            SizedBox(height: 6),
            Text(
              value.toStringAsFixed(1),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(unit, style: TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // ================= CHART =================
  Widget buildChart(List<EnergyReportResponse> data) {

    final displayData = data;
    final rawValues = displayData.map<double>((e) {
      return selectedChart == 0 ? e.p : e.epi;
    }).toList();


    final maxRaw = rawValues.isEmpty ? 1.0 : rawValues.reduce((a, b) => a > b ? a : b);


    final scaleFactor = maxRaw < 10 ? 1000 : 1;

    final values = rawValues.map((e) => e * scaleFactor).toList();
    final spots = values
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList();

    final max = values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b);
    final min = values.isEmpty ? 0.0 : values.reduce((a, b) => a < b ? a : b);

    final padding = (max - min) * 0.3;
    final maxIndex = values.indexOf(max);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: displayData.length * 40,
        height: 260,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: max == 0 ? 1 : max * 1.2,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(show: false),

            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, _) {
                    final index = value.toInt();
                    if (index >= displayData.length) return SizedBox();

                    final time = displayData[index].time;

                    if (selectedRange == ChartRange.day) {
                      return Text("${time.hour}h",
                          style: TextStyle(fontSize: 10));
                    } else if (selectedRange == ChartRange.month) {
                      return Text("${time.day}",
                          style: TextStyle(fontSize: 10));
                    } else {
                      return Text("${time.month}",
                          style: TextStyle(fontSize: 10));
                    }
                  },
                ),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      (value / scaleFactor).toStringAsFixed(1),
                      style: TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
            ),

            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (spots) {
                  return spots.map((e) {
                    return LineTooltipItem(
                      (e.y / scaleFactor).toStringAsFixed(2),
                      TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 2.5,
                color: selectedChart == 0 ? Colors.orange : Colors.blue,

                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) {
                    if (index == maxIndex) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: selectedChart == 0 ? Colors.orange : Colors.blue,
                      );
                    }
                    return FlDotCirclePainter(
                      radius: 3,
                      color: Colors.blue,
                    );
                  },
                ),

                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= FILTER DATA =================
  List<EnergyReportResponse> applyRange(
      List<EnergyReportResponse> data,
      ChartRange range,
      ) {
    final now = DateTime.now();

    final filtered = data.where((e) {
      final d = e.time;

      switch (range) {
        case ChartRange.day:
          return d.day == now.day &&
              d.month == now.month &&
              d.year == now.year;

        case ChartRange.month:
          return d.month == now.month && d.year == now.year;

        case ChartRange.year:
          return d.year == now.year;

        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) => a.time.compareTo(b.time));
    return filtered;
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnalyticsCubit>().state;
    final data = applyRange(state.data, selectedRange);

    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name ?? "")),
      body: Container(
        color: Color(0xFFF5F7FB),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(12),
              children: [
                buildFilterBar(),
                SizedBox(height: 12),

                buildTabs(),
                SizedBox(height: 12),

                buildHeader(data),
                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: buildChart(data),
                ),

                SizedBox(height: 20),
              ],
            ),

            if (state.isLoading)
              Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}