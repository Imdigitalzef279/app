import 'package:flutter/material.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';

class DeviceInfoScreen extends StatelessWidget {
  final DeviceResponse device;

  const DeviceInfoScreen({super.key, required this.device});

  Widget item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin thiết bị"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            item("Tên sản phẩm", device.name),
            item("Mã sản phẩm", device.code),
            item("Serial", device.serialNumber),
            item("Gateway", device.gatewayNumber),
            item("Loại công tơ", device.meterType.name ?? ""),
            item("Trạm điện", device.powerStation.name ?? ""),
            item("Ngày tạo", device.creationTime),

          ],
        ),
      ),
    );
  }
}