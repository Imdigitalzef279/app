import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/data/dto/Warranty/response/warranty_response.dart';
import '../../../../../data/repositories/warranty/warranty_repository.dart';

class DeviceInfoScreen extends StatefulWidget {
  final DeviceResponse device;

  const DeviceInfoScreen({super.key, required this.device});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final WarrantyRepository warrantyRepo = WarrantyRepository();
  bool activating = false;
  WarrantyResponse? warranty;
  @override
  void initState() {
    super.initState();
    loadWarranty();
  }

  Future<void> loadWarranty() async {
    final data = await  warrantyRepo.getWarranty(widget.device.id);
    debugPrint("👉 WARRANTY DATA: ${data?.startDate} - ${data?.endDate}");
    if (!mounted) return;

    setState(() {
      warranty = data;
    });
  }

  Future<void> activateWarranty() async {
    debugPrint("👉 CLICK ACTIVATE deviceId: ${widget.device.id}");
    setState(() {
      activating = true;
    });

    final success =
    await warrantyRepo.activateWarranty(widget.device.id);

    if (!mounted) return;

    setState(() {
      activating = false;
    });

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kích hoạt bảo hành thành công")),
      );

      await loadWarranty();

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kích hoạt thất bại")),
      );
    }
  }

  String getWarrantyDuration() {

    if (warranty?.startDate == null || warranty?.endDate == null) {
      return "--";
    }

    try {

      final start = DateTime.parse(warranty!.startDate!);
      final end = DateTime.parse(warranty!.endDate!);

      final months =
          (end.year - start.year) * 12 + (end.month - start.month);

      return "$months tháng";

    } catch (_) {
      return "--";
    }
  }

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

    final device = widget.device;
    final log = device.realtimeLog;

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
              item("Device ID", device.id),
              item("Mã hàng", device.code),
              item("Gateway", device.gatewayNumber),
              item("Loại thiết bị", device.meterType.name),
              item("Trạm điện", device.powerStation.name),
              item("Ngày tạo", formatDate(device.creationTime)),
            ],
          ),

          /// B. THÔNG SỐ ĐIỆN
          section(
            "B. Thông số điện",
            [
              item("Điện áp pha A", log?.ua?.toStringAsFixed(0)),
              item("Dòng pha A", log?.ia?.toStringAsFixed(1)),
              item("Công suất", log?.p?.toStringAsFixed(2)),
              item("Điện năng", log?.epi?.toStringAsFixed(1)),
              item("Tần số", log?.fr?.toStringAsFixed(1)),
            ],
          ),

          /// C. BẢO HÀNH
          section(
            "C. Thông tin bảo hành",
            [

              item("Thời gian bảo hành", getWarrantyDuration()),

              item(
                "Ngày kích hoạt",
                warranty?.startDate != null
                    ? formatDate(warranty!.startDate!)
                    : "--",
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// BUTTON kích hoạt
          // if (warranty == null || warranty!.startDate == null)
            ElevatedButton(
              onPressed: activating ? null : activateWarranty,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5BB8A6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: activating
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text(
                "Kích hoạt bảo hành",
                style: TextStyle(fontSize: 16),
              ),
            ),

        ],
      ),
    );
  }
}