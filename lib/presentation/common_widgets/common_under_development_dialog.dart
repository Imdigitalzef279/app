import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../application/constants/app_color.dart';
import '../../application/constants/app_text_style.dart';
import '../../gen/assets.gen.dart';

class UnderDevelopmentDialog extends StatelessWidget {
  final bool isLandscape;

  const UnderDevelopmentDialog({super.key, this.isLandscape = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isLandscape ? 200.h : 500.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.exclamation.image(
              width: isLandscape ? 150.h : 100.w,
              height: isLandscape ? 150.h : 100.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24.h),
            Text(
              "Tính năng này đang trong quá trình phát triển",
              style: AppTextStyle.tini.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueEA,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Đã hiểu",
                  style: AppTextStyle.tini.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
