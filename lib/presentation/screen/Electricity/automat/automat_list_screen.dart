import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/setting_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/switch_log/switch_log_screen.dart';
import '../../../../application/enums/load_status.dart';
import '../../../widgets/password_dialog.dart';
import '../../device/bloc/device_cubit.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';
import 'automat_detail_screen.dart';

class AutomatListScreen extends StatefulWidget {
  final int powerStationId;

  const AutomatListScreen({
    super.key,
    required this.powerStationId,
  });

  @override
  State<AutomatListScreen> createState() => _AutomatListScreenState();
}

class _AutomatListScreenState extends State<AutomatListScreen> {

  @override
  void initState() {
    super.initState();

    context.read<DeviceCubit>().getAllDevices(
      powerStationId: widget.powerStationId,
    );
  }

  /// ================= DEVICE CARD =================
  Widget buildDeviceCard(BuildContext context, device) {

    final isOn = device.status == 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          )
        ],
      ),

      child: Row(
        children: [

          /// TYPE
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isOn
                  ? Colors.green.withOpacity(0.15)
                  : Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              device.level == 1 ? "CB TỔNG" : "CB",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isOn ? Colors.green : Colors.grey,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  device.name?.isNotEmpty == true
                      ? device.name
                      : device.code ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isOn ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      isOn ? "Online" : "Offline",
                      style: TextStyle(
                        fontSize: 12,
                        color: isOn
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  "Gateway: ${device.gatewayNumber ?? ""}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
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

              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isOn,
                  activeColor: Colors.green,
                  onChanged: (value) async {

                    final password =
                    await showPasswordDialog(context);

                    if (password == null) return;

                    await context.read<DeviceCubit>()
                        .togglePower(
                      device,
                      password: password,
                    );
                  },
                ),
              ),

            ],
          )

        ],
      ),
    );
  }

  /// ================= TREE DEVICE =================
  Widget buildTree(List devices, int parentId) {

    final children =
    devices.where((d) => d.parentId == parentId).toList();

    if (children.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        children: children.map((device) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              buildDeviceCard(context, device),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: buildTree(devices, device.id),
              )

            ],
          );

        }).toList(),
      ),
    );
  }

  /// ================= BUILD =================
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),

      appBar: AppBar(
        title: const Text("Danh mục"),
      ),

      body: BlocBuilder<DeviceCubit, DeviceState>(
        builder: (context, state) {

          if (state.resultDevices.status == LoadStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final devices = state.resultDevices.data ?? [];

          if (devices.isEmpty) {
            return const Center(
              child: Text("Không có thiết bị"),
            );
          }

          /// GROUP CABINET
          Map<String, List> cabinetMap = {};

          for (var device in devices) {

            final cabinet =
                device.powerStation?.name ?? "Chưa xác định";

            cabinetMap.putIfAbsent(cabinet, () => []);
            cabinetMap[cabinet]!.add(device);
          }

          return ListView(
            padding: const EdgeInsets.all(16),

            children: cabinetMap.entries.map((cabinetEntry) {

              final cabinetDevices = cabinetEntry.value;

              final rootDevices =
              cabinetDevices
                  .where((d) => d.parentId == 0)
                  .toList();

              final total = cabinetDevices.length;

              final online =
                  cabinetDevices
                      .where((d) => d.status == 1)
                      .length;

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),

                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.15),
                      Colors.green.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),

                    child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,

                  title: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        cabinetEntry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [

                          Text(
                            "$total thiết bị",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Container(
                            width: 8,
                            height: 8,
                            decoration:
                            const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "$online Online",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),

                        ],
                      )

                    ],
                  ),

                  children: [

                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children:
                        rootDevices.map((rootDevice) {

                          return Column(
                            children: [

                              buildDeviceCard(
                                  context, rootDevice),

                              buildTree(
                                  cabinetDevices,
                                  rootDevice.id),

                            ],
                          );

                        }).toList(),
                      ),
                    )

                  ],
                ),
                  ),
              );

            }).toList(),
          );
        },
      ),
    );
  }
}