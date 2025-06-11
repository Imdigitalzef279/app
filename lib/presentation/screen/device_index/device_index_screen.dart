import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../../../gen/assets.gen.dart';
import '../manager_water/bloc/manager_water_cubit.dart';

class DeviceIndexScreen extends StatefulWidget {
  const DeviceIndexScreen({super.key});

  @override
  State<DeviceIndexScreen> createState() => _DeviceIndexScreenState();
}

class _DeviceIndexScreenState extends State<DeviceIndexScreen> {
  late final ManagerWaterCubit _cubit;
  late final ManagerWaterState managerWaterState;
  final List<WaterIndexModel> indexItem = [
    WaterIndexModel(
        icon: Assets.icons.bacterium.path,
        title: "Vi sinh vật",
        unit: "wH",
        value: 25,
        limit: 20,
        isConnected: true),
    WaterIndexModel(
        icon: Assets.icons.flask.path,
        title: "hóa học",
        unit: "wH",
        value: 45.5,
        limit: 100,
        isConnected: true),
    WaterIndexModel(
        icon: Assets.icons.physics.path,
        title: "Vật lý",
        unit: "wH",
        value: 8,
        limit: 10,
        isConnected: true),
    WaterIndexModel(
        icon: Assets.icons.flaskGear.path,
        title: "Hóa lý đặc biệt",
        unit: "wH",
        value: 5.23,
        limit: 20,
        isConnected: false),
    WaterIndexModel(
        icon: Assets.icons.bacteria.path,
        title: "Sinh học",
        unit: "wH",
        value: 25,
        limit: 20,
        isConnected: true),
    WaterIndexModel(
        icon: Assets.icons.air.path,
        title: "Khí độc",
        unit: "wH",
        value: 45.5,
        limit: 100,
        isConnected: true),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = BlocProvider.of<ManagerWaterCubit>(context);
    managerWaterState = ManagerWaterState.init();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Wrap(
        runSpacing: 12.sp,
        spacing: 8.sp,
        children: List.generate(
            indexItem.length, (index) => itemWaterIndex(indexItem[index])),
      ),
    );
  }

  Widget itemWaterIndex(WaterIndexModel waterIndex) {
    Color color = _cubit.handleColorStatus(waterIndex);
    return Stack(
      children: [
        Container(
          width: (1.sw - 40.sp) / 2,
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: color.withOpacity(0.2)),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    waterIndex.title,
                    style: AppTextStyle.textXs
                        .copyWith(color: AppColors.grey4D, fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.sp),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: waterIndex.value.toString(),
                        style: AppTextStyle.textSm.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.textPrimary)),
                    TextSpan(
                        text: ' ${waterIndex.unit}',
                        style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.grey4D)),
                  ])),
                  Gap(4.sp),
                  Text(
                      waterIndex.limit != null
                          ? "Giới hạn: <= ${waterIndex.limit}"
                          : "Không giới hạn",
                      style: AppTextStyle.textXs
                          .copyWith(color: AppColors.grey73, fontSize: 12.sp))
                ],
              ),
            ),
            Gap(12.sp),
            SvgPicture.asset(
              waterIndex.icon,
              width: 20.sp,
              height: 20.sp,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ]),
        ),
      ],
    );
  }
}
