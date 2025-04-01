

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';

import 'package:solar_energy/presentation/common_widgets/app_load_more.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/screen/Electricity/bloc/electric_cubit.dart';
import 'package:solar_energy/presentation/screen/overview/widget/saving_energy.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../../../application/cubit/app_cubit.dart';
import '../../../data/dto/project/response/project_response.dart';
import '../../common_widgets/app_loading.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key, required this.project});

  final PowerStationResponse project;

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  late ElectricCubit cubit;
  double cosFi = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<ElectricCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      cubit.getElectric(widget.project.id);
      cosFi = double.tryParse(cubit.state.response.data?.lastedLogData.paramPf ?? "0") ?? 0;
    });

  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
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
          widget.project.name,
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: AppColors.greyFB,
      body: BlocConsumer<ElectricCubit, ElectricState>(
        listener: (BuildContext context, ElectricState state) {
          state.response.when(
              loading: () => BlocProvider.of<AppCubit>(context).showLoading(),
              success: (data) =>
                  BlocProvider.of<AppCubit>(context).hideShowLoading(),
              error: (error) =>
                  BlocProvider.of<AppCubit>(context).hideShowLoading());
        },
        // listener: (context, state) {
        //   if (state.loadStatus == LoadStatus.loading) {
        //     String error = "";
        //     showDialog(context: context, builder: (context) => const AppLoading(), barrierDismissible: false);
        //     Future.delayed(const Duration(seconds: 15),() {
        //       if(Navigator.canPop(context)){
        //         Navigator.pop(context);
        //         error = "Kết nối không ổn định !!!";
        //       }
        //       if(error == "Kết nối không ổn định !!!"){
        //         AppToast.showToastError(context, title: error);
        //       }
        //     },);
        //   }
        //   if (state.loadStatus == LoadStatus.failure) {
        //     if (Navigator.canPop(context)) {
        //       Navigator.pop(context);
        //     }
        //   }
        //   if (state.loadStatus == LoadStatus.success) {
        //     if (Navigator.canPop(context)) {
        //       Navigator.pop(context);
        //     }
        //   }
        // },
        builder:(context, state) =>  AppLoadMore(
          onRefresh: () => cubit.getElectric(widget.project.id),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
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
                        padding: EdgeInsets.only(bottom: 8.h),
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
                                  minimum: 0,
                                  maximum: 600,
                                  interval: 250,
                                  minorTicksPerInterval: 5,
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0,
                                    color: Colors.transparent,
                                  ),
                                  majorTickStyle: const MajorTickStyle(
                                    length: 5,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  minorTickStyle: const MinorTickStyle(
                                    length: 3,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: 0,
                                        endValue: 600,
                                        endWidth: 2,
                                        startWidth: 2,
                                        color: Colors.black),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: double.tryParse(state.response.data?.lastedLogData.paramUa ?? "0") ?? 0,
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
                                              borderRadius:
                                                  BorderRadius.circular(4.r)),
                                          child: Text('${state.response.data?.lastedLogData.paramUa} V',
                                              style: AppTextStyle.tini.copyWith(
                                                  color:
                                                      AppColors.textPrimary)),
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
                                    minorTicksPerInterval: 5,
                                    axisLineStyle: const AxisLineStyle(
                                      thickness: 0,
                                      color: Colors.transparent,
                                      cornerStyle: CornerStyle.endCurve,
                                    ),
                                    minimum: 0,
                                    maximum: 1000,
                                    majorTickStyle: const MajorTickStyle(
                                      length: 5,
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    minorTickStyle: const MinorTickStyle(
                                      length: 3,
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: 0,
                                          endValue: 1000,
                                          endWidth: 3,
                                          startWidth: 3,
                                          color: Colors.black),
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                        value: double.tryParse(state.response.data?.lastedLogData.paramIa ?? "0") ?? 0,
                                        needleEndWidth: 5,
                                        enableAnimation: true,
                                      ),
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.r,
                                                  vertical: 2.r),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(4.r)),
                                              child: Text('${state.response.data?.lastedLogData.paramIa} Am',
                                                  style: AppTextStyle.tini
                                                      .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                          fontWeight: FontWeight
                                                              .w700))),
                                          angle: 90,
                                          positionFactor:
                                              isPortrait ? 0.3 : 0.2)
                                    ])
                              ]),
                            ),

                            // cos phi
                            Expanded(
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                  canScaleToFit: true,
                                  startAngle: isPortrait ? 238 : 180,
                                  endAngle: 360,
                                  showLastLabel: true,
                                  showFirstLabel: true,
                                  showAxisLine: true,
                                  interval: 0.5,
                                  minimum: -1,
                                  maximum: 1,
                                  labelOffset: 10,
                                  // Mặc định cho các số bên trong
                                  axisLineStyle: const AxisLineStyle(
                                    thickness: 0,
                                    color: Colors.transparent,
                                    cornerStyle: CornerStyle.endCurve,
                                  ),
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: -1,
                                      endValue: 1,
                                      endWidth: 2,
                                      startWidth: 2,
                                      color: Colors.black,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: -1 + (double.tryParse(state.response.data?.lastedLogData.paramPf ?? "0") ?? 0),
                                      needleEndWidth: 1,
                                      enableAnimation: true,
                                      needleLength: 0.4,
                                    ),
                                  ],
                                  majorTickStyle: const MajorTickStyle(
                                    length: 5,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  minorTickStyle: const MinorTickStyle(
                                    length: 3,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Text(
                                        '${double.tryParse(state.response.data?.lastedLogData.paramPf ?? "0") ?? 0} Cosφ',
                                        style: AppTextStyle.tini.copyWith(
                                            color: AppColors.textPrimary),
                                      ),
                                      angle: isPortrait ? 55 : 90,
                                      positionFactor: isPortrait ? 0.4 : 0.3,
                                    ),
                                    GaugeAnnotation(
                                      widget: Text(
                                        'IND',
                                        style: AppTextStyle.tini.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      angle: isPortrait ? 250 : 175,
                                      positionFactor: isPortrait ? 1.2 : 1,
                                    ),
                                    GaugeAnnotation(
                                      widget: Text(
                                        'CAP',
                                        style: AppTextStyle.tini.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      angle: isPortrait ? 370 : 5,
                                      positionFactor: isPortrait ? 1 : 1,
                                    ),
                                  ],
                                  onLabelCreated: (AxisLabelCreatedArgs args) {
                                    final double? labelValue =
                                        double.tryParse(args.text.toString());

                                    if (labelValue == -1 || labelValue == 1) {
                                      args.text = '';
                                    } else if (labelValue == 0.0) {
                                      args.text = '1';
                                    } else {
                                      args.text = '${labelValue?.abs()}';
                                    }
                                  },
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                      // isPortrait ? 16.verticalSpace : 32.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.r, vertical: 4.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Center(
                                child: Text(
                                    '${state.response.data?.lastedLogData.thd ?? 0}% THD',
                                    style: AppTextStyle.tini.copyWith(
                                        color: AppColors.textPrimary)),
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.r, vertical: 4.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Center(
                                child: Text(
                                    '${(double.tryParse(state.response.data?.lastedLogData.ct ?? "0") ?? 0.0) *
                                        (double.tryParse(state.response.data?.lastedLogData.paramEpi ?? "0") ?? 0.0)} Kw/h',
                                    style: AppTextStyle.tini.copyWith(
                                        color: AppColors.textPrimary)),
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.r, vertical: 4.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r)),
                              child: Center(
                                child: Text('50 Hz',
                                    style: AppTextStyle.tini.copyWith(
                                        color: AppColors.textPrimary)),
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
        ),
      ),
    );
  }
}
