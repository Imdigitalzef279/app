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
                  elevation: 0,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    "Thông báo",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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

    await prefs.setInt(
      "notification_badge_count",
      0,
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
          title: e.status == 1
              ? "Cảnh báo"
              : "Phân tích",
          message:
          e.reason.isNotEmpty
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
    Color mainColor;
    Color lightColor;

    if (isAlert) {
      icon = Icons.warning_rounded;
      mainColor = const Color(0xFFE53935);
      lightColor = const Color(0xFFFFEBEE);
    } else {
      icon = Icons.tips_and_updates_rounded;
      mainColor = const Color(0xFF1E88E5);
      lightColor = const Color(0xFFE3F2FD);
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: mainColor,
            width: 5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ICON
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: lightColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: mainColor,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            /// CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  /// TITLE + TIME
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatTime(item.time),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// MESSAGE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Text(
                      //   "Thiết bị: ${item.title}",
                      //   style: TextStyle(
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w700,
                      //     color: isAlert
                      //         ? Colors.red.shade700
                      //         : Colors.blue.shade700,
                      //   ),
                      // ),

                      // const SizedBox(height: 4),

                      Text(
                        item.message,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatTime(DateTime time) {
    return "${time.day.toString().padLeft(2, '0')}/"
        "${time.month.toString().padLeft(2, '0')}/"
        "${time.year} "
        "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }
}