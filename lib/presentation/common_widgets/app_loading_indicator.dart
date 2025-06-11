import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solar_energy/application/constants/app_color.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? widthFactor;
  final double? sizeLoading;

  const AppLoadingIndicator({
    super.key,
    this.color,
    this.widthFactor,
    this.sizeLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: widthFactor,
      child: SpinKitFadingCircle(
        size: sizeLoading ?? 30.r,
        duration: const Duration(milliseconds: 1000),
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
