import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
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
  late int selectedIndex = 0;
  late DeviceCubit cubit;

  @override
  void initState() {
    super.initState();
    index = ValueNotifier(0);
    controller = TabController(length: 3, vsync: this);
    meterType = getTypeDevice(widget.deviceResponse.meterTypeId);
    cubit = BlocProvider.of<DeviceCubit>(context);
  }

  String getSignalType(int meterTypeID) {
    switch (meterTypeID) {
      case 1:
        return "%";
      case 2:
      case 21:
      case 22:
        return LocalizationsUtils.localizations.power_kw;
      case 41:
        return LocalizationsUtils.localizations.water_flow_liters;
      default:
        return LocalizationsUtils.localizations.no_data;
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
          // device information
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r)),
            child: Column(
              children: [
                rowItem(
                    name: LocalizationsUtils.localizations.signal_type,
                    value: getSignalType(widget.deviceResponse.meterTypeId)),
                const Divider(
                  color: AppColors.greyFB,
                ),
                rowItem(
                    name: LocalizationsUtils.localizations.signal_point,
                    value: widget.deviceResponse.name),
                const Divider(
                  color: AppColors.greyFB,
                ),
                rowItem(
                  name: LocalizationsUtils.localizations.created_date,
                  value: DateTime.parse(
                          widget.deviceResponse.creationTime.toString())
                      .formatTime(),
                ),
                const Divider(
                  color: AppColors.greyFB,
                ),
                rowItem(
                  name: LocalizationsUtils.localizations.device_code,
                  value: widget.deviceResponse.serialNumber.toString(),
                ),
                const Divider(
                  color: AppColors.greyFB,
                ),
                rowItem(
                  name: "Trạng thái",
                  value: widget.deviceResponse.status == 1
                      ? "Hoạt động"
                      : "Ngừng hoạt động",
                ),
                const Divider(
                  color: AppColors.greyFB,
                ),
                widget.deviceResponse.meterTypeId == 81
                    ? rowItem(
                        name: "Đóng cắt thiết bị",
                        value: "",
                        widget: Container(
                          constraints: const BoxConstraints(maxHeight: 20.0),
                          child: Transform.scale(
                            scale: 0.6,
                            child: Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: widget.deviceResponse.status == 1,
                              onChanged: (_) =>
                                  cubit.switchCbs(widget.deviceResponse),
                              activeColor: AppColors.white,
                              activeTrackColor: AppColors.blueF8,
                              inactiveThumbColor: AppColors.white,
                              inactiveTrackColor: AppColors.grey,
                              trackOutlineColor:
                                  widget.deviceResponse.status == 1
                                      ? const WidgetStatePropertyAll(
                                          AppColors.blueF8)
                                      : const WidgetStatePropertyAll(
                                          AppColors.grey),
                            ),
                          ),
                        ))
                    : const SizedBox(),
              ],
            ),
          ),

          Gap(12.r),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    _tabItem(
                      title: "Thông số",
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 0);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text("/"),
                    ),
                    _tabItem(
                      title: "Biểu đồ",
                      index: 1,
                      selectedIndex: selectedIndex,
                      onTap: () {
                        setState(() => selectedIndex = 1);
                      },
                    ),
                  ],
                ),
                Container(
                  width: 110,
                  height: 1,
                  color: AppColors.textPrimary.withOpacity(0.2),
                ),
              ],
            ),
          ),

          // Statistical / Measurement
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
                        text: LocalizationsUtils.localizations.day,
                        height: 35.sp,
                      ),
                      Tab(
                        text: LocalizationsUtils.localizations.month,
                        height: 35.sp,
                      ),
                      Tab(
                        text: LocalizationsUtils.localizations.year,
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
                                selectTab: selectedIndex,
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
                                selectTab: selectedIndex,
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
                                selectTab: selectedIndex,
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

  Widget rowItem(
      {required String name, required String value, Widget? widget}) {
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
          child: widget != null
              ? Align(
                  alignment: Alignment.centerRight,
                  child: widget,
                )
              : Text(
                  value,
                  style: AppTextStyle.textSm.copyWith(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
        )
      ],
    );
  }

  Widget _tabItem({
    required String title,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: AppTextStyle.tini.copyWith(
          color: isSelected
              ? AppColors.blueF8
              : AppColors.textPrimary.withOpacity(0.5),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
