import 'package:flutter/material.dart';

class FallItem extends StatelessWidget {
  final String time;
  final String image;

  const FallItem({
    super.key,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          /// image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 10),

          /// text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Fall Detected",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(time),
              ],
            ),
          ),

          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}