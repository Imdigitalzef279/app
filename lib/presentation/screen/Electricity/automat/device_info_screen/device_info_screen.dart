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

  bool get isActivated => warranty?.startDate != null;

  @override
  void initState() {
    super.initState();
    loadWarranty();
  }

  Future<void> loadWarranty() async {
    final data = await warrantyRepo.getWarranty(widget.device.id);

    debugPrint("👉 WARRANTY: ${data?.startDate} - ${data?.endDate}");

    if (!mounted) return;

    setState(() {
      warranty = data;
    });
  }

  Future<void> activateWarranty() async {
    setState(() => activating = true);

    final success =
    await warrantyRepo.activateWarranty(widget.device.id);

    if (!mounted) return;

    setState(() => activating = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? "Kích hoạt bảo hành thành công"
              : "Kích hoạt thất bại",
        ),
      ),
    );

    if (success) {
      await loadWarranty();
    }
  }

  ///  TÍNH THỜI GIAN BẢO HÀNH
  String getWarrantyDuration() {
    if (warranty?.endDate == null) return "--";

    try {
      final now = DateTime.now();
      final end = DateTime.parse(warranty!.endDate!);

      final diff = end.difference(now);

      if (diff.isNegative) return "Hết hạn";

      final days = diff.inDays;

      if (days > 30) {
        final months = (days / 30).floor();
        return "$months tháng";
      }

      return "$days ngày";
    } catch (e) {
      debugPrint("❌ DATE ERROR: $e");
      return "--";
    }
  }

  /// 🔥 FORMAT DATE
  String formatDate(String? time) {
    if (time == null || time.isEmpty) return "--";

    try {
      final date = DateTime.parse(time);
      return DateFormat("dd/MM/yyyy HH:mm").format(date);
    } catch (_) {
      return time;
    }
  }

  Widget item(String title, dynamic value) {
    final text =
    (value == null || value.toString().isEmpty) ? "--" : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Color(0xFF5BB8A6)),
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
            offset: const Offset(0, 4),
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
          section("A. Thông tin sản phẩm", [
            item("Tên sản phẩm", device.name),
            item("Mã hàng", device.name),

            /// 🔥 FIX CHUẨN SERIAL
            item("Serial Number", device.serialNumber),

            item("Hãng Sản Xuất", warranty?.provider),
            item("Xuất Xứ", device.creator),
          ]),

          /// B. THÔNG SỐ
          section("B. Thông số thiết bị", [
            item("Dòng định mức", log?.p?.toStringAsFixed(0)),
            item("Điện áp", log?.u0?.toStringAsFixed(1)),
          ]),

          /// C. BẢO HÀNH
          section("C. Thông tin bảo hành", [
            item("Thời gian bảo hành", getWarrantyDuration()),
            item(
              "Ngày kích hoạt lần đầu",
              formatDate(warranty?.startDate),
            ),
          ]),

          const SizedBox(height: 10),

          /// BUTTON
          ElevatedButton(
            onPressed:
            (activating || isActivated) ? null : activateWarranty,
            style: ElevatedButton.styleFrom(
              backgroundColor: isActivated
                  ? Colors.green.shade300
                  : const Color(0xFF5BB8A6),
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
                : Text(
              isActivated
                  ? "Đã kích hoạt bảo hành"
                  : "Kích hoạt bảo hành",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}