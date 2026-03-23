import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../application/utils/device_avatar_storage.dart';
import '../../../widgets/password_dialog.dart';
import '../../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import '../../Electricity/automat/automat_detail_screen.dart';
import '../../Electricity/automat/bloc/atomat_detail_cubit.dart';
import '../../Electricity/automat/setting_screen.dart';
import '../../Electricity/automat/switch_log/switch_log_screen.dart';
import '../bloc/device_cubit.dart';

class DeviceCardWidget extends StatelessWidget {
  final dynamic device;

  const DeviceCardWidget({
    super.key,
    required this.device,
  });

  /// ================= PICK IMAGE =================
  Future<String?> pickDeviceImage() async {
    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return null;

    return file.path;
  }

  /// ================= RENAME =================
  Future<void> showRenameDialog(BuildContext context) async {
    final controller = TextEditingController(text: device.name);

    final newName = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Đổi tên thiết bị"),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Huỷ"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Lưu"),
            ),
          ],
        );
      },
    );

    if (newName != null && newName.isNotEmpty) {
      context.read<DeviceCubit>().updateDeviceName(
        device.id,
        newName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DeviceCubit>().state;

    final currentSwitch =
        state.breakerLogs[device.code]?.rlySta ??
            device.realtimeLog?.rlySta ??
            0;

    final isOnline = device.status == 1;
    final isOn = currentSwitch == 1;
    final isSwitching =
    state.switchingDevices.containsKey(device.id);

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 🔥 QUAN TRỌNG
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<DeviceCubit>(),
                ),
                BlocProvider(create: (_) => AtomatDetailCubit()),
                BlocProvider(create: (_) => AutomatChartCubit()),
              ],
              child: AutomatDetailScreen(device: device),
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFF8FAFB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 6,
              spreadRadius: -2,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            /// IMAGE
            GestureDetector(
              onTap: () async {
                final image = await pickDeviceImage();

                if (image != null) {
                  await DeviceAvatarStorage.saveAvatar(
                    device.id,
                    image,
                  );

                  context.read<DeviceCubit>().updateDeviceAvatar(
                    device.id,
                    image,
                  );
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F2EF),
                  borderRadius: BorderRadius.circular(10),
                  image: device.avatar.isNotEmpty
                      ? DecorationImage(
                    image: FileImage(File(device.avatar)),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: device.avatar.isEmpty
                    ? const Icon(
                  Icons.add,
                  size: 20,
                  color: Color(0xFF6BB6A6),
                )
                    : null,
              ),
            ),

            const SizedBox(width: 14),

            /// INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          device.name.isNotEmpty
                              ? device.name
                              : device.code,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      /// ⭐ FAVORITE
                      GestureDetector(
                        onTap: () {
                          context
                              .read<DeviceCubit>()
                              .toggleFavorite(device.id);
                        },
                        child: Icon(
                          device.isFavorite
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),

                      const SizedBox(width: 4),

                      /// ✏️ EDIT
                      GestureDetector(
                        onTap: () {
                          showRenameDialog(context);
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isOn ? "Đóng" : "Cắt",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: isOn ? Colors.green : Colors.red,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {}, // 🔥 CHẶN TAP LAN
                        child: Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: isOn,
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFF43A047),
                            inactiveTrackColor: const Color(0xFFE53935),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onChanged: isOnline
                                ? (value) async {
                              final password = await showPasswordDialog(context);
                              if (password == null) return;

                              await context.read<DeviceCubit>().togglePower(
                                device,
                                password: password,
                              );
                            }
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Gateway: ${device.gatewayNumber ?? ""}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7A86),
                    ),
                  ),
                ],
              ),
            ),

            /// ACTIONS
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.history, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SwitchLogScreen(
                          gatewaySn: device.gatewayNumber ?? '',
                          breakerSn: device.code ?? '',
                        ),
                      ),
                    );
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.settings, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<DeviceCubit>(),
                          child: SettingScreen(device: device),
                        ),
                      ),
                    );
                  },
                ),

                Column(
                  children: [
                    Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: isOn,
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xFF43A047),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFFE53935),
                        trackOutlineColor:
                        WidgetStateProperty.all(Colors.transparent),
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                        onChanged: isOnline
                            ? (value) async {
                          final password =
                          await showPasswordDialog(context);
                          if (password == null) return;

                          await context
                              .read<DeviceCubit>()
                              .togglePower(device,
                              password: password);
                        }
                            : null,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      isSwitching
                          ? "Đang chuyển"
                          : isOn
                          ? "Đang đóng"
                          : "Đang cắt",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSwitching
                            ? Colors.orange
                            : isOn
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}