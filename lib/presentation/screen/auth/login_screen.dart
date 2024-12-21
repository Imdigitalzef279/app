import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/data/dto/auth/request/auth_request.dart';
import 'package:solar_energy/data/repositories/auth/auth_repository.dart';
import 'package:solar_energy/di.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_button.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/home_page/home_page_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ValueNotifier<bool> check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng nhập",
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        backgroundColor: AppColors.blueF8,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // header
              SizedBox(
                height: 1.sh / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 100.h,
                            width: 1.sw,
                            child: Assets.images.logo.image(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Kra Power",
                      style: AppTextStyle.text3Xl.copyWith(
                        color: const Color(0xFFCA2E39),
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Column(
                children: [
                  CustomLabelTextField(
                    radius: 8.r,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: AppColors.blueF8,
                      size: 24.r,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    hintText: "Tên đăng nhập",
                    colorBorder: AppColors.white,
                    backgroundColor: AppColors.greyFB,
                    textStyleHint: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary.withOpacity(0.5)),
                    textStyleInput: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                  Gap(12.h),
                  CustomLabelTextField(
                    radius: 8.r,
                    //colorBorder: AppColors.white,
                    prefixIcon: Icon(
                      Icons.lock_person_rounded,
                      color: AppColors.blueF8,
                      size: 24.r,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.grey73.withOpacity(0.5),
                      ),
                    ),
                    colorBorder: AppColors.white,
                    backgroundColor: AppColors.greyFB,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    hintText: "Mật Khẩu",
                    textStyleHint: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary.withOpacity(0.5)),
                    textStyleInput: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                  Gap(32.h),
                  Column(
                    children: [
                      AppButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeWidget()),
                            (route) => false,
                          );
                        },
                        title: "Đăng nhập",
                        color: AppColors.blue,
                        fontSize: 16.sp,
                        textColor: AppColors.white,
                        radius: 8.r,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      Gap(32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: const Divider(color: AppColors.greyE5),
                      ),
                      Gap(32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: check,
                            builder: (context, value, child) => Checkbox(
                              shape: const CircleBorder(),
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.white; // Color when disabled
                                  }
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColors
                                        .blueF8; // Color when selected
                                  }
                                  return Colors.white; // Default color
                                },
                              ),
                              value: check.value,
                              onChanged: (value) {
                                check.value = !check.value;
                              },
                            ),
                          ),
                          Expanded(
                              child: Text(
                            "Tôi đồng ý với điều khoản dịch vụ và chính sách bảo mật của Kra Power",
                            style: AppTextStyle.textXs.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w400),
                          ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
