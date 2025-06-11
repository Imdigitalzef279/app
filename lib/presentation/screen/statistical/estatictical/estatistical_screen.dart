import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/enums/search_type.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/data/dto/electric/chart_electric/chart_electric_request.dart';
import 'package:solar_energy/presentation/screen/statistical/estatictical/bloc/estatistical_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../application/constants/app_color.dart';
import '../../../../application/constants/app_text_style.dart';
import '../../../../application/cubit/app_cubit.dart';
import '../../../common_widgets/app_toast.dart';
import '../bloc/statistical_cubit.dart';
import '../widget/descrip.dart';

class EStatisticalScreen extends StatefulWidget {
  const EStatisticalScreen({super.key, required this.meterId});

  final int meterId;

  @override
  State<EStatisticalScreen> createState() => _EStatisticalScreenState();
}

class _EStatisticalScreenState extends State<EStatisticalScreen>
    with AutomaticKeepAliveClientMixin {
  late final EStatisticalCubit _cubit;
  late bool selectPV;
  late bool selectNet;
  late bool selectConsumer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectPV = true;
    selectNet = true;
    selectConsumer = true;
    _cubit = BlocProvider.of<EStatisticalCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      DateTime now = DateTime.now();
      _cubit.changDateTime(now);
      _cubit.changeMeterId();
      _cubit.getChartElectric();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<EStatisticalCubit, EStatisticalState>(
      listenWhen: (previous, current) =>
          previous.resultChart != current.resultChart,
      listener: (BuildContext context, EStatisticalState state) {
        state.resultChart.when(
            loading: () => BlocProvider.of<AppCubit>(context).showLoading(),
            success: (data) =>
                BlocProvider.of<AppCubit>(context).hideShowLoading(),
            error: (error) {
              BlocProvider.of<AppCubit>(context).hideShowLoading();
              AppToast.showToastError(title: error);
            });
      },
      builder: (BuildContext context, EStatisticalState state) {
        return Column(
          children: [
            _buildDateTime(),
            // Gap(12.sp),
            // _buildOutput(),
            // Gap(12.sp),
            // _buildUsed(),
            Gap(22.sp),
            _buildChart()
          ],
        );
      },
    );
  }

  Widget _buildDateTime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.sp),
      child: InkWell(
        onTap: () {
          showDatePicker(_cubit.typeDate);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.chevron_left_rounded,
              size: 20.sp,
            ),
            Text(
              _cubit.dateTimeFormatted,
              style: AppTextStyle.textSm.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            SfCartesianChart(
                legend: const Legend(isVisible: false),
                primaryXAxis: CategoryAxis(
                  labelStyle: AppTextStyle.textXs.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                primaryYAxis: NumericAxis(
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    return ChartAxisLabel(
                        details.value.toDouble().toKWhFormatted,
                        AppTextStyle.textXs.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400));
                  },
                ),
                // Enable tooltip
                //tooltipBehavior: TooltipBehavior(enable: true, shared: true),
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  hideDelay: 2500,
                  tooltipAlignment: ChartAlignment.center,
                  tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                  // Hiển thị tất cả series
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'point.y KWh',
                    color: Colors.black.withOpacity(0.7),
                    textStyle: AppTextStyle.textXs.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400),
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
                series: <CartesianSeries<SalesData, String>>[
                  SplineSeries<SalesData, String>(
                      dataSource: _cubit.state.loadPowers,
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      color: AppColors.greenA1,
                      name: 'Công suất tiêu thụ',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false)),
                ]),
            // Wrap(
            //   runSpacing: 4.sp,
            //   spacing: 8.sp,
            //   children: [
            //     DescriptionWidget(
            //       color: const Color(0xFF1dd1a1),
            //       name: 'Công suất PV',
            //       selection: selectPV,
            //       callback: () {
            //         setState(() {
            //           selectPV = !selectPV;
            //         });
            //       },
            //     ),
            //     DescriptionWidget(
            //       color: AppColors.grey74,
            //       name: 'Điện lưới',
            //       callback: () {
            //         setState(() {
            //           selectNet = !selectNet;
            //         });
            //       },
            //       selection: selectNet,
            //     ),
            //     DescriptionWidget(
            //       color: AppColors.orange,
            //       name: 'Điện tiêu thụ',
            //       callback: () => setState(() {
            //         selectConsumer = !selectConsumer;
            //       }),
            //       selection: selectConsumer,
            //     ),
            //   ],
            // )
          ],
        ));
  }

  // Widget _buildOutput() {
  //   return Container(
  //     height: 200.sp,
  //     padding: EdgeInsets.symmetric(vertical: 8.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 12.sp),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12.sp),
  //       color: AppColors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColors.greyDF.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 2),
  //         )
  //       ],
  //     ),
  //     child: _cubit.state.listOutput.isNotEmpty
  //         ? SfCircularChart(
  //             title: ChartTitle(
  //               text: "Sản Lượng",
  //               textStyle: AppTextStyle.textXs.copyWith(
  //                   fontSize: 12.sp,
  //                   color: AppColors.textPrimary,
  //                   fontWeight: FontWeight.w600),
  //               alignment: ChartAlignment.near,
  //             ),
  //             legend: Legend(
  //               isVisible: true,
  //               position: LegendPosition.right,
  //               legendItemBuilder: (legendText, series, point, seriesIndex) {
  //                 double value =
  //                     (series as DoughnutSeries).dataSource?[seriesIndex].y;
  //                 return Text(
  //                   '$legendText: ${value.toKWorMW}',
  //                   style: AppTextStyle.textSm.copyWith(
  //                       fontSize: 14.sp,
  //                       fontWeight: FontWeight.w500,
  //                       color: _cubit.state.listOutput[seriesIndex].color),
  //                 );
  //               },
  //             ),
  //             tooltipBehavior: TooltipBehavior(enable: true),
  //             annotations: <CircularChartAnnotation>[
  //               CircularChartAnnotation(
  //                 widget: Center(
  //                   child: _cubit.state.listOutput.isNotEmpty
  //                       ? Text(
  //                           (_cubit.state.listOutput[0].y +
  //                                   _cubit.state.listOutput[1].y)
  //                               .toKWorMW,
  //                           // Hiển thị tổng giá trị
  //                           style: AppTextStyle.textSm.copyWith(
  //                               color: AppColors.textPrimary,
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: 14.sp),
  //                         )
  //                       : const SizedBox(),
  //                 ),
  //               ),
  //             ],
  //             series: <CircularSeries>[
  //               DoughnutSeries<ChartData, String>(
  //                 strokeColor: Colors.white,
  //                 cornerStyle: CornerStyle.bothCurve,
  //                 dataSource: _cubit.state.listOutput,
  //                 xValueMapper: (ChartData data, _) => data.x,
  //                 yValueMapper: (ChartData data, _) => data.y,
  //                 radius: '100%',
  //                 innerRadius: '80%',
  //                 pointColorMapper: (ChartData data, _) => data.color,
  //               ),
  //             ],
  //           )
  //         : Center(
  //             child: Text(
  //               'Không có dữ liệu',
  //               style: AppTextStyle.textXs
  //                   .copyWith(fontSize: 12.sp, color: AppColors.textPrimary),
  //             ),
  //           ),
  //   );
  // }
  //
  // Widget _buildUsed() {
  //   return Container(
  //     height: 200.sp,
  //     padding: EdgeInsets.symmetric(vertical: 8.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 12.sp),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12.sp),
  //       color: AppColors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppColors.greyDF.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 2),
  //         )
  //       ],
  //     ),
  //     child: _cubit.state.listUsed.isNotEmpty
  //         ? SfCircularChart(
  //             title: ChartTitle(
  //               text: "Mức sử dụng",
  //               textStyle: AppTextStyle.textXs.copyWith(
  //                   fontSize: 12.sp,
  //                   color: AppColors.textPrimary,
  //                   fontWeight: FontWeight.w600),
  //               alignment: ChartAlignment.near,
  //             ),
  //             legend: Legend(
  //               isVisible: true,
  //               position: LegendPosition.right,
  //               legendItemBuilder: (legendText, series, point, seriesIndex) {
  //                 double value =
  //                     (series as DoughnutSeries).dataSource?[seriesIndex].y;
  //                 return Text(
  //                   '$legendText: ${value.toKWorMW}',
  //                   style: AppTextStyle.textSm.copyWith(
  //                     fontSize: 14.sp,
  //                     fontWeight: FontWeight.w500,
  //                     color: _cubit.state.listUsed[seriesIndex].color,
  //                   ),
  //                 );
  //               },
  //             ),
  //             tooltipBehavior: TooltipBehavior(enable: true),
  //             annotations: <CircularChartAnnotation>[
  //               CircularChartAnnotation(
  //                 widget: Center(
  //                   child: _cubit.state.listUsed.isNotEmpty
  //                       ? Text(
  //                           (_cubit.state.listUsed[0].y).toKWorMW,
  //                           style: AppTextStyle.textSm.copyWith(
  //                               fontSize: 14.sp,
  //                               fontWeight: FontWeight.w500,
  //                               color: AppColors.textPrimary),
  //                         )
  //                       : const SizedBox(),
  //                 ),
  //               ),
  //             ],
  //             series: <CircularSeries>[
  //               DoughnutSeries<ChartData, String>(
  //                   strokeColor: Colors.white,
  //                   cornerStyle: CornerStyle.bothCurve,
  //                   dataSource: _cubit.state.listUsed,
  //                   xValueMapper: (ChartData data, _) => data.x,
  //                   yValueMapper: (ChartData data, _) => data.y,
  //                   radius: '100%',
  //                   innerRadius: '80%',
  //                   pointColorMapper: (ChartData data, _) => data.color),
  //             ],
  //           )
  //         : Center(
  //             child: Text(
  //               'Không có dữ liệu',
  //               style: AppTextStyle.textXs
  //                   .copyWith(fontSize: 12.sp, color: AppColors.textPrimary),
  //             ),
  //           ),
  //   );
  // }

  Future<void> showDatePicker(DateRangePickerView type) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.all(16.sp),
        contentPadding: EdgeInsets.all(8.sp),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
        content: SizedBox(
          width: 1.sw,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfDateRangePicker(
                initialSelectedDate: _cubit.state.dateTime,
                initialDisplayDate: _cubit.state.dateTime,
                backgroundColor: AppColors.white,
                headerStyle: const DateRangePickerHeaderStyle(
                    backgroundColor: AppColors.white),
                view: type,
                allowViewNavigation: false,
                selectionColor: AppColors.blueEA,
                selectionShape: DateRangePickerSelectionShape.rectangle,
                showNavigationArrow: true,
                showActionButtons: true,
                onSubmit: (date) {
                  DateTime dateTime = date as DateTime;
                  _cubit.changDateTime(dateTime);
                  _cubit.getChartElectric();
                  Navigator.pop(context);
                },
                onCancel: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
