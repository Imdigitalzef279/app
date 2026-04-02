import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import 'analytics_detail_screen.dart';
import 'bloc/analytics_cubit.dart';

class AnalyticsOverviewScreen extends StatelessWidget {
  final List<DeviceResponse> devices;

  const AnalyticsOverviewScreen({super.key, required this.devices});

  Map<int, List<DeviceResponse>> groupByProject(List<DeviceResponse> devices) {
    final Map<int, List<DeviceResponse>> map = {};

    for (var d in devices) {
      final key = d.projectId ?? 0;
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(d);
    }

    return map;
  }

  Widget buildProjectItem(BuildContext context, int projectId, List<DeviceResponse> deviceList) {
    final onlineCount = deviceList.where((e) => e.status == 1).length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Colors.green.shade100,
            Colors.green.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        childrenPadding: const EdgeInsets.only(bottom: 12),
        iconColor: Colors.green,
        collapsedIconColor: Colors.green,

        title: Row(
          children: [
            const Icon(Icons.folder, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              deviceList.isNotEmpty &&
                  deviceList.first.powerStation.name.isNotEmpty
                  ? deviceList.first.powerStation.name
                  : "Chưa xác định",
            )
          ],
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "${deviceList.length} thiết bị • $onlineCount Online",
            style: TextStyle(
              fontSize: 12,
              color: Colors.green.shade800,
            ),
          ),
        ),

        children: deviceList.map((d) {
          return buildDeviceItem(context, d);
        }).toList(),
      ),
    );
  }
  Widget buildDeviceItem(BuildContext context, DeviceResponse d) {
    final isOnline = d.status == 1;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AnalyticsCubit(GetIt.I<ApiClient>()),
                child: AnalyticsDetailScreen(device: d),
              ),
            ),
          );
        },
        child: Row(
          children: [
            // icon trạng thái + nền
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isOnline
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.electrical_services,
                color: isOnline ? Colors.green : Colors.red,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            // text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.name ?? d.code ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isOnline ? "Online" : "Offline",
                    style: TextStyle(
                      color: isOnline ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // arrow
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final groupedDevices = groupByProject(devices);

    return Scaffold(
      appBar: AppBar(title: const Text("Phân tích")),
      backgroundColor: const Color(0xFFF3F6F4), // xanh xám nhẹ
      body: ListView(
        children: groupedDevices.entries.map((entry) {
          return buildProjectItem(context, entry.key, entry.value);
        }).toList(),
      ),
    );
  }
}