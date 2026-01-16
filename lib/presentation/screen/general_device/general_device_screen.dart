import 'package:flutter/material.dart';
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

import '../../../data/dto/power_station/response/power_station_response.dart';

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
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "${LocalizationsUtils.localizations.factory} ${widget.project.name}",
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(LocalizationsUtils.localizations.instructions,
                              style: AppTextStyle.textSm.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600)),
                          12.verticalSpace,
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColors.blueF8.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Text(
                                LocalizationsUtils.localizations.start,
                                style: AppTextStyle.textSm
                                    .copyWith(color: AppColors.blueF8),
                              ),
                            ),
                          )
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                          fontWeight: FontWeight.w600),
                    ),
                    Gap(16.h),
                    Wrap(
                      runSpacing: 12.w,
                      spacing: 12.w,
                      children: [
                        itemService(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.managerWater,
                                  arguments: widget.project);
                            },
                            icon: Assets.icons.water.svg(
                                width: 22.w,
                                height: 22.w,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueEA, BlendMode.srcIn)),
                            name: LocalizationsUtils.localizations.water),
                        itemService(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.factoryDetail,
                                  arguments: ElectricMeterArgument(
                                      project: widget.project,
                                      type: ElectricType.saveElectric));
                            },
                            icon: Assets.icons.savingElectric.svg(
                                width: 22.w,
                                height: 22.w,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.blueEA, BlendMode.srcIn)),
                            name:
                                LocalizationsUtils.localizations.energy_saving),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemService(
      {required String name, required Widget icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: (1.sw - 68.w) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: 4.h,
            ),
            Text(
              name,
              style: AppTextStyle.textXs.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
