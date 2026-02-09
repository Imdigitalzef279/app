import 'package:flutter/material.dart';
import 'widget/model/automat_ui_model.dart';
import 'automat_detail_screen.dart';

class AutomatListScreen extends StatelessWidget {
  const AutomatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AutomatUIModel> automats = [
      AutomatUIModel(
        id: '1',
        name: 'ACB Tổng MSB1',
        type: 'ACB',
        ratedCurrent: 3000,
        current: 1200,
        loadPercent: 40,
        voltage: const PhaseValue(a: 231, b: 229, c: 230),
        currentPhase: const PhaseValue(a: 62, b: 64, c: 58),
        status: AutomatStatus.normal,
      ),
      AutomatUIModel(
        id: '2',
        name: 'MCCB Nhánh 1',
        type: 'MCCB',
        ratedCurrent: 800,
        current: 300,
        loadPercent: 35,
        voltage: const PhaseValue(a: 230, b: 230, c: 229),
        currentPhase: const PhaseValue(a: 18, b: 20, c: 17),
        status: AutomatStatus.warning,
      ),
      AutomatUIModel(
        id: '3',
        name: 'MCCB Nhánh 2',
        type: 'MCCB',
        ratedCurrent: 800,
        current: 300,
        loadPercent: 35,
        voltage: const PhaseValue(a: 230, b: 230, c: 229),
        currentPhase: const PhaseValue(a: 18, b: 20, c: 17),
        status: AutomatStatus.off,
      ),
      AutomatUIModel(
        id: '4',
        name: 'MCCB Nhánh 3',
        type: 'MCCB',
        ratedCurrent: 800,
        current: 300,
        loadPercent: 35,
        voltage: const PhaseValue(a: 230, b: 230, c: 229),
        currentPhase: const PhaseValue(a: 18, b: 20, c: 17),
        status: AutomatStatus.normal,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Thiết bị'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: automats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final a = automats[index];

          return Card(
            child: ListTile(
              leading: Icon(
                Icons.electrical_services,
                color: _statusColor(a.status),
              ),
              title: Text(a.name),
              subtitle: Text(
                '${a.type} • ${a.current.toStringAsFixed(1)}/${a.ratedCurrent} A • ${a.loadPercent.toStringAsFixed(1)}%',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AutomatDetailScreen(automat: a),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  Color _statusColor(AutomatStatus status) {
    switch (status) {
      case AutomatStatus.normal:
        return Colors.green;
      case AutomatStatus.warning:
        return Colors.orange;
      case AutomatStatus.error:
        return Colors.red;
      case AutomatStatus.off:
        return Colors.grey;
    }
  }
}
