import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/enums/chart_range.dart';
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
  @override
  void initState() {
    super.initState();

    /// 🔥 load data từ cubit (API nằm trong cubit rồi)
    context.read<AutomatChartCubit>().loadChart(
      widget.device.code!,
      ChartRange.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<AutomatChartCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name ?? ""),
      ),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(12),
        children: [
          /// ⚡ DÒNG ĐIỆN
          LineChartWidget(
            title: "Dòng điện (Ia, Ib, Ic)",
            data: data,
            lines: [
              LineConfig(getY: (e) => e.ia, color: Colors.red),
              LineConfig(getY: (e) => e.ib, color: Colors.blue),
              LineConfig(getY: (e) => e.ic, color: Colors.orange),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔌 ĐIỆN ÁP
          LineChartWidget(
            title: "Điện áp (Ua, Ub, Uc)",
            data: data,
            lines: [
              LineConfig(getY: (e) => e.ua, color: Colors.green),
              LineConfig(getY: (e) => e.ub, color: Colors.purple),
              LineConfig(getY: (e) => e.uc, color: Colors.teal),
            ],
          ),

          const SizedBox(height: 12),

          /// 🌡 NHIỆT ĐỘ
          LineChartWidget(
            title: "Nhiệt độ",
            data: data,
            lines: [
              LineConfig(getY: (e) => e.temp1, color: Colors.red),
              LineConfig(getY: (e) => e.temp2, color: Colors.orange),
            ],
          ),

          const SizedBox(height: 12),

          /// ⚠️ RÒ ĐIỆN
          LineChartWidget(
            title: "Rò điện",
            data: data,
            lines: [
              LineConfig(getY: (e) => e.lg, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}