import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/enums/load_status.dart';
import '../../../../data/dto/device/response/device_response.dart';
import '../../Electricity/automat/device_info_screen/device_info_screen.dart';
import '../../device/bloc/device_cubit.dart';
import '../../general_device/scan_qr/scan_qr_screen.dart';
import 'bloc/DeviceLifecycleCubit.dart';
import 'bloc/DeviceLifecycleState.dart';


class DeviceLifecycleScreen extends StatefulWidget {
  const DeviceLifecycleScreen({super.key});

  @override
  State<DeviceLifecycleScreen> createState() =>
      _DeviceLifecycleScreenState();
}

class _DeviceLifecycleScreenState
    extends State<DeviceLifecycleScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      context
          .read<DeviceLifecycleCubit>()
          .loadDevices([
        261,
        262,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "KRA-DLM",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScanQrScreen(),
                ),
              );
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ScanQrScreen(),
            ),
          );
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text("Quét QR"),
      ),

      body: BlocBuilder<
          DeviceLifecycleCubit,
          DeviceLifecycleState>(
        builder: (context, state) {

          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final devices = state.devices;

          if (devices.isEmpty) {
            return const Center(
              child: Text(
                "Không có thiết bị",
              ),
            );
          }

          return Column(
            children: [

              /// HEADER
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3CB371),
                      Color(0xFF2E8B57),
                    ],
                  ),
                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.devices,
                      color: Colors.white,
                      size: 40,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Quản lý vòng đời thiết bị",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "${devices.length} thiết bị",
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  itemCount: devices.length,

                  itemBuilder: (_, index) {

                    final device =
                    devices[index];

                    return _deviceCard(device);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _deviceCard(DeviceResponse device) {




    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DeviceInfoScreen(
                  device: device,
                ),
          ),
        );
      },

      child: Container(
        margin:
        const EdgeInsets.only(bottom: 12),

        padding:
        const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color:
                const Color(0xFFE7F2EF),
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),
              child: const Icon(
                Icons.memory,
                color: Color(0xFF42E150),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          device.name
                              .isNotEmpty
                              ? device.name
                              : device.code,
                          style:
                          const TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight
                                .w700,
                          ),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Serial: ${device.serialNumber ?? "-"}",
                    style:
                    const TextStyle(
                      fontSize: 12,
                      color:
                      Colors.grey,
                    ),
                  ),

                  Text(
                    "Gateway: ${device.gatewayNumber ?? "-"}",
                    style:
                    const TextStyle(
                      fontSize: 12,
                      color:
                      Colors.grey,
                    ),
                  ),

                  Text(
                    "Trạm: ${device.powerStation?.name ?? "-"}",
                    style:
                    const TextStyle(
                      fontSize: 12,
                      color:
                      Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
            ),
          ],
        ),
      ),
    );
  }
}