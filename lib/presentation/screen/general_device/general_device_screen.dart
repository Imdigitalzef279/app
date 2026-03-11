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
        title: Row(
          children: [

            /// LOGO KRA
            Image.asset(
              "assets/images/logo.png",
              height: 32.h,
            ),

            SizedBox(width: 10.w),

            /// TITLE
            Expanded(
              child: Text(
                "Nhà máy ${widget.project.name}",
                style: AppTextStyle.textBase.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
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
                      Color(0xFFE9F6F2),
                      Color(0xFFDFF1EC),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 120.h,
                        child: Lottie.asset(
                          Assets.images.animationLogin,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1ABC9C).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1ABC9C),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "Đang hoạt động",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1ABC9C),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            children: [
                              Expanded(
                                child: _statCard(
                                  icon: Icons.description,
                                  value: "32",
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _statCard(
                                  icon: Icons.wifi,
                                  value: "28",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                    Wrap(
                      runSpacing: 12.w,
                      spacing: 12.w,
                      children: [

                        /// QUẢN LÝ NƯỚC (cũ)
                        itemService(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.managerWater,
                              arguments: widget.project,
                            );
                          },
                          icon: Assets.icons.water.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blueEA,
                              BlendMode.srcIn,
                            ),
                          ),
                          name: LocalizationsUtils.localizations.water,
                        ),

                        /// TIẾT KIỆM ĐIỆN (cũ)
                        itemService(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.factoryDetail,
                              arguments: ElectricMeterArgument(
                                project: widget.project,
                                type: ElectricType.saveElectric,
                              ),
                            );
                          },
                          icon: Assets.icons.savingElectric.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blueEA,
                              BlendMode.srcIn,
                            ),
                          ),
                          name: LocalizationsUtils.localizations.energy_saving,
                        ),

                        /// QUẢN LÝ NĂNG LƯỢNG (cũ)
                        itemService(
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
                          icon: Icon(
                            Icons.electrical_services,
                            size: 22.w,
                            color: AppColors.blueEA,
                          ),
                          name: "Quản lý năng lượng",
                        ),

                        /// QUẢN LÝ CHIẾU SÁNG
                        itemService(
                          onTap: () {
                            // TODO: route lighting
                          },
                          icon: Icon(
                            Icons.lightbulb_outline,
                            size: 22.w,
                            color: AppColors.blueEA,
                          ),
                          name: "Quản lý chiếu sáng",
                        ),

                        /// NƯỚC - NÓNG LẠNH
                        itemService(
                          onTap: () {
                            // TODO: route water heater
                          },
                          icon: Icon(
                            Icons.hot_tub,
                            size: 22.w,
                            color: AppColors.blueEA,
                          ),
                          name: "Nước - Nóng lạnh",
                        ),

                        /// ĐIỀU HÒA (HVAC)
                        itemService(
                          onTap: () {
                            // TODO: route hvac
                          },
                          icon: Icon(
                            Icons.ac_unit,
                            size: 22.w,
                            color: AppColors.blueEA,
                          ),
                          name: "Điều hòa",
                        ),

                        /// CẢNH BÁO NGƯỜI BỊ NGÃ
                        itemService(
                          onTap: () {
                            // TODO: route kra care
                          },
                          icon: Icon(
                            Icons.health_and_safety_outlined,
                            size: 22.w,
                            color: AppColors.blueEA,
                          ),
                          name: "KRA Care",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
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
