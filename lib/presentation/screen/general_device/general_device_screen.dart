import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/general_device/project_setting_screen.dart';
import 'package:solar_energy/presentation/screen/general_device/scan_qr/scan_qr_screen.dart';
import '../../../data/dto/atomat/atomat_log_response.dart';
import '../../../data/dto/device/response/device_response.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import '../../../data/services/signalr_service.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../device/bloc/device_cubit.dart';
import '../device/device_card/device_card_widget.dart';
import '../device_water/device_water_screen.dart';
import '../kra_care/kra_care_screen.dart';
import 'analytics_overview/analytics_overview_screen.dart';
import 'background/bloc/background_cubit.dart';
import 'device_grid/device_grid_item.dart';
import 'notification/notification_screen.dart';
Color getAdaptiveTextColor(String? bg) {
  if (bg == null) return Colors.black;

  if (bg.contains("red") ||
      bg.contains("dark") ||
      bg.contains("night")) {
    return Colors.white;
  }

  return Colors.black87;
}
class GeneralDeviceScreen extends StatefulWidget {
  const GeneralDeviceScreen({super.key, required this.project});

  final PowerStationResponse project;

  @override
  State<GeneralDeviceScreen> createState() => _GeneralDeviceScreenState();
}
class _GeneralDeviceScreenState extends State<GeneralDeviceScreen>

    with TickerProviderStateMixin {
  bool _isGridView = true;
  late final AnimationController _controller;
  late bool isLandscape;
  late SignalRService signalR;
  StreamSubscription? _signalSub;
  double _aiTop = 500;
  double _aiLeft = 300;

  bool _showChat = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    signalR = SignalRService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final cubit = context.read<DeviceCubit>();
      final devices = cubit.state.resultDevices.data ?? [];
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
      _signalSub = signalR.stream.listen((data) {
        if (!mounted) return;

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
        final code = raw["breakerSn"] ?? raw["meterSn"] ?? raw["deviceCode"];

        if (code == null) return;

        context.read<DeviceCubit>().updateRealtimeLogByCode(code, log);
      });

    });
  }
  @override
  void dispose() {
    _signalSub?.cancel();
    signalR.disconnect();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final textColor = Colors.black;
    final state = context.watch<DeviceCubit>().state;
    final devices = state.resultDevices.data ?? [];
    final favoriteDevices =
    devices.where((d) => d.isFavorite).take(6).toList();

    String locationText = "Hà Nội";

    final bannerImages = [
      "assets/images/matis/1.png",
      "assets/images/matis/Enertrek System.png",
      "assets/images/matis/4.png",
      "assets/images/matis/5.png",
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.85),
        elevation: 0,
        titleSpacing: 12,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 32,
            ),
            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.greenAccent,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          locationText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: textColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              children: [
                _buildAppBarIcon(
                  icon: Icons.add_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ScanQrScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(width: 8),

                _buildAppBarIcon(
                  icon: Icons.notifications_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotificationScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(width: 8),

                _buildAppBarIcon(
                  icon: Icons.settings_rounded,
                  onTap: () {
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
              ],
            )
          ],
        ),
      ),

      body: BlocBuilder<BackgroundCubit, String?>(
        builder: (context, bg) {
          final textColor = getAdaptiveTextColor(bg);
          return Stack(
            children: [

              /// ===== BACKGROUND IMAGE =====
              if (bg != null && bg.isNotEmpty)
                Positioned.fill(
                  child: bg.startsWith("assets/")
                      ? Image.asset(
                    bg,
                    fit: BoxFit.cover,
                  )
                      : Image.file(
                    File(bg),
                    fit: BoxFit.cover,
                  ),
                ),


              if (bg != null && bg.isNotEmpty)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),


              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight, // FIX nền xám
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, //  đẩy devices xuống
                          children: [


                            Column(
                              children: [

                                Container(
                                  height: 180.h, //  tăng để ăn khoảng trống
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: PageView.builder(
                                      itemCount: bannerImages.length,
                                      itemBuilder: (context, index) {
                                        return Image.asset(
                                          bannerImages[index],
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.white.withOpacity(0.85),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 12,
                                        offset: Offset(0, 6),
                                      )
                                    ],
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
                                      Gap(10.h),

                                      SizedBox(
                                        height: 70.h,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            featureItem(
                                              iconPath: "assets/icons/icons_new/icon_energy_meter.png",
                                              title: "Năng lượng",
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
                                              iconPath: "assets/icons/icons_new/icon_energy_analytics.png",
                                              title: "Phân tích",
                                              onTap: () {
                                                final devices =
                                                    context.read<DeviceCubit>().state.resultDevices.data ?? [];

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => AnalyticsOverviewScreen(devices: devices),
                                                  ),
                                                );
                                              },
                                            ),
                                            featureItem(
                                              iconPath: "assets/icons/icons_new/icon_environment.png",
                                              title: "Môi trường",
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => DeviceWaterScreen(
                                                      stationId: widget.project.id!,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            featureItem(
                                              iconPath: "assets/icons/icons_new/icon_kra_smart_safety.png",
                                              title: "KRA Care",
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => KraCareScreen(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(height: 12.h),
                              ],
                            ),

                            /// ===== DEVICES (LUÔN Ở ĐÁY) =====
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.45),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Thiết bị hay dùng",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),

                                      ///  NÚT CHUYỂN VIEW
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => setState(() => _isGridView = !_isGridView),
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.4),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                _isGridView ? Icons.view_agenda : Icons.grid_view,
                                                size: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Gap(4.h),

                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: favoriteDevices.isEmpty
                                        ? Text("Chưa có thiết bị")
                                        : _isGridView
                                        ? _buildFixed6AndScroll(favoriteDevices)
                                        : _buildHorizontalList(favoriteDevices),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: _aiTop,
                left: _aiLeft,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _aiTop += details.delta.dy;
                      _aiLeft += details.delta.dx;
                    });
                  },
                  onTap: () {
                    setState(() {
                      _showChat = !_showChat;
                    });
                  },
                  child: _buildAiButton(),
                ),
              ),

              if (_showChat)
                Positioned(
                  top: _aiTop - 360,
                  left: _aiLeft - 200,
                  child: AnimatedScale(
                    scale: _showChat ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: _buildChatBox(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildAppBarIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.black87,
        ),
      ),
    );
  }
  Widget _buildHorizontalList(List<DeviceResponse> devices) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: devices.length,
      separatorBuilder: (_, __) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        return DeviceCardWidget(device: devices[index]);
      },
    );
  }
  Widget _buildFixed6AndScroll(List<DeviceResponse> devices) {
    final chunks = <List<DeviceResponse>>[];
    final textColor = Colors.black;
    for (int i = 0; i < devices.length; i += 6) {
      chunks.add(
        devices.sublist(
          i,
          i + 6 > devices.length ? devices.length : i + 6,
        ),
      );
    }

    return SizedBox(
      height: 105 * 2 + 8,
      child: PageView.builder(
        itemCount: chunks.length,
        controller: PageController(viewportFraction: 1),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, pageIndex) {
          final pageDevices = chunks[pageIndex];

          return Column(
            children: [
              Row(
                children: List.generate(3, (index) {
                  if (index >= pageDevices.length) {
                    return Expanded(child: SizedBox());
                  }
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      child: DeviceGridItem(
                        device: pageDevices[index],
                        textColor: textColor,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 8),

              Row(
                children: List.generate(3, (index) {
                  final i = index + 3;
                  if (i >= pageDevices.length) {
                    return Expanded(child: SizedBox());
                  }
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      child: DeviceGridItem(
                        device: pageDevices[i],
                        textColor: textColor,
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget featureItem({
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 70.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                iconPath,
                width: 36.w,
                height: 36.w,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 6.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              )
            ],
          ),
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
            color: Colors.white.withOpacity(0.85),
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
        color: Colors.white.withOpacity(0.85),
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
Widget _buildAiButton() {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Color(0xFF4FACFE),
          Color(0xFF00F2FE),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.4),
          blurRadius: 20,
          spreadRadius: 2,
        )
      ],
    ),
    child: CircleAvatar(
      radius: 28,
      backgroundColor: Colors.transparent,
      child: Icon(
        Icons.psychology_alt,
        color: Colors.white,
        size: 26,
      ),
    ),
  );
}

Widget _buildChatBox() {
  return Container(
    width: 280,
    height: 350,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.85),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
        )
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF2D6BFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Icon(Icons.smart_toy, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "AI Tư vấn",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text("Xin chào 👋"),
              Text("Bạn cần hỗ trợ gì?"),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Nhập câu hỏi...",
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    ),
  );
}