import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/device/response/device_response.dart';
import 'analytics_detail_screen.dart';
import 'bloc/analytics_cubit.dart';

class AnalyticsOverviewScreen extends StatefulWidget {
  final List<DeviceResponse> devices;

  const AnalyticsOverviewScreen({super.key, required this.devices});

  @override
  State<AnalyticsOverviewScreen> createState() =>
      _AnalyticsOverviewScreenState();
}

class _AnalyticsOverviewScreenState extends State<AnalyticsOverviewScreen> {

  late List<MapEntry<int, List<DeviceResponse>>> items;

  @override
  void initState() {
    super.initState();
    final grouped = groupByProject(widget.devices);
    items = grouped.entries.toList();
  }

  Map<int, List<DeviceResponse>> groupByProject(List<DeviceResponse> devices) {
    final Map<int, List<DeviceResponse>> map = {};

    for (var d in devices) {
      final key = d.projectId ?? 0;
      map.putIfAbsent(key, () => []);
      map[key]!.add(d);
    }

    return map;
  }

  // ================= PROJECT ITEM =================
  Widget buildProjectItem(
      BuildContext context,
      int projectId,
      List<DeviceResponse> deviceList,
      int projectIndex,
      ) {

    final onlineCount = deviceList.where((e) => e.status == 1).length;

    return Container(
      key: ValueKey("project_$projectId"),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.green.shade100, Colors.green.shade50],
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        title: Row(
          children: [
            const Icon(Icons.folder, color: Colors.green),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                deviceList.isNotEmpty
                    ? deviceList.first.powerStation.name
                    : "Chưa xác định",
              ),
            ),

            //  kéo project
            ReorderableDragStartListener(
              index: projectIndex,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),

        subtitle: Text(
          "${deviceList.length} thiết bị • $onlineCount Online",
          style: TextStyle(color: Colors.green.shade800, fontSize: 12),
        ),

        // ================= DEVICE LIST =================
        children: [
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;

                final item = deviceList.removeAt(oldIndex);
                deviceList.insert(newIndex, item);
              });
            },
            children: [
              for (int i = 0; i < deviceList.length; i++)
                buildDeviceItem(context, deviceList[i], i),
            ],
          )
        ],
      ),
    );
  }

  // ================= DEVICE ITEM =================
  Widget buildDeviceItem(BuildContext context, DeviceResponse d, int index) {
    final isOnline = d.status == 1;

    return Container(
      key: ValueKey(d.id),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [

          //  kéo device
          ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_indicator),
          ),

          const SizedBox(width: 8),

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

          Expanded(
            child: InkWell(
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
          ),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phân tích")),
      backgroundColor: const Color(0xFFF3F6F4),

      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;

            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        children: [
          for (int i = 0; i < items.length; i++)
            buildProjectItem(
              context,
              items[i].key,
              items[i].value,
              i,
            )
        ],
      ),
    );
  }
}