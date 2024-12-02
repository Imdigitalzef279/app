import 'package:flutter/material.dart';
import 'package:solar_energy/application/constants/app_color.dart';

class DescripWidget extends StatelessWidget {
  const DescripWidget(
      {super.key,
      required this.color,
      required this.name,
      required this.selection,
      required this.callback});

  final Color color;
  final String name;
  final bool selection;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:
                selection ? AppColors.greyFB : const Color(0xFFFFFFFF)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: color),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
