import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/data/dto/project/response/project_response.dart';
import 'package:solar_energy/presentation/common_widgets/app_network_image.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';

class ItemFactoryHoz extends StatelessWidget {
  const ItemFactoryHoz({super.key, required this.project});

  final ProjectResponse project;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        Navigator.pushNamed(context, RouteName.generalDevice);
      },
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              "https://i0.wp.com/mcnaircustomhomes.com/wp-content/uploads/2023/06/luxury-smart-home.jpg?resize=1536%2C1024&ssl=1",
              radius: 8.r,
              fit: BoxFit.cover,
              width: 100.w,
              height: 60.w,
            ),
            12.horizontalSpace,
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // project name - status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        project.name,
                        style: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.w),
                        decoration: BoxDecoration(
                          color: AppColors.green50.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(99.r),
                        ),
                      )
                    ],
                  ),
                  Text(
                    project.info,
                    style: AppTextStyle.tini
                        .copyWith(color: AppColors.textPrimary),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowItem({required String solarPower, required Widget iconSolar}) {
    return Row(
      children: [
        iconSolar,
        SizedBox(
          width: 4.w,
        ),
        Text(
          solarPower,
          style: AppTextStyle.tini.copyWith(color: AppColors.grey73),
        )
      ],
    );
  }
}
