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
import 'ai_chat/ai_chat_screen.dart';

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
                    borderRadius: BorderRadius.circular(24.r),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFBFEFE4),
                        Color(0xFFE8F7F3),
                      ],
                    ),

                    /// 🔥 thêm shadow
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: Offset(0, 6),
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
                    borderRadius: BorderRadius.circular(30.r),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      )
                    ],
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
      body: Stack(
          children: [
      Container(
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFBFEFE4),
                      Color(0xFFE8F7F3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.transparent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
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

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              )
                            ],
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
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.white,
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
                    Gap(16.h),
                    SizedBox(
                      height: 95.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          featureItem(
                            iconPath: "assets/icons/icons_new/icon_energy_meter.png",
                            title: "Năng lượng",
                            color: Color(0xFF8E6CEF),
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
                        iconPath: "assets/icons/icons_new/icon_environment.png",
                        title: "Môi trường",
                        color: Color(0xFF4DA3FF),
                      ),

                          featureItem(
                            iconPath: "assets/icons/icons_new/icon_kra_smart_safety.png",
                            title: "KRA Care",
                            color: Color(0xFF38C793),
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
                        iconPath: "assets/icons/icons_new/icon_energy_analytics.png",
                        title: "Phân tích",
                        color: Color(0xFFFF8A3D),
                      ),

                      featureItem(
                        iconPath: "assets/icons/icons_new/icon_energy_saving.png",
                        title: "Chiếu sáng",
                        color: Color(0xFFFFC542),
                      ),

                      featureItem(
                        iconPath: "assets/icons/icons_new/icon_heat_pump.png",
                        title: "Điều hòa",
                        color: Color(0xFF59D0E0),
                      ),
                      ]
                    )
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

      ),


            Positioned(
              top: _aiTop,
              left: _aiLeft,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _aiTop += details.delta.dy;
                    _aiLeft += details.delta.dx;


                    _aiTop = _aiTop.clamp(0, MediaQuery.of(context).size.height - 120);
                    _aiLeft = _aiLeft.clamp(0, MediaQuery.of(context).size.width - 80);
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
          ]
      )

    );

  }
  Widget featureItem({
    required String iconPath,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 14.w),

      /// 👇 QUAN TRỌNG: phải có Material để ripple ăn
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.r),
          onTap: onTap,

          /// 👇 hiệu ứng bấm
          child: AnimatedScale(
            scale: 1,
            duration: const Duration(milliseconds: 120),

            child: Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  padding: EdgeInsets.all(14.w),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),

                    /// 🔥 shadow đẹp hơn
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],

                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.35),
                        color.withOpacity(0.05),
                      ],
                    ),
                  ),

                  child: Image.asset(iconPath),
                ),

                SizedBox(height: 8.h),

                SizedBox(
                  width: 72.w,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                  ),
                )
              ],
            ),
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
Widget _buildAiButton() {
  return Column(
    children: [
      CircleAvatar(
        radius: 26,
        backgroundColor: Color(0xFF2D6BFF),
        child: Icon(Icons.support_agent, color: Colors.white),
      ),
      SizedBox(height: 4),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Color(0xFF2D6BFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Tư vấn",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      )
    ],
  );
}
Widget _buildChatBox() {
  return Container(
    width: 280,
    height: 350,
    decoration: BoxDecoration(
      color: Colors.white,
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
        /// HEADER
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

        /// BODY
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text("Xin chào 👋"),
              Text("Bạn cần hỗ trợ gì?"),
            ],
          ),
        ),

        /// INPUT
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