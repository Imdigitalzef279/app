import 'package:flutter/material.dart';

class McbChartSection extends StatelessWidget {
  final String title;
  final bool isLoading;
  final String? emptyMessage;

  const McbChartSection({
    super.key,
    required this.title,
    this.isLoading = true,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: Center(
                child: isLoading
                    ? const Text(
                  'Biểu đồ – chờ dữ liệu từ BE',
                  style: TextStyle(color: Colors.grey),
                )
                    : Text(
                  emptyMessage ?? 'Không có dữ liệu',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
