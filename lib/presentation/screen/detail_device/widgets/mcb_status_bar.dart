import 'package:flutter/material.dart';
import '../../../../domain/mcb/entities/mcb_entity.dart';

class McbStatusBar extends StatelessWidget {
  final McbEntity mcb;
  const McbStatusBar({super.key, required this.mcb});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.circle,
                color: mcb.isOnline ? Colors.green : Colors.red, size: 12),
            const SizedBox(width: 8),
            Text(mcb.isOnline ? 'Đang hoạt động' : 'Ngoại tuyến'),
          ],
        ),
      ),
    );
  }
}
