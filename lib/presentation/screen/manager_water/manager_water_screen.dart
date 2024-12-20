import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/alarm_water/widget/item_alarm_water.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../gen/assets.gen.dart';

class ManagerWaterScreen extends StatefulWidget {
  const ManagerWaterScreen({super.key});

  @override
  State<ManagerWaterScreen> createState() => _ManagerWaterScreenState();
}

class _ManagerWaterScreenState extends State<ManagerWaterScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  List<_SalesData> generateSalesData() {
    final random = Random();
    List<_SalesData> data = [];

    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 5) {
        String time =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        int value = (hour > 8 && hour < 16)
            ? random.nextInt(30)
            : 0; // Giá trị từ 0 đến 100

        data.add(_SalesData(time, value));
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "Quản lý nước",
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng quan",
                      style: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Lottie.asset(
                              Assets.images.waterLottie,
                              controller: _controller,
                              height: 1.sw / 4,
                              onLoaded: (composition) {
                                _controller
                                  ..duration = composition.duration
                                  ..repeat(reverse: true);
                              },
                            ),
                            Center(
                                child: Text(
                              "3,6 L",
                              style: AppTextStyle.textBase.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                        Gap(12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icons.faucet.svg(
                                    width: 14.w,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.blueF8, BlendMode.srcIn)),
                                Gap(4.w),
                                Text(
                                  "Tiêu thụ: 27 Lít",
                                  style: AppTextStyle.textXs.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                            Gap(4.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icons.usdCircle.svg(
                                    width: 14.w,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.blueF8, BlendMode.srcIn)),
                                Gap(4.w),
                                Text(
                                  "Số tiền: 270,000,000 Đồng",
                                  style: AppTextStyle.textXs.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                            Gap(4.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.icons.arrowDownStrenght.svg(
                                    width: 14.w,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.blueF8, BlendMode.srcIn)),
                                Gap(4.w),
                                Text(
                                  "Áp suất: 9800 Pa",
                                  style: AppTextStyle.textXs
                                      .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Gap(12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cảnh báo gần nhất",
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.allAlarmWater);
                          },
                            child: Text(
                          "Xem thêm",
                          style: AppTextStyle.textXs.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.blueF8),
                        ))
                      ],
                    ),
                    Gap(12.h),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => const ItemAlarmWater(),
                        separatorBuilder: (context, index) => const Divider(
                              color: AppColors.greyFB,
                            ),
                        itemCount: 3)
                  ],
                ),
              ),
              Gap(12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Text(
                      "Số nước tiêu thụ",
                      style: AppTextStyle.textSm.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    Gap(12.h),
                    SizedBox(
                      height: 1.sw / 2,
                      child: SfCartesianChart(
                          // Enable legend
                          legend: const Legend(isVisible: false),
                          primaryXAxis: CategoryAxis(
                            labelStyle: AppTextStyle.textXs
                                .copyWith(color: AppColors.textPrimary),
                            desiredIntervals: 10,
                            labelRotation: 0,
                          ),
                          primaryYAxis: NumericAxis(
                            axisLabelFormatter:
                                (AxisLabelRenderDetails details) {
                              return ChartAxisLabel(
                                  '${details.value} L',
                                  AppTextStyle.textXs
                                      .copyWith(color: AppColors.textPrimary));
                            },
                          ),
                          // Enable tooltip
                          //tooltipBehavior: TooltipBehavior(enable: true, shared: true),
                          trackballBehavior: TrackballBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap,
                            hideDelay: 2500,
                            tooltipAlignment: ChartAlignment.center,
                            tooltipDisplayMode:
                                TrackballDisplayMode.groupAllPoints,
                            // Hiển thị tất cả series
                            tooltipSettings: InteractiveTooltip(
                              enable: true,
                              format: 'point.y L',
                              color: Colors.black.withOpacity(0.7),
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            // tooltipSettings: const InteractiveTooltip(
                            //   enable: true,
                            //   format: 'point.y kW',
                            // ),
                          ),
                          zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                              enablePinching: true,
                              enableDoubleTapZooming: true,
                              zoomMode: ZoomMode.x),
                          series: <CartesianSeries<_SalesData, String>>[
                            SplineSeries<_SalesData, String>(
                                dataSource: generateSalesData(),
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                color: const Color(0xFF1dd1a1),
                                name: 'Công suất PV',
                                // Enable data label
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false)),
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}
