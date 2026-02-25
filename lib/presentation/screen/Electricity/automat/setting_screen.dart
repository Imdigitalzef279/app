import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../device/bloc/device_cubit.dart';

class SettingScreen extends StatelessWidget {
  final dynamic device;

  const SettingScreen({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? device.code ?? "Cài đặt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ===== THÔNG TIN THIẾT BỊ =====
            Card(
              child: ListTile(
                leading: const Icon(Icons.electrical_services),
                title: Text(device.name ?? device.code ?? ''),
                subtitle: Text("Gateway: ${device.gatewayNumber ?? ''}"),
              ),
            ),

            const SizedBox(height: 20),

            // ===== ĐỔI TÊN =====
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Đổi tên thiết bị"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => _RenameDialog(device: device),
                );
              },
            ),

            const SizedBox(height: 12),

            // ===== RESET =====
            ElevatedButton.icon(
              icon: const Icon(Icons.restart_alt),
              label: const Text("Reset thiết bị"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                // TODO: gọi API reset nếu có
              },
            ),
          ],
        ),
      ),
    );
  }
}
class _RenameDialog extends StatefulWidget {
  final dynamic device;

  const _RenameDialog({required this.device});

  @override
  State<_RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<_RenameDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    controller =
        TextEditingController(text: widget.device.name ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Đổi tên thiết bị"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: "Tên mới",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy"),
        ),
        ElevatedButton(
          onPressed: () async {
            // TODO: gọi update API nếu có
            Navigator.pop(context);
          },
          child: const Text("Lưu"),
        ),
      ],
    );
  }
}