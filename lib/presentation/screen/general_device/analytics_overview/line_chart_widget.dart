import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';

class LineChartWidget extends StatelessWidget {
  final List<BreakerChartResponse> data;
  final List<LineConfig> lines;
  final String title;

  const LineChartWidget({
    super.key,
    required this.data,
    required this.lines,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),

          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: false),

                lineBarsData: lines.map((line) {
                  return LineChartBarData(
                    isCurved: true,
                    color: line.color,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    spots: data.asMap().entries.map((e) {
                      return FlSpot(
                        e.key.toDouble(),
                        line.getY(e.value) ?? 0,
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineConfig {
  final double? Function(BreakerChartResponse) getY;
  final Color color;

  LineConfig({
    required this.getY,
    required this.color,
  });
}