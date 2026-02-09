import 'package:flutter/material.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/widget/model/automat_ui_model.dart';

class AutomatStatusPanel extends StatelessWidget {
  final AutomatUIModel automat;

  const AutomatStatusPanel({
    super.key,
    required this.automat,
  });

  String getStatusText() {
    switch (automat.status) {
      case AutomatStatus.error:
        return 'TRIP';
      case AutomatStatus.warning:
        return 'Cảnh báo';
      case AutomatStatus.normal:
      default:
        return 'Đang hoạt động';
    }
  }

  Color getStatusColor() {
    switch (automat.status) {
      case AutomatStatus.error:
        return Colors.red;
      case AutomatStatus.warning:
        return Colors.orange;
      case AutomatStatus.normal:
      default:
        return Colors.green;
    }
  }

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
              'Trạng thái thiết bị',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  getStatusText(),
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
