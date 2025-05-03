import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../statistical/bloc/statistical_cubit.dart';
import '../statistical/estatictical/bloc/estatistical_cubit.dart';
import '../statistical/estatictical/estatistical_screen.dart';
import '../statistical/widget/detail_widget.dart';

class InfoDeviceScreen extends StatefulWidget {
  const InfoDeviceScreen({super.key, required this.deviceResponse});

  final DeviceResponse deviceResponse;

  @override
  State<InfoDeviceScreen> createState() => _InfoDeviceScreenState();
}

class _InfoDeviceScreenState extends State<InfoDeviceScreen>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<int> index;
  late final TabController controller;
  late final ElectricType meterType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = ValueNotifier(0);
    controller = TabController(length: 3, vsync: this);
    meterType = getTypeDevice(widget.deviceResponse.meterTypeId);
  }

  String getSignalType(int meterTypeID) {
    switch (meterTypeID) {
      case 1:
        return "%";
      case 2:
      case 21:
      case 22:
        return "Công suất (Kw)";
      case 41:
        return "Lưu lượng nước (Lit)";
      default:
        return "Không có";
    }
  }

  ElectricType getTypeDevice(int meterTypeID) {
    switch (meterTypeID) {
      case 1:
        return ElectricType.humidity;
      case 2:
        return ElectricType.saveElectric;
      case 21:
      case 22:
        return ElectricType.solarElectric;
      case 41:
        return ElectricType.water;
      default:
        return ElectricType.meterNull;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r)),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                children: [
                  rowItem(
                      name: "Loại tín hiệu",
                      value: getSignalType(widget.deviceResponse.meterTypeId)),
                  const Divider(
                    color: AppColors.greyFB,
                  ),
                  rowItem(
                      name: "Điểm tín hiệu", value: widget.deviceResponse.name),
                  const Divider(
                    color: AppColors.greyFB,
                  ),
                  rowItem(
                    name: "Ngày tạo",
                    value: DateTime.parse(
                            widget.deviceResponse.creationTime.toString())
                        .formatTime(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            margin: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.sp),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyDF.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: "Ngày",
                        height: 35.sp,
                      ),
                      Tab(
                        text: "Tháng",
                        height: 35.sp,
                      ),
                      Tab(
                        text: "Năm",
                        height: 35.sp,
                      ),
                    ],
                    controller: controller,
                    labelStyle: AppTextStyle.textSm.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.blueEA,
                        fontWeight: FontWeight.w500),
                    indicatorColor: AppColors.blueFD,
                    unselectedLabelColor: AppColors.grey73,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: AppColors.blueFD.withOpacity(0.8)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 0,
                    dividerColor: Colors.transparent,
                    onTap: (value) {
                      index.value = value;
                    },
                  ),
                ),
                Gap(12.sp),
                ValueListenableBuilder(
                    valueListenable: index,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          BlocProvider(
                            create: (context) => EStatisticalCubit(
                                DateRangePickerView.month,
                                widget.deviceResponse.id),
                            child: Visibility(
                              visible: value == 0,
                              child: EStatisticalScreen(
                                meterId: widget.deviceResponse.id,
                              ),
                            ),
                          ),
                          BlocProvider(
                            create: (context) => EStatisticalCubit(
                                DateRangePickerView.year,
                                widget.deviceResponse.id),
                            child: Visibility(
                              visible: value == 1,
                              child: EStatisticalScreen(
                                meterId: widget.deviceResponse.id,
                              ),
                            ),
                          ),
                          BlocProvider(
                            create: (context) => EStatisticalCubit(
                                DateRangePickerView.decade,
                                widget.deviceResponse.id),
                            child: Visibility(
                              visible: value == 2,
                              child: EStatisticalScreen(
                                meterId: widget.deviceResponse.id,
                              ),
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rowItem({required String name, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            name,
            style: AppTextStyle.textSm.copyWith(
                color: AppColors.textPrimary.withOpacity(0.5),
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyle.textSm.copyWith(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.right,
              ),
              //Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary.withOpacity(0.5), size: 15.w,)
            ],
          ),
        )
      ],
    );
  }
}
