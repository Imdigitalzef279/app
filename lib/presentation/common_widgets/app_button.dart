import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../application/utils/app_utils.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? icon;
  final bool isEnable;
  final double fontSize;
  final Color textColor;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final double? heightText;
  final double? radius;
  final VoidCallback? onPressed;
  final Color? borderColor;
  final EdgeInsets? contentPadding;

  const AppButton({
    super.key,
    required this.title,
    required this.color,
    this.icon,
    this.isEnable = true,
    required this.fontSize,
    required this.textColor,
    this.fontWeight,
    this.width,
    this.height,
    this.radius,
    this.onPressed,
    this.borderColor,
    this.contentPadding,
    this.heightText
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.6,
      child: GestureDetector(
        onTap: () {
          AppUtils.dismissKeyboard();
          if (!isEnable) return;
          onPressed?.call();
        },
        child: Container(
          // width: width ?? 300.w,
          // height: height ?? 50.h,
          width: width ?? double.infinity,
          padding: contentPadding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius ?? 100.w),
            border: Border.all(color: borderColor ?? color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 4.w),
              ],
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    height: heightText,
                    color: textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
