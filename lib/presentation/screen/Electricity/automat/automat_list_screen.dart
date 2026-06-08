import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/setting_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/switch_log/switch_log_screen.dart';
import '../../../../application/enums/load_status.dart';
import '../../../../application/utils/device_avatar_storage.dart';
import '../../../widgets/password_dialog.dart';
import '../../device/bloc/device_cubit.dart';
import '../../device/device_card/device_card_widget.dart';
import 'automat_chart/bloc/automat_chart_cubit.dart';
import 'automat_detail_screen.dart';
import 'meter_detail/bloc/meter_chart_cubit.dart';
import 'meter_detail/meter_detail_screen.dart';


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
  Map<String, bool> expandedCabinets = {};
  String username = "";
  @override
  void initState() {
    super.initState();
    loadUsername();
    final cubit = context.read<DeviceCubit>();

    if (widget.powerStationId == 261) {

      cubit.getAllDevicesByStations([
        261,
        262,
      ]).then((_) {

        final devices =
            cubit.state.resultDevices.data ?? [];

        print("========= ALL DEVICES =========");

        for (var d in devices) {
          print(
              "ID=${d.id}"
                  " | NAME=${d.name}"
                  " | CODE=${d.code}"
                  " | PARENT=${d.parentId}"
                  " | LEVEL=${d.level}"
                  " | METER_TYPE_ID=${d.meterTypeId}"
                  " | POWER_STATION=${d.powerStation.name}"
          );
        }

        for (var d in devices) {
          if (d.code.isNotEmpty) {
            cubit.loadBreakerLog(d.code);
          }
        }
      });

    } else {

      cubit.getAllDevices(
        powerStationId: widget.powerStationId,
      ).then((_) {

        final devices =
            cubit.state.resultDevices.data ?? [];

        for (var d in devices) {
          if (d.code.isNotEmpty) {
            cubit.loadBreakerLog(d.code);
          }
        }
      });
    }
  }
  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsername =
        prefs.getString("username") ?? "";

    print("USERNAME DEBUG: $savedUsername");

    setState(() {
      username = savedUsername;
    });
  }
  Future<void> showRenameDialog(BuildContext context, device) async {

    final controller =
    TextEditingController(text: device.name);

    final newName = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:  Text("device.rename".tr()),

          content: TextField(
            controller: controller,
          ),

          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text("Huỷ".tr()),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child:  Text("Lưu".tr()),
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
  /// ================= DEVICE CARD =================
  Widget buildDeviceCard(BuildContext context, device) {
    final isFake = (device.id ?? 0) < 0;
    final isMeter =
        device.meterTypeId == 2;
    print(
        "DEVICE=${device.name}"
            " | meterTypeId=${device.meterTypeId}"
            " | isMeter=$isMeter"
    );
    final state = context.watch<DeviceCubit>().state;
    final log = state.breakerLogs[device.code];
    final isGatewayOnline = log != null &&
        ["online", "1", "connected"]
            .contains((log.state ?? "").toLowerCase());
    final deviceCubit = context.watch<DeviceCubit>();
    final realStatus = deviceCubit.getRealStatus(device, log);
    final isOn = realStatus == 1;
    final isMaintenance = realStatus == 2;
    final isOffline = !isGatewayOnline;
    ///  Maintenance

    final isSwitching =
    state.switchingDevices.containsKey(device.id);
    final countdown = state.switchCountdowns[device.id] ?? 0;
    return InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [

                  /// dùng lại DeviceCubit
                  BlocProvider.value(
                    value: context.read<DeviceCubit>(),
                  ),

                  /// cubit detail
                  BlocProvider(
                    create: (_) => AtomatDetailCubit(),
                  ),

                  /// cubit chart
                  BlocProvider(
                    create: (_) => AutomatChartCubit(),
                  ),

                  BlocProvider(
                    create: (_) => MeterChartCubit(),
                  ),

                ],
                child: isMeter
                    ? MeterDetailScreen(device: device)
                    : AutomatDetailScreen(device: device),
              ),
            ),
          );
        },

        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(0xFFF8FAFB),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
              borderRadius: BorderRadius.circular(20),

            boxShadow: [

              /// shadow dưới (đổ bóng)
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 18,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),

              /// highlight trên (tạo hiệu ứng nổi)
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
          /// TYPE
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {

                final image = await pickDeviceImage(device.id);

                print("IMAGE PATH: $image");

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
            )
          ),

          SizedBox(width: 14),

          /// INFO
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 TEXT FULL WIDTH
                    Text(
                      device.name.isNotEmpty
                          ? device.name
                          : device.code,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isGatewayOnline
                            ? const Color(0xFF6BB6A6)
                            : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      isGatewayOnline
                          ? "Gateway Online"
                          : "Gateway Offline",
                      style: TextStyle(
                        fontSize: 12,
                        color: isGatewayOnline
                            ? const Color(0xFF6BB6A6)
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context.read<DeviceCubit>().toggleFavorite(device.id);
                      },
                      child: Icon(
                        device.isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 4),

                    GestureDetector(
                      onTap: () {
                        showRenameDialog(context, device);
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                Text(
                  "Gateway: ${device.gatewayNumber ?? ""}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: const Color(0xFF6B7A86),
                  ),
                ),

              ],
            ),
          ),


          SizedBox(
            width: 80,
            child: isMeter
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.electric_meter,
                  size: 28,
                  color: Color(0xFF1ABC9C),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Meter",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF1ABC9C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                /// ICON ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
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
                      child: const Icon(Icons.history, size: 18),
                    ),

                    const SizedBox(width: 10),

                    GestureDetector(
                      onTap: () {
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
                      child: const Icon(Icons.settings, size: 18),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// SWITCH
                SizedBox(
                  height: 50,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: isSwitching
                          ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                          : Switch(
                        value: isOn,

                        activeColor: Colors.white,

                        activeTrackColor: const Color(0xFF50CD5A),

                        inactiveThumbColor: Colors.white,

                        inactiveTrackColor: Colors.grey.shade300,

                        onChanged: (!isFake &&
                            !isSwitching &&
                            countdown == 0 &&
                            !isOffline)
                            ? (value) async {

                          final password =
                          await showPasswordDialog(context);

                          if (password == null) return;

                          await context
                              .read<DeviceCubit>()
                              .togglePower(
                            device,
                            password: password,
                          );

                        }
                            : null,
                      ),
                  ),
                  ),
                ),

                const SizedBox(height: 4),

                /// STATUS TEXT
                Text(
                  isSwitching
                      ? "..."
                      : countdown > 0
                      ? "${countdown}s"
                      : isOffline
                      ? "Off"
                      : isMaintenance
                      ? "Maint"
                      : isOn
                      ? "Đóng"
                      : "Cắt",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSwitching || countdown > 0
                        ? Colors.orange
                        : isOffline
                        ? Colors.red
                        : isOn
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
        )
    );
  }
  Future<String?> pickDeviceImage(int deviceId) async {

    final picker = ImagePicker();

    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return null;

    return file.path;
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

              DeviceCardWidget(device: device),

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
          final favoriteDevices = devices.where((d) => d.isFavorite).toList();
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

            if (devices.isNotEmpty && username == "minhvc") {

              final sample = devices.first;

              cabinetMap["Tủ điều khiển ánh sáng 2"] = List.generate(3, (i) {
                return sample.copyWith(
                  id: -100 - i,
                  name: "CB phòng ${i + 1}",
                  status: i % 2 == 0 ? 1 : 0,
                  realtimeLog: null,
                );
              });

              cabinetMap["Tủ điện tầng 2"] = List.generate(4, (i) {
                return sample.copyWith(
                  id: -200 - i,
                  name: "Thiết bị ${i + 1}",
                );
              });
            }
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
              final autoExpand = total < 6;
              final online = cabinetDevices.where((d) {
                final log = d.realtimeLog ?? state.breakerLogs[d.code];
                final stateStr = (log?.state ?? "").toLowerCase();

                return stateStr == "online" ||
                    stateStr == "1" ||
                    stateStr == "connected";
              }).length;

              final isExpanded = expandedCabinets[cabinetEntry.key] ?? false;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  /// khi đóng → xanh
                  gradient: isExpanded
                      ? null
                      : const LinearGradient(
                    colors: [
                      Color(0xFFD6E9E3),  // xanh nhạt trái
                      Color(0xFFFFFFFF),  // trắng giữa
                      Color(0xFFD6E9E3),  // xanh nhạt phải
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),

                  /// khi mở → trắng
                  color: isExpanded ? Colors.white : null,

                  boxShadow: isExpanded
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    )
                  ]
                      : [],
                ),

                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),

                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      childrenPadding: EdgeInsets.zero,
                      initiallyExpanded: autoExpand || (expandedCabinets[cabinetEntry.key] ?? false),
                      iconColor: Colors.grey.shade700,
                      collapsedIconColor: Colors.grey.shade700,
                      onExpansionChanged: (value) {
                        if (autoExpand) return;

                        setState(() {
                          expandedCabinets[cabinetEntry.key] = value;
                        });
                      },

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              const Icon(Icons.factory_outlined, size: 24, color: Colors.green),
                              const SizedBox(width: 8),

                              Text(
                                cabinetEntry.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// divider giống hình
                          Container(
                            height: 1,
                            margin: const EdgeInsets.only(right: 40),
                            color: Colors.grey.withOpacity(0.2),
                          ),

                          const SizedBox(height: 6),

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