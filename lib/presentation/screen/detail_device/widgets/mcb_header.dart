import 'package:flutter/material.dart';
import '../../../../domain/mcb/entities/mcb_entity.dart';

class McbHeader extends StatelessWidget {
  final McbEntity mcb;
  const McbHeader({super.key, required this.mcb});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.electrical_services, size: 40),
        title: Text('Thiết bị ${mcb.id}'),
        subtitle: Text('Dòng định mức: ${mcb.ratedCurrent} A'),
        trailing: Chip(
          label: Text(mcb.isOnline ? 'Online' : 'Offline'),
          backgroundColor: mcb.isOnline ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
