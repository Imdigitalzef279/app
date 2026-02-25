import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/meter_realtime/meter_realtime_cubit.dart';
import '../../../../data/dto/atomat/atomat_log_response.dart';

class AutomatChartScreen extends StatefulWidget {
  final String meterCode;

  const AutomatChartScreen({
    super.key,
    required this.meterCode,
  });

  @override
  State<AutomatChartScreen> createState() => _AutomatChartScreenState();
}

class _AutomatChartScreenState extends State<AutomatChartScreen> {

  @override
  void initState() {
    super.initState();
    print("📌 MeterCode gửi lên: ${widget.meterCode}");
    context.read<MeterRealtimeCubit>().connect(widget.meterCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biểu đồ MCB")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MeterRealtimeCubit, List<AtomatLogResponse>>(
          builder: (context, logs) {

            if (logs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: [

                _section("Phase Current (A)",
                    [
                      _line(logs, (e) => e.ia, Colors.blue),
                      _line(logs, (e) => e.ib, Colors.green),
                      _line(logs, (e) => e.ic, Colors.red),
                    ],
                    maxY: 50),

                const SizedBox(height: 30),

                _section("Phase Voltage (V)",
                    [
                      _line(logs, (e) => e.ua, Colors.orange),
                      _line(logs, (e) => e.ub, Colors.purple),
                      _line(logs, (e) => e.uc, Colors.teal),
                    ],
                    maxY: 260),

                const SizedBox(height: 30),

                _section("Leakage Current (mA)",
                    [
                      _line(logs, (e) => e.i0, Colors.red),
                    ],
                    maxY: 100),

                const SizedBox(height: 30),

                _section("Temperature (°C)",
                    [
                      _line(logs, (e) => e.temp1, Colors.blue),
                      _line(logs, (e) => e.temp2, Colors.green),
                      _line(logs, (e) => e.temp3, Colors.red),
                    ],
                    maxY: 120),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _section(String title, List<LineChartBarData> lines,
      {required double maxY}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY,
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: lines,
            ),
          ),
        ),
      ],
    );
  }

  LineChartBarData _line(
      List<AtomatLogResponse> data,
      double Function(AtomatLogResponse) selector,
      Color color,
      ) {
    return LineChartBarData(
      isCurved: true,
      color: color,
      barWidth: 2,
      spots: data.asMap().entries.map((entry) {
        return FlSpot(
          entry.key.toDouble(),
          selector(entry.value),
        );
      }).toList(),
      dotData: FlDotData(show: false),
    );
  }
}