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
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "${LocalizationsUtils.localizations.factory} ${widget.project.name}",
          style: AppTextStyle.textBase.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [

          /// ➕ Thêm sản phẩm
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.addProduct);
            },
          ),

          /// ⚙️ Cài đặt
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black87,
            ),
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
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              // ===== HEADER =====
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   LocalizationsUtils.localizations.instructions,
                          //   style: AppTextStyle.textSm.copyWith(
                          //     color: AppColors.textPrimary,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          // 12.verticalSpace,
                        ],
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Lottie.asset(
                          Assets.images.animationLogin,
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..repeat(reverse: true);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Gap(12.h),

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
                                  create: (_) => DeviceCubit()
                                    ..getAllDevices(
                                      powerStationId: widget.project.id!,
                                    ),
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
            ],
          ),
        ),
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
