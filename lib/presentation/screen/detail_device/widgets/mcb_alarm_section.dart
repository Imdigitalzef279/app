import 'package:flutter/material.dart';

class McbAlarmSection extends StatelessWidget {
  final String deviceId;

  const McbAlarmSection({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Thông tin cảnh báo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Chưa có cảnh báo (mock)'),
          ],
        ),
      ),
    );
  }
}
