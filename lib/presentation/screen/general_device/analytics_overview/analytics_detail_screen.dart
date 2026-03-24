import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/enums/chart_range.dart';
import '../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import 'line_chart_widget.dart';

class AnalyticsDetailScreen extends StatefulWidget {
  final DeviceResponse device;
  const AnalyticsDetailScreen({super.key, required this.device});

  @override
  State<AnalyticsDetailScreen> createState() =>
      _AnalyticsDetailScreenState();
}

class _AnalyticsDetailScreenState extends State<AnalyticsDetailScreen> {

  int selectedChart = 0;
  ChartRange selectedRange = ChartRange.day;

  @override
  void initState() {
    super.initState();
    context.read<AutomatChartCubit>().loadChart(
      widget.device.code!,
      ChartRange.day,
    );
  }

  // ================= FILTER =================
  Widget buildFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _filterButton("Ngày", ChartRange.day),
        const SizedBox(width: 8),
        _filterButton("Tháng", ChartRange.month),
        const SizedBox(width: 8),
        _filterButton("Năm", ChartRange.year),
      ],
    );
  }

  Widget _filterButton(String text, ChartRange range) {
    final isActive = selectedRange == range;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRange = range;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ================= TAB CHART =================
  Widget buildChartSelector() {
    final tabs = ["Dòng điện", "Điện áp", "Nhiệt độ", "Rò điện"];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isActive = selectedChart == index;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedChart = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ================= FILTER DATA =================
  List<BreakerChartResponse> applyRange(
      List<BreakerChartResponse> data,
      ChartRange range,
      ) {
    final now = DateTime.now();

    List<BreakerChartResponse> filtered;

    switch (range) {
      case ChartRange.day:
        filtered = data.where((e) {
          final d = e.updatedAt;
          return d != null &&
              d.year == now.year &&
              d.month == now.month &&
              d.day == now.day;
        }).toList();
        break;
      case ChartRange.week:
        filtered = data.where((e) {
          final d = e.updatedAt;
          if (d == null) return false;

          final nowWeekday = now.weekday; // thứ hiện tại
          final startOfWeek = now.subtract(Duration(days: nowWeekday - 1));
          final endOfWeek = startOfWeek.add(const Duration(days: 6));

          return d.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
              d.isBefore(endOfWeek.add(const Duration(days: 1)));
        }).toList();
        break;
      case ChartRange.month:
        filtered = data.where((e) {
          final d = e.updatedAt;
          return d != null &&
              d.year == now.year &&
              d.month == now.month;
        }).toList();
        break;

      case ChartRange.year:
        filtered = data.where((e) {
          final d = e.updatedAt;
          return d != null &&
              d.year == now.year;
        }).toList();
        break;
      case ChartRange.quarter:
        filtered = data.where((e) {
          final d = e.updatedAt;
          if (d == null) return false;

          final quarter = ((now.month - 1) ~/ 3) + 1;
          final itemQuarter = ((d.month - 1) ~/ 3) + 1;

          return d.year == now.year && itemQuarter == quarter;
        }).toList();
        break;
    }

    // 🔥 SORT theo thời gian
    filtered.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));

    return filtered;
  }

  // ================= CHART =================
  Widget buildMainChart(List<BreakerChartResponse> data) {
    switch (selectedChart) {
      case 0:
        return LineChartWidget(
          title: "Dòng điện",
          data: data,
          lines: [
            LineConfig(getY: (e) => e.ia ?? 0, color: Colors.red),
            LineConfig(getY: (e) => e.ib ?? 0, color: Colors.blue),
            LineConfig(getY: (e) => e.ic ?? 0, color: Colors.orange),
          ],
        );

      case 1:
        return LineChartWidget(
          title: "Điện áp",
          data: data,
          lines: [
            LineConfig(getY: (e) => e.ua ?? 0, color: Colors.green),
            LineConfig(getY: (e) => e.ub ?? 0, color: Colors.purple),
            LineConfig(getY: (e) => e.uc ?? 0, color: Colors.teal),
          ],
        );

      case 2:
        return LineChartWidget(
          title: "Nhiệt độ",
          data: data,
          lines: [
            LineConfig(getY: (e) => e.temp1 ?? 0, color: Colors.red),
            LineConfig(getY: (e) => e.temp2 ?? 0, color: Colors.orange),
          ],
        );

      default:
        return LineChartWidget(
          title: "Rò điện",
          data: data,
          lines: [
            LineConfig(getY: (e) => e.lg ?? 0, color: Colors.black),
          ],
        );
    }
  }

  Widget buildChartCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }

  // ================= STATS =================
  Widget buildStatsGrid(List<BreakerChartResponse> data) {
    if (data.isEmpty) return const SizedBox();

    final last = data.last;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _row("Ia", last.ia),
          _row("Ib", last.ib),
          _row("Ic", last.ic),
          const Divider(),

          _row("Ua", last.ua),
          _row("Ub", last.ub),
          _row("Uc", last.uc),
          const Divider(),

          _row("Temp1", last.temp1),
          _row("Temp2", last.temp2),
          _row("Temp3", last.temp3),
          _row("Temp4", last.temp4),
          const Divider(),

          _row("Rò điện", last.lg),
          _row("Công suất", last.p),
          _row("Điện năng", last.epi),
        ],
      ),
    );
  }

  Widget _row(String label, double? value) {
    final v = (value ?? 0).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            v,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final rawData = context.watch<AutomatChartCubit>().state;

    final data = applyRange(rawData, selectedRange);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name ?? ""),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE8F5E9),
              Colors.white,
            ],
          ),
        ),
        child: rawData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          padding: const EdgeInsets.all(12),
          children: [
            buildFilterBar(),
            const SizedBox(height: 12),

            buildChartSelector(),
            const SizedBox(height: 12),

            buildChartCard(
              child: buildMainChart(data),
            ),

            buildStatsGrid(data),
          ],
        ),
      ),
    );
  }
}