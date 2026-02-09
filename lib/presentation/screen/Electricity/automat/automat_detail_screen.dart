import 'package:flutter/material.dart';
import 'widget/model/automat_ui_model.dart';

class AutomatDetailScreen extends StatelessWidget {
  final AutomatUIModel automat;

  const AutomatDetailScreen({
    super.key,
    required this.automat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${automat.name} | ${automat.type}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ===== LOAD CARD =====
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tải hiện tại',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: automat.loadPercent / 100,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${automat.current.toStringAsFixed(1)} A / '
                        '${automat.ratedCurrent.toStringAsFixed(0)} A',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// ===== 3 PHASE TABLE =====
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông số 3 pha',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Table(
                    border: TableBorder.all(color: Colors.grey.shade300),
                    children: [
                      _row('', 'A', 'B', 'C'),
                      _row(
                        'U',
                        '${automat.voltage.a} V',
                        '${automat.voltage.b} V',
                        '${automat.voltage.c} V',
                      ),
                      _row(
                        'I',
                        '${automat.currentPhase.a} A',
                        '${automat.currentPhase.b} A',
                        '${automat.currentPhase.c} A',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// ===== STATUS =====
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.circle, color: _statusColor()),
                  const SizedBox(width: 8),
                  Text(
                    _statusText(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== TABLE ROW HELPER =====
  TableRow _row(String label, String a, String b, String c) {
    return TableRow(
      children: [
        _cell(label, bold: true),
        _cell(a),
        _cell(b),
        _cell(c),
      ],
    );
  }

  Widget _cell(String text, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }

  // ===== STATUS =====
  Color _statusColor() {
    switch (automat.status) {
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

  String _statusText() {
    switch (automat.status) {
      case AutomatStatus.normal:
        return 'Đang hoạt động';
      case AutomatStatus.warning:
        return 'Cảnh báo';
      case AutomatStatus.error:
        return 'Lỗi';
      case AutomatStatus.off:
        return 'Ngắt';
    }
  }
}
