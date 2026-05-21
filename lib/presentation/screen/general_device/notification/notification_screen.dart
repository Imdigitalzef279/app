import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/data/dto/alarm/response/alarm_response.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/dto/notification_item/notification_item.dart';
import '../../../../data/repositories/alarm/alarm_repository.dart';
import '../../../../di.dart';
import '../alarm/bloc/alarm_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      AlarmCubit(
          AlarmRepository(getIt<ApiClient>())
      )
        ..loadAlarms(),
        child: Builder(
            builder: (context) {

              WidgetsBinding.instance
                  .addPostFrameCallback((_) {

                clearNotificationBadge();
              });

              return Scaffold(
                appBar: AppBar(
                  title: const Text("Thông báo"),
                ),

                body: BlocBuilder<AlarmCubit, List<AlarmResponse>>(

                  builder: (context, alarms) {
                    return FutureBuilder<List<NotificationItem>>(

                      future: loadAllNotifications(alarms),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "ERROR: ${snapshot.error}",
                            ),
                          );
                        }

                        final list = snapshot.data ?? [];

                        if (list.isEmpty) {
                          return const Center(
                            child: Text("Không có thông báo"),
                          );
                        }

                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return _itemNew(list[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            }
        )
    );
  }
  Future<void> clearNotificationBadge() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "local_notifications",
      jsonEncode([]),
    );
  }
Future<List<NotificationItem>>
loadAllNotifications(List<AlarmResponse> alarms) async {

  final prefs =
  await SharedPreferences.getInstance();

  final data =
  prefs.getString("local_notifications");

  List<NotificationItem> localList = [];

  if (data != null) {

    final decoded = jsonDecode(data) as List;

    localList = decoded.map(
          (e) => NotificationItem(
        title: e["title"],
        message: e["message"],
        time: DateTime.parse(e["time"]),
        isAlert: e["isAlert"] ?? true,
      ),
    ).toList();
  }

  // final alarms =
  //     context.read<AlarmCubit>().state;

  final apiList = alarms.map(
        (e) => NotificationItem(
      title: e.deviceName,
      message: e.reason.isNotEmpty
          ? e.reason
          : e.message,
      time: e.time,
      isAlert: e.status == 1,
    ),
  ).toList();

  final all = [
    ...localList,
    ...apiList,
  ];

  all.sort((a, b) =>
      b.time.compareTo(a.time));

  return all;
}
  // Future<List<NotificationItem>> loadLocalNotifications() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   final data = prefs.getString("local_notifications");
  //   if (data == null) return [];
  //
  //   final list = jsonDecode(data) as List;
  //
  //   return list.map((e) =>
  //       NotificationItem(
  //         title: e["title"],
  //         message: e["message"],
  //         time: DateTime.parse(e["time"]),
  //         isAlert: e["isAlert"],
  //       )).toList();
  // }

  /// ITEM UI
  Widget _itemNew(NotificationItem item) {
    final isAlert = item.isAlert;

    IconData icon;
    Color color;
    Color bg;

    if (isAlert) {
      icon = Icons.warning_amber_rounded;
      color = Colors.red;
      bg = Colors.red.shade50;
    } else {
      icon = Icons.lightbulb_outline;
      color = Colors.blue;
      bg = Colors.blue.shade50;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(item.message),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// DOT
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}