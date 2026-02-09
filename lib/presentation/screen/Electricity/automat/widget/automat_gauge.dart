import 'package:flutter/material.dart';

class AutomatGauge extends StatelessWidget {
  final double current;
  final double rated;

  const AutomatGauge({
    super.key,
    required this.current,
    required this.rated,
  });

  @override
  Widget build(BuildContext context) {
    final double percent =
    ((current / rated).clamp(0.0, 1.0) as double);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tải hiện tại',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),
            Text(
              '${current.toStringAsFixed(1)} A / ${rated.toStringAsFixed(0)} A',
            ),
          ],
        ),
      ),
    );
  }
}
