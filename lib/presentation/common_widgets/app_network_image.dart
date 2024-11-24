import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/gen/assets.gen.dart';

import 'app_loading_indicator.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? radius;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final bool isShowBorder;

  const AppNetworkImage(this.url,
      {super.key,
      this.radius,
      this.fit,
      this.width,
      this.height,
      this.errorWidget,
      this.isShowBorder = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: url,
        width: width,
        height: height,
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius ?? 8.r),
                  border: isShowBorder
                      ? Border.all(color: AppColors.greyF6)
                      : null),
              width: width ?? 150.w,
              height: height ?? 150.w,
              child: Center(
                  child: Image.asset(
                Assets.images.exclamation.path,
                width: 100.r,
                height: 100.r,
              )),
            ),
        placeholder: (context, url) => SizedBox(
          width: width ?? 150.w,
          height: height ?? 150.w,
          child: const Center(child: AppLoadingIndicator()),
        ),
      ),
    );
  }
}
