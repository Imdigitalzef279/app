import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:solar_energy/data/repositories/device/device_repository.dart';
import 'package:solar_energy/data/repositories/device/device_repository_impl.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import '../../../../application/enums/load_status.dart';
import '../../Electricity/automat/device_info_screen/device_info_screen.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  bool isScanned = false;
  bool isLoading = false;
  bool isTorchOn = false;

  late final DeviceRepository deviceRepo;
  final MobileScannerController controller = MobileScannerController();

  List<DeviceResponse> deviceList = [];

  @override
  void initState() {
    super.initState();

    try {
      deviceRepo = GetIt.instance<DeviceRepository>();
    } catch (_) {
      deviceRepo = DeviceRepositoryImpl();
    }

    loadDevices();
  }

  /// 🔥 LOAD DEVICE
  Future<void> loadDevices() async {
    setState(() => isLoading = true);

    final result = await deviceRepo.getSolarElectric(21);

    if (result.status == LoadStatus.success && result.data != null) {
      deviceList = result.data!;

      debugPrint("===== DEVICE LIST =====");
      for (var d in deviceList) {
        debugPrint("ID: ${d.id} | SERIAL: ${d.serialNumber}");
      }
      debugPrint("=======================");
    }

    setState(() => isLoading = false);
  }

  /// 🔥 HANDLE SCAN
  Future<void> _onDetect(BarcodeCapture capture) async {
    if (isScanned || isLoading) return;

    final raw = capture.barcodes.first.rawValue;
    debugPrint("👉 QR RAW: $raw");
    if (raw == null || raw.isEmpty) return;

    final serial = raw.trim();
    debugPrint("👉 SERIAL AFTER TRIM: $serial");
    debugPrint("QR RAW: $serial");

    setState(() {
      isScanned = true;
      isLoading = true;
    });

    try {
      final device = deviceList.where(
            (e) => e.serialNumber == serial,
      ).isNotEmpty
          ? deviceList.firstWhere((e) => e.serialNumber == serial)
          : null;
      debugPrint("👉 FOUND DEVICE: ${device?.toJson()}");
      if (device == null) {
        showError("Không tìm thấy thiết bị");
        return;
      }

      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeviceInfoScreen(device: device),
        ),
      );

      /// 👉 reset lại để scan tiếp
      setState(() {
        isScanned = false;
      });
    } catch (e) {
      showError("Lỗi xử lý QR");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 📷 CAMERA
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),

          /// 🔲 KHUNG SCAN
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                  width: 2,
                ),
              ),
            ),
          ),

          /// 🔥 LINE SCAN
          const Positioned.fill(child: _ScanLineWhite()),

          /// 🔙 HEADER (safe)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Quét",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📌 TEXT
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                "Quét mã QR trên thiết bị hoặc hướng dẫn sử dụng",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),

          /// 🔘 BUTTON NHẬP TAY
          Positioned(
            bottom: 110,
            left: 40,
            right: 40,
            child: GestureDetector(
              onTap: () {
                debugPrint("👉 manual input");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Center(
                  child: Text(
                    "Không có mã QR và thêm thủ công",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          /// 📂 + 🔦
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomIcon(Icons.image, "Thư viện", () {
                  debugPrint("👉 open gallery");
                }),
                _bottomIcon(
                  isTorchOn ? Icons.flash_off : Icons.flash_on,
                  "Đèn pin",
                      () {
                    controller.toggleTorch();
                    setState(() => isTorchOn = !isTorchOn);
                  },
                ),
              ],
            ),
          ),

          /// ⏳ LOADING
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  /// UI icon dưới
  Widget _bottomIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          )
        ],
      ),
    );
  }

  void showError(String message) {
    setState(() {
      isLoading = false;
      isScanned = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

/// 🔥 LINE ANIMATION
class _ScanLineWhite extends StatefulWidget {
  const _ScanLineWhite();

  @override
  State<_ScanLineWhite> createState() => _ScanLineWhiteState();
}

class _ScanLineWhiteState extends State<_ScanLineWhite>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Align(
          alignment: Alignment(0, controller.value * 2 - 1),
          child: Container(
            width: 260,
            height: 2,
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}