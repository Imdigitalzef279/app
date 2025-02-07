import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/presentation/screen/overview/widget/saving_energy.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.only(left: 4.sp),
              child: Icon(Icons.arrow_back_ios, size: 16.sp)),
        ),
        title: Text(
          "Thien son",
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.greyFB,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyDF.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tổng quan",
                    style: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700),
                  ),
                  8.verticalSpace,
                  Container(
                    height: 150,
                    child: Row(
                      children: [
                        Expanded(
                          child: SfRadialGauge(axes: <RadialAxis>[
                            RadialAxis(
                              labelsPosition: ElementsPosition.inside,
                              // Adjusted to 'inside'
                              canScaleToFit: true,
                              startAngle: 180,
                              endAngle: isPortrait ? 302 : 360,
                              showLastLabel: false,
                              showLabels: true,
                              axisLabelStyle: const GaugeTextStyle(
                                color: AppColors.textPrimary,
                                fontFamily: 'BeVietNamPro',
                                fontSize: 9
                              ),
                              minimum: 0,
                              maximum: 600,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0,
                                color: Colors.transparent,
                              ),
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 350,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 350,
                                    endValue: 600,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.red),
                              ],
                              pointers: const <GaugePointer>[
                                NeedlePointer(
                                  value: 300,
                                  needleEndWidth: 1,
                                  enableAnimation: true,
                                  needleLength: 0.4,
                                )
                                // MarkerPointer(
                                //   value: -220,
                                //   enableAnimation: true,
                                //   elevation: 2,
                                //   markerHeight: 10,
                                //   markerOffset: -9,
                                //   color: AppColors.blueF8,
                                // )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 2.r),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.blueF8.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                      child: Text('300 V',
                                          style: AppTextStyle.tini.copyWith(
                                              color: AppColors.white)),
                                    ),
                                    angle: isPortrait ? 125 : 90,
                                    positionFactor: isPortrait ? 0.4 : 0.3)
                              ],
                              onLabelCreated: (AxisLabelCreatedArgs args) {
                                // Convert the negative value to positive
                                final int? labelValue =
                                    int.tryParse(args.text.toString());
                                args.text = '${labelValue?.abs()}';
                              },
                            ),
                          ]),
                        ),
                        Expanded(
                          child: SfRadialGauge(axes: <RadialAxis>[
                            RadialAxis(
                                canScaleToFit: true,
                                startAngle: 180,
                                endAngle: 360,
                                radiusFactor: 1.5,
                                interval: 200,
                                axisLineStyle: const AxisLineStyle(
                                  thickness: 0,
                                  color: Colors.transparent,
                                  cornerStyle: CornerStyle.endCurve,
                                ),
                                minimum: 0,
                                maximum: 1000,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                    startValue: 0,
                                    endValue: 300,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.green,
                                  ),
                                  GaugeRange(
                                      startValue: 300,
                                      endValue: 600,
                                      endWidth: 5,
                                      startWidth: 5,
                                      color: Colors.orange),
                                  GaugeRange(
                                      startValue: 600,
                                      endValue: 1000,
                                      endWidth: 5,
                                      startWidth: 5,
                                      color: Colors.red)
                                ],
                                pointers: const <GaugePointer>[
                                  NeedlePointer(
                                    value: 90,
                                    needleEndWidth: 5,
                                    enableAnimation: true,
                                  ),
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      widget: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.r, vertical: 2.r),
                                          decoration: BoxDecoration(
                                              color: AppColors.blueF8
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4.r)),
                                          child: Text('90.0 Am',
                                              style: AppTextStyle.tini
                                                  .copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                      angle: 90,
                                      positionFactor: isPortrait ? 0.3 : 0.2)
                                ])
                          ]),
                        ),
                        Expanded(
                          child: SfRadialGauge(axes: <RadialAxis>[
                            RadialAxis(
                              canScaleToFit: true,
                              startAngle: isPortrait ? 238 : 180,
                              endAngle: 360,
                              showLastLabel: false,
                              showFirstLabel: false,
                              showAxisLine: true,
                              interval: 0.5,
                              minimum: -1,
                              maximum: 1,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0,
                                color: Colors.transparent,
                                cornerStyle: CornerStyle.endCurve,
                              ),
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: -5,
                                    endValue: -1,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.red),
                                GaugeRange(
                                    startValue: -1,
                                    endValue: 1,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.orange),
                                GaugeRange(
                                    startValue: 1,
                                    endValue: 5,
                                    endWidth: 5,
                                    startWidth: 5,
                                    color: Colors.green),
                              ],
                              pointers: const <GaugePointer>[
                                NeedlePointer(
                                  value: 0,
                                  needleEndWidth: 1,
                                  enableAnimation: true,
                                  needleLength: 0.4,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.r, vertical: 2.r),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.blueF8.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4.r)),
                                      child: Text(
                                        '1 Cosφ',
                                        style: AppTextStyle.tini
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                    angle: isPortrait ? 55 : 90,
                                    positionFactor: isPortrait ? 0.4 : 0.3)
                              ],
                              onLabelCreated: (AxisLabelCreatedArgs args) {
                                final double? labelValue =
                                    double.tryParse(args.text.toString());
                                if (labelValue == 0.0) {
                                  args.text = '1';
                                } else {
                                  args.text = '.${labelValue?.abs()}';
                                }
                              },
                            )
                          ]),
                        )
                      ],
                    ),
                  ),

                  isPortrait ? 16.verticalSpace : 32.verticalSpace,

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.r, vertical: 4.r),
                          decoration: BoxDecoration(
                              color:
                              AppColors.blueF8.withOpacity(0.5),
                              borderRadius:
                              BorderRadius.circular(4.r)),
                          child: Center(
                            child: Text('15% THD',
                                style: AppTextStyle.tini.copyWith(
                                    color: AppColors.white)),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.r, vertical: 4.r),
                          decoration: BoxDecoration(
                              color:
                              AppColors.blueF8.withOpacity(0.5),
                              borderRadius:
                              BorderRadius.circular(4.r)),
                          child: Center(
                            child: Text('220 Kw/h',
                                style: AppTextStyle.tini.copyWith(
                                    color: AppColors.white)),
                          ),
                        ),
                      ),
                       8.horizontalSpace,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.r, vertical: 4.r),
                          decoration: BoxDecoration(
                              color:
                              AppColors.blueF8.withOpacity(0.5),
                              borderRadius:
                              BorderRadius.circular(4.r)),
                          child: Center(
                            child: Text('60 Hz',
                                style: AppTextStyle.tini.copyWith(
                                    color: AppColors.white)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            12.verticalSpace,
            const SavingEnergy()
          ],
        ),
      ),
    );
  }
}
