import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../application/enums/chart_range.dart';
import '../automat_detail_screen.dart';
List filterByRange(
    List data,
    ChartRange range,
    ) {
  final now = DateTime.now();

  final filtered = data.where((e) {
    if (e.updatedAt == null) return false;

    final time = e.updatedAt;

    switch (range) {
      case ChartRange.day:
        return time.isAfter(now.subtract(const Duration(hours: 24)));

      case ChartRange.week:
        return time.isAfter(now.subtract(const Duration(days: 7)));

      case ChartRange.month:
        return time.isAfter(now.subtract(const Duration(days: 30)));
      case ChartRange.quarter:
        return time.isAfter(now.subtract(const Duration(days: 120)));

      case ChartRange.year:
        return time.isAfter(now.subtract(const Duration(days: 365)));

    }
  }).toList();

  filtered.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));

  return filtered;
}
class FullChartScreen extends StatelessWidget {
  final List chartData;
  final ChartRange selectedRange;
  final ChartType chartType;

  const FullChartScreen({
    super.key,
    required this.chartData,
    required this.selectedRange,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    final data = filterByRange(chartData, selectedRange);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        title: const Text("Biểu đồ chi tiết"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _buildChartCard("Công suất (kW)", data, (e) => e.p ?? 0),
          _buildChartCard("Điện năng (kWh)", data, (e) => e.epi ?? 0),
          _buildChartCard("Điện áp (V)", data, (e) => e.ua ?? 0),
          _buildChartCard("Dòng điện (A)", data, (e) => e.ia ?? 0),

        ],
      ),
    );
  }

  /// ===== CARD CHART =====
  Widget _buildChartCard(
      String title,
      List data,
      double Function(dynamic) getY,
      ) {
    if (data.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: const Text("Không có dữ liệu"),
      );
    }
    final maxY = data.isEmpty
        ? 5.0
        : data.map((e) => getY(e)).reduce((a, b) => a > b ? a : b) * 1.2;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 SCROLL NGANG
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: data.isEmpty ? 300 : data.length * 40,

              child: LineChart(
                LineChartData(

                  minX: 0,
                  maxX: (data.length - 1).toDouble(),

                  minY: 0,
                  maxY: maxY,

                  /// GRID đẹp
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY == 0 ? 1 : maxY / 5,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.15),
                        dashArray: [4, 4],
                      );
                    },
                  ),

                  borderData: FlBorderData(show: false),

                  /// ===== AXIS =====
                  titlesData: FlTitlesData(

                    /// Y axis
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),

                    /// X axis
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {

                          final index = value.toInt();
                          if (index >= data.length) return const SizedBox();

                          /// 🔥 show nhiều label hơn
                          final step = (data.length / 8).ceil();

                          if (index % step != 0 &&
                              index != data.length - 1) {
                            return const SizedBox();
                          }

                          final time = DateFormat("dd/MM")
                              .format(data[index].updatedAt);

                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              time,
                              style: const TextStyle(
                                fontSize: 9,
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

                  /// ===== LINE =====
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(data.length, (i) {
                        final y = getY(data[i]);
                        return FlSpot(i.toDouble(), y.toDouble());
                      }),

                      isCurved: true,
                      barWidth: 3,

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00C6A7),
                          Color(0xFF1ABC9C),
                        ],
                      ),

                      dotData: const FlDotData(show: false),

                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF1ABC9C).withOpacity(0.25),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],

                  /// ===== TOOLTIP =====
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.black87,
                      getTooltipItems: (spots) {
                        return spots.map((spot) {
                          final index = spot.x.toInt();
                          final time = DateFormat("dd/MM HH:mm")
                              .format(data[index].updatedAt);

                          return LineTooltipItem(
                            "$time\n${spot.y.toStringAsFixed(2)}",
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}