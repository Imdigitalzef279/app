import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/setting_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/switch_log/switch_log_screen.dart';
import '../../../../application/enums/load_status.dart';
import '../../../../application/switch_log/switch_log_cubit.dart';
import '../../../../data/repositories/switch_log/switch_log_repository.dart';
import '../../../../di.dart';
import '../../../widgets/password_dialog.dart';
import '../../device/bloc/device_cubit.dart';
import '../../device/widget/content_dialog.dart';
import 'automat_detail_screen.dart';

class AutomatListScreen extends StatelessWidget {
  final int powerStationId;

  const AutomatListScreen({
    super.key,
    required this.powerStationId,
  });

  // widget MCB
  Widget buildMCBCard(BuildContext context, device) {
    final isOn = device.status == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),

        // ===== ICON =====
        leading: CircleAvatar(
          radius: 22,
          backgroundColor:
          isOn ? Colors.green.withOpacity(0.15)
              : Colors.grey.withOpacity(0.15),
          child: Icon(
            Icons.electrical_services,
            color: isOn ? Colors.green : Colors.grey,
            size: 20,
          ),
        ),

        // ===== TITLE =====
        title: Text(
          device.name?.isNotEmpty == true
              ? device.name!
              : device.code ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),

        // ===== SUBTITLE =====
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "Gateway: ${device.gatewayNumber ?? ''}",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),

        // ===== ACTIONS =====
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // 🔥 quan trọng
          children: [

            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 18,
              icon: const Icon(Icons.history, size: 20),
              color: Colors.black54,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => SwitchLogCubit(
                        getIt<SwitchLogRepository>(), // nếu bạn dùng DI
                      )..fetchLogs(device.gatewayNumber ?? ''),
                      child: SwitchLogScreen(
                        gatewaySn: device.gatewayNumber ?? '',
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(width: 6),

            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 18,
              icon: const Icon(Icons.settings, size: 20),
              color: Colors.black54,
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

            const SizedBox(width: 6),

            Transform.scale(
              scale: 0.8,
              child: Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: isOn,
                activeColor: Colors.green,
                onChanged: (value) async {
                  final password = await showPasswordDialog(context);
                  if (password == null) return;

                  await context.read<DeviceCubit>().togglePower(
                    device,
                    password: password,
                  );
                },
              ),
            ),
          ],
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value:
                    context.read<DeviceCubit>(),
                  ),
                  BlocProvider(
                    create: (_) =>
                        AtomatDetailCubit(),
                  ),
                ],
                child:
                AutomatDetailScreen(device: device),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= GROUP THEO PHA =================
  Widget buildPhaseGroup(
      BuildContext context, String title, List devices) {
    if (devices.isEmpty) return const SizedBox();

    return ExpansionTile(
      key: PageStorageKey(title),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: devices
          .map((device) =>
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: buildMCBCard(context, device),
          ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục"),
      ),
      body: BlocBuilder<DeviceCubit, DeviceState>(
        builder: (context, state) {
          if (state.resultDevices.status ==
              LoadStatus.loading) {
            return const Center(
                child: CircularProgressIndicator());
          }

          final devices =
              state.resultDevices.data ?? [];

          if (devices.isEmpty) {
            return const Center(
                child: Text("Không có thiết bị"));
          }

          // Chia theo level
          final level3 = <dynamic>[];
          final level2 = <dynamic>[];
          final level1 = <dynamic>[];

          for (int i = 0; i < devices.length; i++) {
            if (i % 3 == 0) {
              level3.add(devices[i]);
            } else if (i % 3 == 1) {
              level2.add(devices[i]);
            } else {
              level1.add(devices[i]);
            }
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [

              buildPhaseGroup(
                  context, "Xưởng 1", level3),

              buildPhaseGroup(
                  context, "Xưởng 2", level2),

              buildPhaseGroup(
                  context, "Xưởng 3", level1),
            ],
          );
        },
      ),
    );
  }
}