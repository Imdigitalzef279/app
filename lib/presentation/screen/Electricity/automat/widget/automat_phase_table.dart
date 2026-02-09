import 'package:flutter/material.dart';

class AutomatPhaseTable extends StatelessWidget {
  const AutomatPhaseTable({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Thông số 3 pha',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              children: [
                TableRow(
                  children: [
                    const SizedBox(),
                    const Text('A', textAlign: TextAlign.center),
                    const Text('B', textAlign: TextAlign.center),
                    const Text('C', textAlign: TextAlign.center),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('U'),
                    const Text('231 V', textAlign: TextAlign.center),
                    const Text('229 V', textAlign: TextAlign.center),
                    const Text('230 V', textAlign: TextAlign.center),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('I'),
                    const Text('62 A', textAlign: TextAlign.center),
                    const Text('64 A', textAlign: TextAlign.center),
                    const Text('58 A', textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
