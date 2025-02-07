import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Dịch vụ",
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Text(
                "Trợ giúp và phản hồi",
                style: AppTextStyle.textSm.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary.withOpacity(0.7)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Wrap(
                  runSpacing: 12.w,
                  spacing: 8.w,
                  children: [
                    itemService(
                        icon: Assets.icons.screenPlay.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "Video hướng dẫn"),
                    itemService(
                        icon: Assets.icons.guideAlt.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "Hướng dân sử dụng"),
                    itemService(
                        icon: Assets.icons.messagesQuestion.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "Câu hỏi thường gặp"),
                    itemService(
                        icon: Assets.icons.chatbotSpeechBubble.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "Dịch vụ Chatbot"),
                    itemService(
                        icon: Assets.icons.autoReply.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "Phản hồi"),
                    itemService(
                        icon: Assets.icons.phoneCall.svg(
                            width: 22.w,
                            height: 22.w,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueEA, BlendMode.srcIn)),
                        name: "liên hệ với chúng tôi"),
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
    return SizedBox(
      width: (1.sw - 80.w) / 4,
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
    );
  }
}
