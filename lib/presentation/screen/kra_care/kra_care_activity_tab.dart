import 'package:flutter/material.dart';

class KraCareActivityTab extends StatelessWidget {
  const KraCareActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// DATE BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Today", style: TextStyle(fontSize: 16)),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),

          const SizedBox(height: 16),

          ///  TIMELINE
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text("Timeline"),
          ),

          const SizedBox(height: 16),
          activityGrid(),

          SizedBox(height: 16),
          ///  FALL ITEM
          fallItem("assets/images/fall_demo.png", "4:14 PM"),
          fallItem("assets/images/fall_demo.png", "11:12 AM"),
        ],
      ),
    );
  }

  Widget fallItem(String image, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: const [
                Text(
                  "Fall Detected",
                  style: TextStyle(
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),

          Text(time),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call,
                size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget activityGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        activityBox("Enter", Icons.login),
        activityBox("Exit", Icons.logout),
        activityBox("Sitting", Icons.event_seat),
        activityBox("Standing", Icons.accessibility),
        activityBox("Lying", Icons.hotel),
        activityBox("Fall", Icons.warning, isAlert: true),
      ],
    );
  }

  Widget activityBox(String title, IconData icon, {bool isAlert = false}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAlert ? Colors.red.shade300 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 28,
              color: isAlert ? Colors.white : Colors.black),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isAlert ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "12:21:49",
            style: TextStyle(
              fontSize: 11,
              color: isAlert ? Colors.white70 : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}