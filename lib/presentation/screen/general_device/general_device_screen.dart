import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/general_device/project_setting_screen.dart';
import '../../../data/dto/atomat/atomat_log_response.dart';
import '../../../data/dto/device/response/device_response.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import '../../../data/services/signalr_service.dart';
import '../../widgets/password_dialog.dart';
import '../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import '../Electricity/automat/automat_detail_screen.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../Electricity/automat/bloc/atomat_detail_cubit.dart';
import '../device/bloc/device_cubit.dart';
import '../device/device_card/device_card_widget.dart';
import '../kra_care/kra_care_screen.dart';

class GeneralDeviceScreen extends StatefulWidget {
  const GeneralDeviceScreen({super.key, required this.project});

  final PowerStationResponse project;

  @override
  State<GeneralDeviceScreen> createState() => _GeneralDeviceScreenState();
}
class _GeneralDeviceScreenState extends State<GeneralDeviceScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late bool isLandscape;
  late SignalRService signalR;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    signalR = SignalRService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final cubit = context.read<DeviceCubit>();
      final devices = cubit.state.resultDevices.data ?? [];

      /// load log lần đầu
      for (var d in devices) {
        if (d.code != null) {
          await cubit.loadBreakerLog(d.code);
        }
      }

      if (devices.isNotEmpty && devices.first.code != null) {
        for (var d in devices) {
          await signalR.connect(meterCode: d.code!);
        }
      }

      signalR.stream.listen((data) {

        final dto = data["breakerMeterDataDto"];
        if (dto == null) return;

        final raw = Map<String, dynamic>.from(dto);

        raw.updateAll((key, value) {
          if (value is String) {
            final numValue = num.tryParse(value);
            return numValue ?? value;
          }
          return value;
        });

        final log = AtomatLogResponse.fromJson(raw);
        print("======== BREAKER REALTIME ========");
        print("Breaker SN: ${raw["breakerSn"]}");
        print("rlySta: ${log.rlySta}");
        print("rlyRepSta: ${log.rlyRepSta}");
        print("=================================");
        final code = raw["breakerSn"] ?? raw["meterSn"] ?? raw["deviceCode"];

        if (code == null) {
          print("SignalR missing breakerSn");
          return;
        }
        context.read<DeviceCubit>().updateRealtimeLogByCode(
          code,
          log,
        );

      });

    });
  }
  @override
  void dispose() {
    signalR.disconnect();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final devices =
        context.select((DeviceCubit c) => c.state.resultDevices.data) ?? [];
    final favoriteDevices =
    devices.where((d) => d.isFavorite).toList();
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 28.h,
                ),

                SizedBox(width: 8.w),

                Expanded(
                  child: Text(
                    "Nhà máy ${widget.project.name}",
                    style: AppTextStyle.textBase.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1ABC9C),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  "Đang hoạt động",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF1ABC9C),
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProjectSettingScreen(
                            project: widget.project,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFDDF3EA),
                Color(0xFFEFF8F4),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              // ===== HEADER =====
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFBFEFE4),
                      Color(0xFFE8F7F3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    /// IMAGE
                    Column(
                      children: [
                        SizedBox(
                          height: 135.h,
                          child: Image.asset(
                            "assets/images/factory.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        /// SAFE SYSTEM CARD
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                              vertical: 10.h
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            children: [

                              Icon(
                                Icons.shield_outlined,
                                color: Color(0xFF1ABC9C),
                                  size: 20.w
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "Hệ thống đang an toàn",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16.w,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // ===== FEATURES =====
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizationsUtils.localizations.features,
                      style: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(16.h),
                    SizedBox(
                      height: 95.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          featureItem(
                            icon: Icons.bolt,
                            title: "Năng lượng",
                            color: const Color(0xFF8E6CEF),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<DeviceCubit>(),
                                    child: AutomatListScreen(
                                      powerStationId: widget.project.id!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          featureItem(
                            icon: Icons.water_drop,
                            title: "Môi trường",
                            color: const Color(0xFF4DA3FF),
                          ),
                          featureItem(
                            icon: Icons.shield,
                            title: "KRA Care",
                            color: const Color(0xFF38C793),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const KraCareScreen(),
                                ),
                              );
                            },
                          ),
                          featureItem(
                            icon: Icons.show_chart,
                            title: "Phân tích",
                            color: const Color(0xFFFF8A3D),
                          ),
                          featureItem(
                            icon: Icons.lightbulb,
                            title: "Chiếu sáng",
                            color: const Color(0xFFFFC542),
                          ),
                          featureItem(
                            icon: Icons.ac_unit,
                            title: "Điều hòa",
                            color: const Color(0xFF59D0E0),
                          ),
                        ],
                      ),
                    )
                ]
                ),
              ),
              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "KRA Care",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(
                        "Thiết bị hay dùng",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),

                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              "Xem tất cả",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1ABC9C),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.sp,
                              color: const Color(0xFF1ABC9C),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  Gap(16.h),
                  favoriteDevices.isEmpty
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      "Chưa có thiết bị hay dùng",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  )
                      : Column(
                    children: favoriteDevices.map((device) {
                      return DeviceCardWidget(device: device);
                    }).toList(),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
        )
    );

  }

  // Widget deviceItem(DeviceResponse device) {
  //
  //   return BlocBuilder<DeviceCubit, DeviceState>(
  //       builder: (context, state) {
  //
  //         final deviceCubit = context.read<DeviceCubit>();
  //
  //         final log = state.breakerLogs[device.code] ?? device.realtimeLog;
  //
  //         final realStatus = deviceCubit.getRealStatus(device, log);
  //
  //   final bool isOn = realStatus == 1;
  //   final bool isOffline = realStatus == -1;
  //   final bool isMaintenance = realStatus == 2;
  //
  //   final countdown = state.switchCountdowns[device.id] ?? 0;
  //   final isSwitching = deviceCubit.isDeviceSwitching(device.id);
  //
  //   /// text + color trạng thái
  //   String statusText;
  //   Color statusColor;
  //
  //   switch (realStatus) {
  //     case 1:
  //       statusText = "Đóng";
  //       statusColor = BreakerColors.on;
  //       break;
  //
  //     case 0:
  //       statusText = "Cắt";
  //       statusColor = BreakerColors.off;
  //       break;
  //
  //     case 2:
  //       statusText = "Bảo trì";
  //       statusColor = BreakerColors.maintenance;
  //       break;
  //
  //     case -1:
  //       statusText = "Ngoại tuyến";
  //       statusColor = Colors.grey;
  //       break;
  //
  //     default:
  //       statusText = "--";
  //       statusColor = Colors.grey;
  //   }
  //
  //   return InkWell(
  //
  //     /// mở chi tiết
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => MultiBlocProvider(
  //             providers: [
  //               BlocProvider.value(
  //                 value: context.read<DeviceCubit>(),
  //               ),
  //               BlocProvider(
  //                 create: (_) => AtomatDetailCubit(),
  //               ),
  //               BlocProvider(
  //                 create: (_) => AutomatChartCubit(),
  //               ),
  //             ],
  //             child: AutomatDetailScreen(device: device),
  //           ),
  //         ),
  //       );
  //     },
  //
  //     /// giữ để xoá favorite
  //     onLongPress: () {
  //       context.read<DeviceCubit>().toggleFavorite(device.id);
  //     },
  //
  //     child: Container(
  //       margin: EdgeInsets.only(bottom: 12.h),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 14.w,
  //         vertical: 12.h,
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(14.r),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.05),
  //             blurRadius: 12,
  //             offset: const Offset(0,4),
  //           )
  //         ],
  //       ),
  //
  //       child: Row(
  //         children: [
  //
  //           /// ICON
  //           Container(
  //             padding: EdgeInsets.all(10.w),
  //             decoration: BoxDecoration(
  //               color: statusColor.withOpacity(0.15),
  //               borderRadius: BorderRadius.circular(12.r),
  //             ),
  //             child: Icon(
  //               realStatus == 1
  //                   ? Icons.flash_on
  //                   : realStatus == 2
  //                   ? Icons.build
  //                   : realStatus == -1
  //                   ? Icons.cloud_off
  //                   : Icons.power_off,
  //               color: statusColor,
  //             ),
  //           ),
  //
  //           SizedBox(width: 12.w),
  //
  //           /// TEXT
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //
  //                 Text(
  //                   device.name.isNotEmpty
  //                       ? device.name
  //                       : device.code,
  //                   style: TextStyle(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //
  //                 SizedBox(height: 4.h),
  //
  //                 Text(
  //                   statusText,
  //                   style: TextStyle(
  //                     fontSize: 12.sp,
  //                     color: statusColor,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //           /// SWITCH + COUNTDOWN
  //           Column(
  //             children: [
  //
  //               Transform.scale(
  //                 scale: 0.85,
  //                 child: Switch(
  //                   value: isOn,
  //
  //                   activeColor: Colors.white,
  //                   activeTrackColor: BreakerColors.on,
  //                   inactiveThumbColor: Colors.white,
  //                   inactiveTrackColor: BreakerColors.off,
  //
  //                   materialTapTargetSize:
  //                   MaterialTapTargetSize.shrinkWrap,
  //
  //                   onChanged: (isOffline ||
  //                       isMaintenance ||
  //                       isSwitching ||
  //                       countdown > 0)
  //                       ? null
  //                       : (value) async {
  //
  //                     final password =
  //                     await showPasswordDialog(context);
  //
  //                     if (password == null) return;
  //
  //                     await context
  //                         .read<DeviceCubit>()
  //                         .togglePower(
  //                       device,
  //                       password: password,
  //                     );
  //                   },
  //                 ),
  //               ),
  //
  //               if (countdown > 0)
  //                 AnimatedSwitcher(
  //                   duration: Duration(milliseconds: 300),
  //                   child: countdown > 0
  //                       ? Text(
  //                     "$countdown s",
  //                     key: ValueKey(countdown),
  //                     style: TextStyle(
  //                       fontSize: 11.sp,
  //                       color: Colors.orange,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   )
  //                       : SizedBox(),
  //                 )
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //       },
  //   );
  // }
  Widget featureItem({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 14.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Column(
          children: [

            Container(
        width: 60.w,
        height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.25),
                    color.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0,4),
                  )
                ],
              ),
              child: Icon(
                icon,
                color: color,
                  size: 26.w
              ),
            ),

            SizedBox(height: 6.h),

            SizedBox(
              width: 70.w,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget featureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
              )
            ],
          ),
      child: Row(
        children: [

          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
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
  Widget _statCard({
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22.w,
            color: const Color(0xFF1ABC9C),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1ABC9C),
            ),
          ),
        ],
      ),
    );
  }
  Widget _deviceCard({
    required String title,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          Icon(icon, size: 30.w, color: color),
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget itemService({
    required String name,
    required Widget icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: (1.sw - 68.w) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 4.h),
            Text(
              name,
              style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
