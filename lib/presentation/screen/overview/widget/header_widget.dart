import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/gen/assets.gen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.type,
    required this.gridPower,
    required this.loadPower,
    required this.productionPower,
  });

  final ElectricType type;
  final double gridPower;
  final double productionPower;
  final double loadPower;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.blueFB, AppColors.greyFB])),
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(children: [
          //weather(),
          Gap(20.sp),
          type == ElectricType.saveElectric ? saveElectric() : solarElectric(),
        ]));
  }

  Widget saveElectric() {
    return Container(
        alignment: Alignment.center,
        child: Stack(children: [
          Positioned(
              left: ((1.sw - 40.sp) / 2) - 45.sp,
              top: 30.sp,
              child: Transform.rotate(
                angle: 270 * 3.14159 / 180,
                child: Lottie.asset(
                  Assets.images.animation,
                  width: 90.sp,
                  height: 90.sp,
                  onLoaded: (composition) {},
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              item(
                  img: Assets.images.electricPole.path,
                  value: gridPower,
                  size: 150.sp,
                  sizeIcon: 130.sp,
                  type: LocalizationsUtils.localizations.grid_power),
              item(
                  img: Assets.images.factory.path,
                  value: loadPower,
                  size: 140.sp,
                  sizeIcon: 100.sp,
                  type: LocalizationsUtils.localizations.usage_level,
                  isRight: false),
            ],
          ),
        ]));
  }

  Widget solarElectric() {
    return Container(
        alignment: Alignment.center,
        child: Stack(children: [
          Positioned(
              left: 80.sp,
              top: 120.sp,
              child: Transform.rotate(
                angle: 200 * 3.14159 / 180,
                child: Lottie.asset(
                  Assets.images.animation,
                  width: 90.sp,
                  height: 90.sp,
                  onLoaded: (composition) {},
                ),
              )),
          Positioned(
              right: 80.sp,
              top: 120.sp,
              child: Transform.rotate(
                angle: 155 * 3.14159 / 180,
                child: Lottie.asset(
                  Assets.images.animation,
                  width: 90.sp,
                  height: 90.sp,
                  onLoaded: (composition) {},
                ),
              )),
          Positioned(
              left: (1.sw / 2) - 65.sp,
              top: 180.sp,
              child: Transform.rotate(
                angle: 90 * 3.14159 / 180,
                child: Lottie.asset(
                  Assets.images.animation,
                  width: 90.sp,
                  height: 90.sp,
                  onLoaded: (composition) {},
                ),
              )),
          Column(
            children: [
              item(
                  img: Assets.images.factory.path,
                  value: loadPower,
                  size: 140.sp,
                  sizeIcon: 100.sp,
                  type: LocalizationsUtils.localizations.usage_level,
                  isRight: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  item(
                      img: Assets.images.electricPole.path,
                      value: gridPower,
                      size: 150.sp,
                      sizeIcon: 130.sp,
                      type: LocalizationsUtils.localizations.grid_power),
                  item(
                      img: Assets.images.solarEnergy.path,
                      value: productionPower,
                      size: 130.sp,
                      sizeIcon: 120.sp,
                      type: "PV",
                      isRight: false),
                ],
              ),
            ],
          ),
        ]));
  }

  Widget item(
      {required String img,
      required double size,
      required double sizeIcon,
      required double value,
      required String type,
      bool isRight = true}) {
    return Container(
      width: size,
      height: size,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: sizeIcon + 30.sp,
              height: sizeIcon,
              color: Colors.transparent,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size / 2,
            decoration: BoxDecoration(
              border: isRight
                  ? const Border(right: BorderSide(color: AppColors.greyAE))
                  : const Border(left: BorderSide(color: AppColors.greyAE)),
            ),
            padding: isRight
                ? EdgeInsets.only(right: 12.sp)
                : EdgeInsets.only(left: 12.sp),
            margin: isRight ? null : EdgeInsets.only(left: 40.sp),
            child: SizedBox(
              child: Column(
                // crossAxisAlignment:
                //     isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      textAlign: isRight ? TextAlign.right : TextAlign.left,
                      text: TextSpan(children: [
                        TextSpan(
                            text: value.toStringAsFixed(1),
                            style: AppTextStyle.textSm.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: ' KW',
                            style: AppTextStyle.textXs.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.grey86,
                                fontWeight: FontWeight.w500)),
                      ])),
                  Text(
                    type,
                    style: AppTextStyle.textSm.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey86),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
