import 'package:fl_chart/fl_chart.dart';
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

        context.read<AutomatChartCubit>().loadChart(
          widget.device.code!,
          range,
        );
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
  List<double> buildAvgLine(
      List<BreakerChartResponse> data,
      double? Function(BreakerChartResponse) getY,
      ) {
    final values = data.map((e) => getY(e) ?? 0).toList();

    if (values.isEmpty) return [];

    final avg = values.reduce((a, b) => a + b) / values.length;

    return List.generate(values.length, (_) => avg);
  }
  // ================= CHART =================
  Widget buildMainChart(List<BreakerChartResponse> data) {
    switch (selectedChart) {
      case 0:
        final displayData = data.length > 12 ? data.sublist(data.length - 12) : data;

        final values = displayData.map((e) => e.ia ?? 0).toList();

        final avg = values.isEmpty
            ? 0.0
            : values.reduce((a, b) => a + b) / values.length;

        final latest = values.isNotEmpty ? values.last : 0;
        final maxValue = values.isEmpty
            ? 0.0
            : values.reduce((a, b) => a > b ? a : b);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dòng điện (Ia)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "${latest.toStringAsFixed(2)} A",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 6),

            // 🔥 LEGEND
            Row(
              children: [
                _legendDot(Colors.red, "Hiện tại"),
                SizedBox(width: 12),
                _legendDot(Colors.blue, "Trung bình"),
              ],
            ),

            SizedBox(height: 10),

            // 🔥 CHART
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: maxValue * 1.5,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.black87,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final value = rod.toY;
                        return BarTooltipItem(
                          value.toStringAsFixed(2),
                          TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= displayData.length) return SizedBox();

                          final time = displayData[index].updatedAt;
                          return Text(
                            "${time?.hour ?? ''}h",
                            style: TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: List.generate(displayData.length, (index) {
                    final v = values[index];
                    final isLatest = index == values.length - 1;

                    return BarChartGroupData(
                      x: index,
                      barsSpace: 4,
                      barRods: [
                        // 🔴 CURRENT
                        BarChartRodData(
                          toY: v,
                          width: 6,
                          color: isLatest ? Colors.redAccent : Colors.red,
                        ),

                        // 🔵 AVG
                        BarChartRodData(
                          toY: avg,
                          width: 6,
                          color: Colors.blue.withOpacity(0.4),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        );

      case 1:
        return Column(
          children: [
            _buildProChart(data, (e) => e.ua, "Ua", Colors.green),
            _buildProChart(data, (e) => e.ub, "Ub", Colors.purple),
            _buildProChart(data, (e) => e.uc, "Uc", Colors.teal),
          ],
        );

      case 2:
        return Column(
          children: [
            _buildProChart(data, (e) => e.temp1, "Temp1", Colors.red),
            _buildProChart(data, (e) => e.temp2, "Temp2", Colors.orange),
          ],
        );

      default:
        return _buildProChart(data, (e) => e.lg, "Rò điện", Colors.black);
    }
  }
  Widget _legendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
  Widget _buildProChart(
      List<BreakerChartResponse> data,
      double? Function(BreakerChartResponse) getY,
      String label,
      Color color,
      ) {
    final displayData = data.length > 12 ? data.sublist(data.length - 12) : data;

    final values = displayData.map((e) => getY(e) ?? 0).toList();

    final avg = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    final latest = values.isNotEmpty ? values.last : 0;
    final maxValue = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              latest.toStringAsFixed(2),
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        SizedBox(height: 6),

        Row(
          children: [
            _legendDot(color, "Hiện tại"),
            SizedBox(width: 12),
            _legendDot(color.withOpacity(0.4), "TB"),
          ],
        ),

        SizedBox(height: 10),

        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              minY: 0,
              maxY: maxValue * 2.5,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),

              barGroups: List.generate(displayData.length, (index) {
                final v = values[index];

                return BarChartGroupData(
                  x: index,
                  barsSpace: 4,
                  barRods: [
                    BarChartRodData(toY: v, width: 6, color: color),
                    BarChartRodData(
                      toY: avg,
                      width: 6,
                      color: color.withOpacity(0.4),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildCompareBarChart({
    required List<BreakerChartResponse> data,
    required double? Function(BreakerChartResponse) getY,
    required Color color,
  }) {
    final values = data.map((e) => getY(e) ?? 0).toList();

    final avg = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    return BarChart(
      BarChartData(
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),

        barGroups: List.generate(values.length, (index) {
          final v = values[index];

          return BarChartGroupData(
            x: index,
            barsSpace: 4,
            barRods: [
              // Current
              BarChartRodData(
                toY: v,
                borderRadius: BorderRadius.zero,
                width: 6,
                color: color,
              ),

              // Avg
              BarChartRodData(
                toY: avg,
                width: 6,
                color: color.withOpacity(0.4),
              ),
            ],
          );
        }),
      ),
    );
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

    return Column(
      children: [
        _buildSectionCard("Dòng điện", data, [
          ("Ia", (e) => e.ia),
          ("Ib", (e) => e.ib),
          ("Ic", (e) => e.ic),
        ]),

        _buildSectionCard("Điện áp", data, [
          ("Ua", (e) => e.ua),
          ("Ub", (e) => e.ub),
          ("Uc", (e) => e.uc),
        ]),

        _buildSectionCard("Nhiệt độ", data, [
          ("Temp1", (e) => e.temp1),
          ("Temp2", (e) => e.temp2),
          ("Temp3", (e) => e.temp3),
          ("Temp4", (e) => e.temp4),
        ]),

        _buildSectionCard("Năng lượng", data, [
          ("Rò điện", (e) => e.lg),
          ("Công suất", (e) => e.p),
          ("Điện năng", (e) => e.epi),
        ]),
      ],
    );
  }
  Widget _buildSectionCard(
      String title,
      List<BreakerChartResponse> data,
      List<(String, double? Function(BreakerChartResponse))> fields,
      ) {
    final last = data.last;

    double avg(List<double?> values) {
      final valid = values.whereType<double>().toList();
      if (valid.isEmpty) return 0;
      return valid.reduce((a, b) => a + b) / valid.length;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 TITLE
          Row(
            children: [
              Icon(Icons.analytics, size: 18, color: Colors.green),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // HEADER
          Row(
            children: const [
              Expanded(flex: 2, child: Text("Thông số")),
              Expanded(child: Text("Hiện tại", textAlign: TextAlign.center)),
              Expanded(child: Text("TB", textAlign: TextAlign.center)),
            ],
          ),

          const Divider(),

          // DATA
          ...fields.map((f) {
            final current = f.$2(last);
            final avgValue = avg(data.map((e) => f.$2(e)).toList());

            return _rowComparePro(f.$1, current, avgValue);
          }),
        ],
      ),
    );
  }
  Widget _rowComparePro(String label, double? current, double avg) {
    final currentValue = current ?? 0;
    final isHigher = currentValue > avg;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isHigher ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: isHigher ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  currentValue.toStringAsFixed(2),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHigher ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              avg.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
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
  Widget _rowCompare(String label, double? current, double avg) {
    final currentValue = (current ?? 0);
    final currentText = currentValue.toStringAsFixed(2);
    final avgText = avg.toStringAsFixed(2);

    final isHigher = currentValue > avg;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),

          Expanded(
            child: Text(
              currentText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isHigher ? Colors.red : Colors.green,
              ),
            ),
          ),

          Expanded(
            child: Text(
              avgText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
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
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(12),
              children: [
                buildFilterBar(),
                const SizedBox(height: 12),

                buildChartSelector(),
                const SizedBox(height: 12),

                buildChartCard(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: buildMainChart(data),
                  ),
                ),

                buildStatsGrid(data),
              ],
            ),

            if (rawData.isEmpty)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}