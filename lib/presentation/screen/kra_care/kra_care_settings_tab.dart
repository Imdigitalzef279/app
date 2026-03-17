import 'package:flutter/material.dart';

class KraCareSettingsTab extends StatelessWidget {
  const KraCareSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// TITLE
          const Text(
            "Device Information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 16),

          /// CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                )
              ],
            ),
            child: Column(
              children: [

                item("Product Name",
                    "60G Radar Fall/Get Up/Presence Sensor"),

                divider(),

                item("Short Name", "R5-60G-KNX"),

                divider(),

                item("Model/Configuration",
                    "CTL-SEN-R5/6203"),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}