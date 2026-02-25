import 'package:flutter/material.dart';
import 'package:solar_energy/domain/mcb/entities/mcb_entity.dart';

class AutomatFullDetailScreen extends StatelessWidget {
  final McbEntity mcb;

  const AutomatFullDetailScreen({
    super.key,
    required this.mcb,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đầy đủ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _chartCard(
              title: 'Phase current',
              unit: 'A',
              legends: const ['Ia', 'Ib', 'Ic'],
            ),
            const SizedBox(height: 16),

            _chartCard(
              title: 'Phase voltage',
              unit: 'V',
              legends: const ['Ua', 'Ub', 'Uc'],
            ),
            const SizedBox(height: 16),

            _chartCard(
              title: 'Leakage current',
              unit: 'mA',
              legends: const ['Lg'],
            ),
            const SizedBox(height: 16),

            _chartCard(
              title: 'Temperature',
              unit: '°C',
              legends: const ['Temp1', 'Temp2', 'Temp3'],
            ),
            const SizedBox(height: 16),

            _moreParamsButton(),
          ],
        ),
      ),
    );
  }

  // ================= CHART CARD =================

  Widget _chartCard({
    required String title,
    required String unit,
    required List<String> legends,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: legends.map(_legendDot).toList(),
                )
              ],
            ),
            const SizedBox(height: 8),

            Text(
              unit,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),

            const SizedBox(height: 12),

            // Fake chart placeholder
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Biểu đồ (sẽ gắn dữ liệu)',
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 8),

            _timeAxis(),
          ],
        ),
      ),
    );
  }

  Widget _legendDot(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _timeAxis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('00:00', style: TextStyle(fontSize: 10)),
        Text('06:00', style: TextStyle(fontSize: 10)),
        Text('12:00', style: TextStyle(fontSize: 10)),
        Text('18:00', style: TextStyle(fontSize: 10)),
        Text('23:45', style: TextStyle(fontSize: 10)),
      ],
    );
  }

  // ================= FOOTER =================

  Widget _moreParamsButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Nhấn vào đây để xem thêm tham số',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
