import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';

class DeviceInfoScreen extends StatelessWidget {
  final DeviceResponse device;

  const DeviceInfoScreen({super.key, required this.device});

  Widget item(String title, dynamic value) {

    final text = (value == null || value.toString().isEmpty)
        ? "--"
        : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [

          const Icon(
            Icons.circle,
            size: 8,
            color: Color(0xFF5BB8A6),
          ),

          const SizedBox(width: 10),

          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0,4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF2C3E50),
            ),
          ),

          const SizedBox(height: 10),

          ...children
        ],
      ),
    );
  }
  String formatDate(String time) {
    try {
      final date = DateTime.parse(time);
      return DateFormat("dd/MM/yyyy HH:mm").format(date);
    } catch (_) {
      return time;
    }
  }
  @override
  Widget build(BuildContext context) {
    final log = device.realtimeLog;
    String status = log?.rlySta == 1 ? "Đang đóng" : "Đang cắt";
    return Scaffold(

      backgroundColor: const Color(0xFFF1F8F6),

      appBar: AppBar(
        title: const Text("Thông tin thiết bị"),
        backgroundColor: const Color(0xFF5BB8A6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// A. THÔNG TIN SẢN PHẨM
          section(
            "A. Thông tin sản phẩm",
            [
              item("Tên sản phẩm", device.name),
              item("Device ID", ''),
              item("Mã hàng", device.code),
              item("Gateway", device.gatewayNumber),
              item("Loại thiết bị", device.meterType.name),
              item("Trạm điện", device.powerStation.name),
              item("Ngày tạo", formatDate(device.creationTime)),

            ],
          ),

          /// B. THÔNG SỐ
          section(
            "B. Thông số điện",
            [
              item("Điện áp pha A", log?.ua?.toStringAsFixed(0)),
              item("Dòng pha A", log?.ia?.toStringAsFixed(1)),
              item("Công suất", log?.p?.toStringAsFixed(2) ?? "--"),
              item("Điện năng", log?.epi?.toStringAsFixed(1) ?? "--"),
              item("Tần số", log?.fr?.toStringAsFixed(1) ?? "--"),
            ],
          ),

          /// C. BẢO HÀNH
          section(
            "C. Thông tin bảo hành",
            [

              item("Thời gian bảo hành", "30 tháng"),
              item("Ngày kích hoạt", "01/01/2026"),
            ],
          ),

          const SizedBox(height: 10),

          /// BUTTON
          ElevatedButton(
            onPressed: () {},

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5BB8A6),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Kích hoạt bảo hành",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}