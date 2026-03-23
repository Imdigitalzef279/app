import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/data/dto/alarm/response/alarm_response.dart';
import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/repositories/alarm/alarm_repository.dart';
import '../../../../di.dart';
import '../alarm/bloc/alarm_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlarmCubit(
          AlarmRepository(getIt<ApiClient>())
      )..loadAlarms(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Thông báo"),
        ),
        body: BlocBuilder<AlarmCubit, List<AlarmResponse>>(
          builder: (context, alarms) {
            if (alarms.isEmpty) {
              return const Center(
                child: Text("Không có thông báo"),
              );
            }

            return ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return _item(alarm);
              },
            );
          },
        ),
      ),
    );
  }

  /// ITEM UI
  Widget _item(AlarmResponse alarm) {
    final isActive = alarm.status == 1;

    IconData icon;
    Color color;

    if (alarm.message.toLowerCase().contains("mất kết nối")) {
      icon = Icons.flash_on;
      color = Colors.orange;
    } else if (alarm.message.toLowerCase().contains("quá tải")) {
      icon = Icons.local_fire_department;
      color = Colors.red;
    } else {
      icon = Icons.check_circle;
      color = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.red.shade50 : Colors.green.shade50,
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
                  alarm.deviceName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(alarm.message),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// STATUS DOT
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? Colors.red : Colors.green,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}