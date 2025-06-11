import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/utils/navigation_utils.dart';

class AppToast {
  static final List<OverlayEntry> _toastEntries = [];

  static void showToastError({required String title}) {
    _showToast(title, Colors.red, Icons.error_outlined);
  }

  static void showToastSuccess({required String title}) {
    _showToast(title, Colors.green, Icons.check_circle_sharp);
  }

  static void showToastNotify({required String title}) {
    _showToast(title, null, null);
  }

  static void _showToast(String title, Color? color, IconData? icon) {
    final overlayState = NavigatorUtils.navigatorKey.currentState?.overlay;
    if (overlayState == null) return;

    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 8.h,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            tween: Tween(begin: -100.0, end: 45.h),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Container(
              width: 1.sw,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: color ?? AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0.2, 0.5),
                  ),
                ],
              ),
              child: icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: AppColors.white,
                          size: 25.r,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyle.textSm.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        title,
                        style: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );

    _toastEntries.add(entry); // 👈 Lưu lại entry
    overlayState.insert(entry);

    Future.delayed(const Duration(milliseconds: 3000), () {
      entry?.remove();
      _toastEntries.remove(entry); // 👈 Cleanup sau khi toast biến mất
    });
  }

  /// ✅ Hàm gọi để đóng tất cả toast hiện tại
  static void dismissAll() {
    for (final entry in _toastEntries) {
      entry.remove();
    }
    _toastEntries.clear();
  }
}
