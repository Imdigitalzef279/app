import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/dto/device/response/device_response.dart';
import '../../../widgets/password_dialog.dart';
import '../../Electricity/automat/automat_detail_screen.dart';
import '../../Electricity/automat/bloc/atomat_detail_cubit.dart';
import '../../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import '../../device/bloc/device_cubit.dart';
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;
class DeviceGridItem extends StatelessWidget {
  final DeviceResponse device;
  final Color textColor;

  const DeviceGridItem({
    super.key,
    required this.device,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      buildWhen: (prev, curr) =>
      prev.resultDevices != curr.resultDevices ||
          prev.breakerLogs != curr.breakerLogs,
      builder: (context, state) {
        final latestDevice = state.resultDevices.data
            ?.firstWhere((d) => d.id == device.id, orElse: () => device) ?? device;

        final log = state.breakerLogs[latestDevice.code];

        final realStatus = context.read<DeviceCubit>()
            .getRealStatus(latestDevice, log);

        final isOn = realStatus == 1;
        final isMaintenance = realStatus == 2;
        final isSwitching =
        state.switchingDevices.containsKey(device.id);

        final countdown = state.switchCountdowns[device.id] ?? 0;

        final gatewayState = (log?.state ?? "").toLowerCase();

        final isOnline =
            gatewayState == "online" ||
                gatewayState == "1" ||
                gatewayState == "connected";
        final isTab = MediaQuery.of(context).size.width >= 600;
        return InkWell(
          borderRadius: BorderRadius.circular(14),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
            height: 105,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: textColor == Colors.white
                      ? Colors.black.withOpacity(0.4)
                      : Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(14),

                  boxShadow: isTab
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    )
                  ]
                      : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                    )
                  ],
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// HEADER
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF4F1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.power,
                        size: 13,
                        color: Color(0xFF6BB6A6),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.name ?? device.code ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: isOnline ? Colors.green : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isOnline ? "Online" : "Offline",
                                style: TextStyle(
                                  fontSize: 9,
                                  color:
                                  isOnline ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// FOOTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isSwitching
                          ? (isOn ? "Đang cắt..." : "Đang đóng...") // Sửa: Đảo ngược lại cho đúng hành động
                          : countdown > 0
                          ? "Đợi (${countdown}s)"
                          : isMaintenance
                          ? "Bảo trì" // Thêm: Hiển thị bảo trì giống màn Detail
                          : (isOnline ? (isOn ? "Đóng" : "Cắt") : "Ngoại tuyến"),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSwitching || countdown > 0
                            ? Colors.orange // Đổi màu cam khi đang xử lý/đợi
                            : (isMaintenance ? Colors.blue : (isOn ? Colors.green : Colors.red)),
                      ),
                    ),
                    Transform.scale(
                      scale: 0.6,
                    child: SizedBox(
                      width: 45,
                      height: 25,
                      child: Switch(
                        value: isOn,
                        activeColor: Colors.white,
                        activeTrackColor: const Color(0xFF43A047),
                        inactiveTrackColor: const Color(0xFFE53935),
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                        onChanged: (isOnline &&
                            !isSwitching &&
                            countdown == 0 && !isMaintenance)
                            ? (value) async {
                          final password =
                          await showPasswordDialog(context);
                          if (password == null) return;

                          await context.read<DeviceCubit>().togglePower(
                            latestDevice,
                            password: password,
                          );
                        }
                            : null,
                      ),
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
            )
        );
      },
    );
  }
}