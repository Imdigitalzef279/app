import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/constants/localizations.dart';
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
        //margin: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            SfCartesianChart(
                legend: const Legend(isVisible: false),
                primaryXAxis: CategoryAxis(
                  labelRotation: 45,
                  labelStyle: AppTextStyle.textXs.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                ),
                primaryYAxis: NumericAxis(
                  labelRotation: 45,
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    return ChartAxisLabel(
                        details.value.toDouble().toKWhFormatted,
                        AppTextStyle.textXs.copyWith(
                            fontSize: 11.sp,
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
                    zoomMode: ZoomMode.xy),
                series: <CartesianSeries<SalesData, String>>[
                  SplineSeries<SalesData, String>(
                      dataSource: _cubit.state.loadPowers,
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      color: AppColors.greenA1,
                      name: LocalizationsUtils.localizations.consumed_energy,
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false)),
                ]),

          ],
        ));
  }

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
