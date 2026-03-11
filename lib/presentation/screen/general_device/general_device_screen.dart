import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/domain/arguments/electric_meter/electric_meter_argument.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/general_device/project_setting_screen.dart';

import '../../../data/dto/power_station/response/power_station_response.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../device/bloc/device_cubit.dart';

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
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
      body: SafeArea(
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
                          height: 160.h,
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
                            vertical: 12.h,
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
                                size: 22.w,
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
              SizedBox(height: 20.h),
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
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.4,
                      children: [

                        featureCard(
                          icon: Icons.water_drop,
                          title: "Quản lý nước",
                          subtitle: "Ổn định",
                          color: Colors.blue,
                        ),

                        featureCard(
                          icon: Icons.flash_on,
                          title: "Tiết kiệm điện",
                          subtitle: "-12% hôm nay",
                          color: Colors.orange,
                        ),

                        featureCard(
                          icon: Icons.bar_chart,
                          title: "Quản lý năng lượng",
                          subtitle: "3.2 kW",
                          color: Colors.purple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => DeviceCubit(),
                                  child: AutomatListScreen(
                                    powerStationId: widget.project.id!,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        featureCard(
                          icon: Icons.lightbulb,
                          title: "Quản lý chiếu sáng",
                          subtitle: "5 phòng bật",
                          color: Colors.amber,
                        ),

                        featureCard(
                          icon: Icons.water,
                          title: "Nước - Nóng lạnh",
                          subtitle: "Hoạt động tốt",
                          color: Colors.blueAccent,
                        ),

                        featureCard(
                          icon: Icons.ac_unit,
                          title: "Điều hòa",
                          subtitle: "26°C · 3 thiết bị",
                          color: Colors.cyan,
                        ),
                      ],
                    ),
                  ],
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
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Xem tất cả",
                        style: TextStyle(
                          color: const Color(0xFF1ABC9C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Gap(16.h),

                  SizedBox(
                    height: 130.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _deviceCard(
                          title: "MCB-001",
                          status: "Đang bật",
                          color: Colors.green,
                          icon: Icons.power,
                        ),
                        _deviceCard(
                          title: "Bơm Nước 1",
                          status: "Đang chạy",
                          color: Colors.blue,
                          icon: Icons.water,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
