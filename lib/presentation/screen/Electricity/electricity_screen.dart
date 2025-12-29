import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/localizations.dart';

import 'package:solar_energy/data/dto/power_station/response/power_station_response.dart';
import 'package:solar_energy/gen/assets.gen.dart';

import 'package:solar_energy/presentation/common_widgets/app_load_more.dart';

import 'package:solar_energy/presentation/screen/Electricity/bloc/electric_cubit.dart';
import 'package:solar_energy/presentation/screen/Electricity/widget/item_data_electric.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../../../application/cubit/app_cubit.dart';

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
    super.initState();
    cubit = BlocProvider.of<ElectricCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      cubit.getElectric(widget.project.id);
      cosFi = double.tryParse(
              cubit.state.response.data?.lastedLogData.paramPf ?? "0") ??
          0;
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
        builder: (context, state) => AppLoadMore(
          // onRefresh: () => cubit.getElectric(widget.project.id),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                // overview
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
                        LocalizationsUtils.localizations.overview,
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
                            // Ua
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
                                      value: double.tryParse(state.response.data
                                                  ?.lastedLogData.paramUa ??
                                              "0") ??
                                          0,
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
                                          child: Text(
                                              '${state.response.data?.lastedLogData.paramUa} V',
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
                            // Ia
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
                                        value: double.tryParse(state
                                                    .response
                                                    .data
                                                    ?.lastedLogData
                                                    .paramIa ??
                                                "0") ??
                                            0,
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
                                              child: Text(
                                                  '${state.response.data?.lastedLogData.paramIa} Am',
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
                                      value: -1 +
                                          (double.tryParse(state.response.data
                                                      ?.lastedLogData.paramPf ??
                                                  "0") ??
                                              0),
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
                          // Expanded(
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 4.r, vertical: 4.r),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(4.r)),
                          //     child: Center(
                          //       child: Text(
                          //           '${state.response.data?.lastedLogData.thd ?? 0}% THD',
                          //           style: AppTextStyle.tini.copyWith(
                          //               color: AppColors.textPrimary)),
                          //     ),
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.r, vertical: 4.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'EPI: ',
                                        style: AppTextStyle.textXs.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ((double.tryParse(state
                                                        .response
                                                        .data
                                                        ?.lastedLogData
                                                        .paramEpi ??
                                                    "0") ??
                                                0.0))
                                            .toStringAsFixed(2),
                                        style: AppTextStyle.textXs.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // TextSpan(
                                      //   text: ' kWh',
                                      //   style: AppTextStyle.tini.copyWith(
                                      //     color: AppColors.textPrimary,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.r, vertical: 4.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'CT: ',
                                        style: AppTextStyle.textXs.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: state.response.data?.lastedLogData
                                                .ct ??
                                            "0",
                                        style: AppTextStyle.textXs.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // TextSpan(
                                      //   text: ' kWh',
                                      //   style: AppTextStyle.tini.copyWith(
                                      //     color: AppColors.textPrimary,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                12.verticalSpace,

                //data
                // itemContainerElectric(title: "⚡ Điện áp & Dòng điện"),
                // 8.verticalSpace,
                // itemContainerElectric(title: "🔌 Công suất"),
                // 8.verticalSpace,
                // itemContainerElectric(title: "🌀 Công suất phản kháng"),

                // 3-phase specifications
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
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
                            "Thông số 3 pha: ",
                            style: AppTextStyle.textSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary),
                          ),
                          Gap(12.h),
                          Table(
                            border: TableBorder.all(
                              color: AppColors.greyDF.withOpacity(0.6),
                              width: 1,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(1.2),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                            },
                            children: [
                              _buildTableRow(['', 'A', 'B', 'C'],
                                  isHeader: true),
                              _buildTableRow([
                                'U',
                                state.response.data?.lastedLogData.paramUa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramUb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramUc
                                        .toString() ??
                                    "0,0",
                              ]),
                              _buildTableRow([
                                'I',
                                state.response.data?.lastedLogData.paramIa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramIb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramIc
                                        .toString() ??
                                    "0,0",
                              ]),
                              _buildTableRow([
                                'P',
                                state.response.data?.lastedLogData.paramPa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramPb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramPc
                                        .toString() ??
                                    "0,0",
                              ]),
                              _buildTableRow([
                                'Q',
                                state.response.data?.lastedLogData.paramQa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramQb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.paramQc
                                        .toString() ??
                                    "0,0",
                              ]),
                            ],
                          ),
                          Gap(12.r),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "P Tổng: ${state.response.data?.lastedLogData.paramP.toString() ?? "0,0"} kW",
                                style: AppTextStyle.textXs.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary),
                              ),
                              Text(
                                "Q Tổng: ${state.response.data?.lastedLogData.paramQ.toString() ?? "0,0"} kVAR",
                                style: AppTextStyle.textXs.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary),
                              ),
                            ],
                          )
                        ])),

                Gap(8.r),

                // Harmonic wave
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
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
                            "Sóng hài: ",
                            style: AppTextStyle.textSm.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary),
                          ),
                          Gap(12.h),
                          Table(
                            border: TableBorder.all(
                              color: AppColors.greyDF.withOpacity(0.6),
                              width: 1,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(1.2),
                              1: FlexColumnWidth(2),
                              2: FlexColumnWidth(2),
                              3: FlexColumnWidth(2),
                            },
                            children: [
                              _buildTableRow(['THD', 'A', 'B', 'C'],
                                  isHeader: true),
                              _buildTableRow([
                                'U',
                                state.response.data?.lastedLogData.thdUa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.thdUb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.thdUc
                                        .toString() ??
                                    "0,0",
                              ]),
                              _buildTableRow([
                                'I',
                                state.response.data?.lastedLogData.thdIa
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.thdIb
                                        .toString() ??
                                    "0,0",
                                state.response.data?.lastedLogData.thdIc
                                        .toString() ??
                                    "0,0",
                              ]),
                            ],
                          ),
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemContainerElectric({required String title}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
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
              title,
              style: AppTextStyle.textSm.copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            Gap(12.h),
            Wrap(
                direction: Axis.horizontal,
                runSpacing: 16.r,
                spacing: 12.r,
                children: [
                  ItemDataElectric(
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.blueFF,
                      title: LocalizationsUtils.localizations.peak_output,
                      content: "2,37",
                      unit: "Kw"),
                  ItemDataElectric(
                      path: Assets.icons.revenue.path,
                      color: AppColors.orange43,
                      title: LocalizationsUtils.localizations.off_peak_output,
                      content: "12,43",
                      unit: "Kw"),
                  ItemDataElectric(
                      path: Assets.icons.square.path,
                      color: AppColors.green50,
                      title: LocalizationsUtils.localizations.normal_output,
                      content: "5,77",
                      unit: "Kw"),
                  ItemDataElectric(
                      path: Assets.icons.thunderstormSun6854078.path,
                      color: AppColors.grey,
                      title: LocalizationsUtils.localizations.total_cost,
                      content: "100,372",
                      unit: "Dong"),
                ])
          ],
        ));
  }

  Widget tableText(String text, {bool isHeader = false}) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyle.textXs.copyWith(
          fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    List<String> values, {
    bool isHeader = false,
  }) {
    return TableRow(
      decoration: isHeader
          ? BoxDecoration(
              color: AppColors.blueF8,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r)))
          : null,
      children: values.map((e) {
        return Container(
          height: 36.h,
          alignment: Alignment.center,
          child: Text(
            e,
            textAlign: TextAlign.center,
            style: AppTextStyle.textXs.copyWith(
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
              color: isHeader ? AppColors.white : AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
