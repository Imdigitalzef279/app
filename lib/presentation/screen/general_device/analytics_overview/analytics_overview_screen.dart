import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import 'analytics_detail_screen.dart';

class AnalyticsOverviewScreen extends StatelessWidget {
  final List<DeviceResponse> devices;

  const AnalyticsOverviewScreen({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phân tích")),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final d = devices[index];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(d.name ?? d.code ?? ""),
              subtitle: Text(d.status == 1 ? "Online" : "Offline"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => AutomatChartCubit(),
                      child: AnalyticsDetailScreen(device: d),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}