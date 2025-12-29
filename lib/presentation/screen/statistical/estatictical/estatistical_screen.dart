import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/localizations.dart';

import 'package:solar_energy/application/extensions/extensions.dart';
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
  late bool selectThdUa;
  late bool selectThdUb;
  late bool selectThdUc;
  late bool selectThdIa;
  late bool selectThdIb;
  late bool selectThdIc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectThdUa = true;
    selectThdUb = true;
    selectThdUc = true;
    selectThdIa = true;
    selectThdIb = true;
    selectThdIc = true;
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
    return BlocListener<EStatisticalCubit, EStatisticalState>(
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
        child: Column(
          children: [
            _buildDateTime(),
            Gap(22.sp),
            BlocBuilder<EStatisticalCubit, EStatisticalState>(
              buildWhen: (previous, current) =>
                  previous.loadPowers != current.loadPowers,
              builder: (context, state) =>
                  _buildChartEPI(loadPowers: state.loadPowers),
            ),
            Gap(22.sp),
            BlocBuilder<EStatisticalCubit, EStatisticalState>(
              builder: (context, state) => _buildChartTHD(
                  selectA: state.selectThdUa,
                  selectB: state.selectThdUb,
                  selectC: state.selectThdUc,
                  thdA: state.thdUa,
                  thdB: state.thdUb,
                  thdC: state.thdUc,
                  a: "THD UA",
                  b: "THD UB",
                  c: "THD UC",
                  changeA: () {
                    _cubit.changeSelect(selectThdUa: !state.selectThdUa);
                  },
                  changeB: () {
                    _cubit.changeSelect(selectThdUb: !state.selectThdUb);
                  },
                  changeC: () {
                    _cubit.changeSelect(selectThdUc: !state.selectThdUc);
                  }),
            ),
            Gap(22.sp),
            BlocBuilder<EStatisticalCubit, EStatisticalState>(
              builder: (context, state) => _buildChartTHD(
                  selectA: state.selectThdIa,
                  selectB: state.selectThdIb,
                  selectC: state.selectThdIc,
                  thdA: state.thdIa,
                  thdB: state.thdIb,
                  thdC: state.thdIc,
                  a: "THD IA",
                  b: "THD IB",
                  c: "THD IC",
                  changeA: () {
                    _cubit.changeSelect(selectThdIa: !state.selectThdIa);
                  },
                  changeB: () {
                    _cubit.changeSelect(selectThdIb: !state.selectThdIb);
                  },
                  changeC: () {
                    _cubit.changeSelect(selectThdIc: !state.selectThdIc);
                  }),
            )
          ],
        ));
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

  Widget _buildChartTHD({
    required List<SalesData> thdA,
    required List<SalesData> thdB,
    required List<SalesData> thdC,
    required VoidCallback changeA,
    required VoidCallback changeB,
    required VoidCallback changeC,
    required bool selectA,
    required bool selectB,
    required bool selectC,
    required String a,
    required String b,
    required String c,
  }) {
    return Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            SfCartesianChart(
                legend: const Legend(isVisible: false),
                primaryXAxis: CategoryAxis(
                  labelRotation: 45,
                  labelStyle: AppTextStyle.tini.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400),
                ),
                primaryYAxis: NumericAxis(
                  labelRotation: 45,
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    return ChartAxisLabel(
                        "${details.value.toStringAsFixed(2)}%",
                        AppTextStyle.tini.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w400));
                  },
                ),
                // Enable tooltip
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  hideDelay: 2500,
                  tooltipAlignment: ChartAlignment.center,
                  tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
                  // Hiển thị tất cả series
                  tooltipSettings: InteractiveTooltip(
                    enable: true,
                    format: 'point.y',
                    color: Colors.black.withOpacity(0.7),
                    textStyle: AppTextStyle.textXs.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    zoomMode: ZoomMode.xy),
                series: <CartesianSeries<SalesData, String>>[
                  if (selectA)
                    SplineSeries<SalesData, String>(
                        dataSource: thdA,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: AppColors.greenA1,
                        name: LocalizationsUtils.localizations.consumed_energy,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false)),
                  if (selectB)
                    SplineSeries<SalesData, String>(
                        dataSource: thdB,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: AppColors.blueF8,
                        name: LocalizationsUtils.localizations.consumed_energy,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false)),
                  if (selectC)
                    SplineSeries<SalesData, String>(
                        dataSource: thdC,
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        color: AppColors.yellow57,
                        name: LocalizationsUtils.localizations.consumed_energy,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false)),
                ]),
            Wrap(
              runSpacing: 4.sp,
              spacing: 8.sp,
              children: [
                DescriptionWidget(
                  color: AppColors.greenA1,
                  name: a,
                  selection: selectA,
                  callback: changeA,
                ),
                DescriptionWidget(
                  color: AppColors.blueF8,
                  name: b,
                  callback: changeB,
                  selection: selectB,
                ),
                DescriptionWidget(
                  color: AppColors.yellow57,
                  name: c,
                  callback: changeC,
                  selection: selectC,
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildChartEPI({
    required List<SalesData> loadPowers,
  }) {
    return Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
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
                    format: 'EPI: point.y',
                    color: Colors.black.withOpacity(0.7),
                    textStyle: AppTextStyle.textXs.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    enableDoubleTapZooming: true,
                    zoomMode: ZoomMode.xy),
                series: <CartesianSeries<SalesData, String>>[
                  SplineSeries<SalesData, String>(
                      dataSource: loadPowers,
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      color: AppColors.greenA1,
                      name: LocalizationsUtils.localizations.consumed_energy,
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false)),
                ]),
            Text(
              "Biểu đồ EPI",
              style: AppTextStyle.textSm.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w400),
            )
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
