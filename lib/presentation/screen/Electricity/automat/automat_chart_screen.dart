import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/enums/chart_range.dart';
import '../../../../data/dto/atomat/atomat_chart/breaker_chart_response.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';

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

  ChartRange _selectedRange = ChartRange.month;

  @override
  void initState() {
    super.initState();

    context.read<AutomatChartCubit>()
        .loadChart(widget.meterCode, _selectedRange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biểu đồ MCB")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AutomatChartCubit, List<BreakerChartResponse>>(
          builder: (context, logs) {

            if (logs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: [

                _section("Phase Current (A)", [
                  _line(logs, (e) => (e.ia ?? 0).toDouble(), Colors.blue),
                  _line(logs, (e) => (e.ib ?? 0).toDouble(), Colors.green),
                  _line(logs, (e) => (e.ic ?? 0).toDouble(), Colors.red),
                ], maxY: 50),

                const SizedBox(height: 30),

                _section("Phase Voltage (V)", [
                  _line(logs, (e) => (e.ua ?? 0).toDouble(), Colors.orange),
                  _line(logs, (e) => (e.ub ?? 0).toDouble(), Colors.purple),
                  _line(logs, (e) => (e.uc ?? 0).toDouble(), Colors.teal),
                ], maxY: 260),

                const SizedBox(height: 30),

                _section("Leakage Current (mA)", [
                  _line(logs, (e) => (e.lg ?? 0).toDouble(), Colors.red),
                ], maxY: 100),

                const SizedBox(height: 30),

                _section("Temperature (°C)", [
                  _line(logs, (e) => (e.temp1 ?? 0).toDouble(), Colors.blue),
                  _line(logs, (e) => (e.temp2 ?? 0).toDouble(), Colors.green),
                  _line(logs, (e) => (e.temp3 ?? 0).toDouble(), Colors.red),
                ], maxY: 120),
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

              minX: 0,
              maxX: lines.first.spots.length.toDouble() - 1,

              minY: 0,
              maxY: maxY,

              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),

              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),

              lineBarsData: lines,
            ),
          ),
        )
      ],
    );
  }

  LineChartBarData _line(
      List<BreakerChartResponse> data,
      double Function(BreakerChartResponse) selector,
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