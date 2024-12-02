import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoDeviceScreen extends StatefulWidget {
  const InfoDeviceScreen({super.key});

  @override
  State<InfoDeviceScreen> createState() => _InfoDeviceScreenState();
}

class _InfoDeviceScreenState extends State<InfoDeviceScreen> {

  List<_SalesData> generateSalesData() {
    final random = Random();
    List<_SalesData> data = [];

    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 5) {
        String time =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        int value = (hour > 8 && hour < 16)
            ? random.nextInt(101)
            : 0; // Giá trị từ 0 đến 100

        data.add(_SalesData(time, value));
      }
    }

    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r)
      ),

      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          children: [
            rowItem(name: "Loại tín hiệu", value: "Công suất (kW)"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Điểm tín hiệu", value: "Tổng công suất đầu vào(kW)"),
            const Divider(color: AppColors.greyFB,),
            rowItem(name: "Ngày", value: "27/11/2024"),
            Gap(16.h),

            SizedBox(height: 1.sw/2,
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
                    axisLabelFormatter: (AxisLabelRenderDetails details) {
                      return ChartAxisLabel(
                          '${details.value} kW',
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
                      format: 'point.y kW',
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
              Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary.withOpacity(0.5), size: 15.w,)
            ],
          ),
        )
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final int sales;
}