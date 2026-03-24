import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceManagementScreen extends StatelessWidget {
  const DeviceManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý thiết bị")),
      body: const Center(child: Text("Device Management")),
    );
  }
}