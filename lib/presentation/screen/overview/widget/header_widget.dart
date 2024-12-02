import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/overview/widget/animation_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.blueFB, AppColors.greyFB])),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          weather(),
          Gap(20.h),
          electricity(),
        ],
      ),
    );
  }

  Widget weather() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.cloud,
              color: AppColors.blueFF,
            ),
            Gap(4.w),
            Text("18°C-20°C",
                style:
                    AppTextStyle.textXs.copyWith(color: AppColors.textPrimary))
          ],
        ),
        Gap(8.h),
        Text(
          "Bình thường",
          style: AppTextStyle.textXs.copyWith(color: AppColors.green50),
        )
      ],
    );
  }

  Widget electricity() {
    return Container(
        alignment: Alignment.center,
        child: Stack(children: [
          Positioned(
              right: 90.w,
              top: 120.h,
              child: Transform.rotate(
                  angle: 240 * 3.14159 / 180,
                  child: AnimationWidget(width: 100.w, duration: 1500))),
          Positioned(
              right: 0,
              left: 0,
              top: 180.h,
              child: Transform.rotate(
                  angle: 180 * 3.14159 / 180,
                  child: AnimationWidget(width: 100.w, duration: 1500))),
          Positioned(
              left: 90.w,
              top: 120.h,
              child: Transform.rotate(
                  angle: 300 * 3.14159 / 180,
                  child: AnimationWidget(width: 100.w, duration: 1500))),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 50.w),
                child: item(
                    img: Assets.images.factory.path,
                    content: '680.670',
                    size: 110.r,
                    sizeIcon: 80.r,
                    type: "Mức sử dụng"),
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  item(
                      img: Assets.images.electricPole.path,
                      content: '218.114',
                      size: 100.r,
                      sizeIcon: 60.r,
                      type: "Lưới điện"),
                  item(
                      img: Assets.images.solarPanel.path,
                      content: '462.584',
                      size: 100.r,
                      sizeIcon: 60.r,
                      type: "PV",
                      isRight: false),
                ],
              )
            ],
          ),
        ]));
  }

  Widget item(
      {required String img,
      required double size,
      required double sizeIcon,
      required String content,
      required String type,
      bool isRight = true}) {
    return Container(
      height: size,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: isRight ? 0 : null,
            left: isRight ? null : 0,
            child: Container(
              width: sizeIcon,
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
            margin: isRight
                ? EdgeInsets.only(right: 30.w)
                : EdgeInsets.only(left: 30.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: content,
                      style: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: ' KW',
                      style: AppTextStyle.textXs.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.grey86,
                          fontWeight: FontWeight.w600)),
                ])),
                Text(
                  type,
                  style: AppTextStyle.textSm.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey86),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
