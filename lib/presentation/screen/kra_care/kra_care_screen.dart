import 'package:flutter/material.dart';
import 'kra_care_activity_tab.dart';
import 'kra_care_settings_tab.dart';

class KraCareScreen extends StatefulWidget {
  const KraCareScreen({super.key});

  @override
  State<KraCareScreen> createState() => _KraCareScreenState();
}

class _KraCareScreenState extends State<KraCareScreen> {
  int currentIndex = 0;

  final tabs = [
    const KraCareActivityTab(),
    const Center(child: Text("Controls")),
    const KraCareSettingsTab(),
    const Center(child: Text("Settings")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [

          ///  HEADER CAMERA
          Stack(
            children: [

              /// IMAGE
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/factory.png",
                  fit: BoxFit.cover,
                ),
              ),

              /// overlay gradient
              Container(
                height: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),

              /// top bar
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.photo_library,
                        color: Colors.white),
                  ],
                ),
              ),

              /// title
              const Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Living Room",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Fall Detected | 1/28 4:13 PM",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// bottom controls
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.videocam, color: Colors.white),
                    Icon(Icons.camera_alt, color: Colors.white),
                    Icon(Icons.volume_up, color: Colors.white),
                    Icon(Icons.fullscreen, color: Colors.white),
                  ],
                ),
              ),

              /// mic button
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic),
                  ),
                ),
              ),
            ],
          ),

          /// 🔥 CONTENT
          Expanded(
            child: tabs[currentIndex],
          ),
        ],
      ),
    );
  }
}