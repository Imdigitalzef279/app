import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_energy/application/constants/localizations.dart';

import 'package:solar_energy/data/dto/base_chart_line.dart';

import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../application/constants/app_color.dart';
import '../../../../application/constants/app_text_style.dart';
import '../../../../application/cubit/app_cubit.dart';
import '../../../../application/enums/index_type.dart';
import '../../../../data/dto/water/request/meter_water_request.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/route_name.dart';
import '../../alarm_water/widget/item_alarm_water.dart';
import '../bloc/manager_water_cubit.dart';

class OverviewWater extends StatefulWidget {
  const OverviewWater(
      {super.key, required this.deviceWater, required this.stationId});

  final int deviceWater;
  final int stationId;

  @override
  State<OverviewWater> createState() => _OverviewWaterState();
}

class _OverviewWaterState extends State<OverviewWater>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controllerWaterIndex;
  late Animation<double> _animation;
  late final ManagerWaterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controllerWaterIndex = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controllerWaterIndex,
      curve: Curves.easeIn,
    );
    _cubit = BlocProvider.of<ManagerWaterCubit>(context);
    final date = DateTime.now();
    final nextDay = DateTime.now().add(const Duration(days: 1));

    if (widget.deviceWater != 0) {
      final request = MeterWaterRequest(
        detailId: widget.deviceWater,
        powerStationId: widget.stationId,
        fromDate: "${date.month}/${date.day}/${date.year}",
        toDate: "${nextDay.month}/${nextDay.day}/${nextDay.year}",
      );
      _cubit.getValuesWater(request);
    } else {
      AppToast.showToastError(title: LocalizationsUtils.localizations.no_value);
      Future.delayed(const Duration(seconds: 3), () {
        AppToast.dismissAll();
      });
    }
  }

  void _openListWaterIndex() {
    _cubit.changeIsEdit();
    if (_animation.value == 0) {
      _controllerWaterIndex.forward();
    } else if (_animation.value == 1) {
      _controllerWaterIndex.animateBack(0,
          duration: const Duration(milliseconds: 500));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerWaterIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.sp),
          child: BlocListener<ManagerWaterCubit, ManagerWaterState>(
            listener: (context, state) {
              state.values.when(
                  loading: () =>
                      BlocProvider.of<AppCubit>(context).showLoading(),
                  success: (data) =>
                      BlocProvider.of<AppCubit>(context).hideShowLoading(),
                  error: (error) {
                    BlocProvider.of<AppCubit>(context).hideShowLoading();
                    AppToast.showToastError(
                        title:
                            LocalizationsUtils.localizations.an_error_occurred);
                  });
            },
            child: Column(
              children: [
                _overview(),
                Gap(12.sp),
                _waterIndexWarning(),
                Gap(12.sp),
                _waterIndex(),
                Gap(12.sp),
                _warning(),
                Gap(12.sp),
                _waterConsumption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _overview() {
    return BlocBuilder<ManagerWaterCubit, ManagerWaterState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
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
                  fontSize: 14.sp,
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
                      "${state.currentIndex.toString()} L",
                      style: AppTextStyle.textBase.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
                Gap(12.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.icons.faucet.svg(
                            width: 14.sp,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueF8, BlendMode.srcIn)),
                        Gap(8.sp),
                        Text(
                          state.loadPowers.isNotEmpty
                              ? "${LocalizationsUtils.localizations.indicator}: ${state.loadPowers.last.sales} ${LocalizationsUtils.localizations.liter}"
                              : "${LocalizationsUtils.localizations.indicator}: -- ${LocalizationsUtils.localizations.liter}",
                          style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Gap(8.sp),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.icons.usdCircle.svg(
                            width: 14.sp,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueF8, BlendMode.srcIn)),
                        Gap(8.sp),
                        Text(
                          state.loadPowers.isNotEmpty
                              ? "${LocalizationsUtils.localizations.amount}: ${(state.loadPowers.last.sales * 35000).toStringAsFixed(0)} VND"
                              : "${LocalizationsUtils.localizations.amount}: -- VND",
                          style: AppTextStyle.textXs.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Gap(8.sp),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.icons.arrowDownStrenght.svg(
                            width: 14.sp,
                            colorFilter: const ColorFilter.mode(
                                AppColors.blueF8, BlendMode.srcIn)),
                        Gap(8.sp),
                        Text(
                          "${LocalizationsUtils.localizations.pressure}: 0 Pa",
                          style: AppTextStyle.textXs.copyWith(
                              fontSize: 12.sp,
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
    );
  }

  Widget _waterIndex() {
    return BlocBuilder<ManagerWaterCubit, ManagerWaterState>(
      builder: (BuildContext context, ManagerWaterState state) {
        return Container(
          padding: EdgeInsets.all(12.sp),
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
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalizationsUtils.localizations.waterIndicator,
                    style: AppTextStyle.textSm
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                  InkWell(
                    onTap: () {
                      _openListWaterIndex();
                    },
                    child: Icon(
                      state.isEdit ? Icons.done : Icons.settings,
                      size: 18.sp,
                    ),
                  )
                ],
              ),
              Gap(8.sp),
              Wrap(
                runSpacing: 12.sp,
                spacing: 8.sp,
                children: List.generate(
                    state.listSelected.length,
                    (index) => itemWaterIndex(state.listSelected[index],
                        isAdd: false)),
              ),
              SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.vertical,
                  axisAlignment: -1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(16.sp),
                      Text(
                        LocalizationsUtils.localizations.indicatorList,
                        style: AppTextStyle.textSm.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                      Gap(8.sp),
                      Wrap(
                        runSpacing: 12.sp,
                        spacing: 8.sp,
                        children: List.generate(
                            state.listWaterIndex.length,
                            (index) => itemWaterIndex(
                                state.listWaterIndex[index],
                                isAdd: true)),
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget itemWaterIndex(WaterIndexModel waterIndex, {required bool isAdd}) {
    Color color = _cubit.handleColorStatus(waterIndex);
    return Stack(
      children: [
        Container(
          width: (1.sw - 48.sp - 8.sp) / 2,
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: color.withOpacity(0.2)),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    waterIndex.title,
                    style: AppTextStyle.textXs
                        .copyWith(color: AppColors.grey4D, fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(4.sp),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: waterIndex.value.toString(),
                        style: AppTextStyle.textSm.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.textPrimary)),
                    TextSpan(
                        text: ' ${waterIndex.unit}',
                        style: AppTextStyle.textXs.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.grey4D)),
                  ])),
                  Gap(4.sp),
                  Text(
                      waterIndex.limit != null
                          ? "${LocalizationsUtils.localizations.limit}: <= ${waterIndex.limit}"
                          : LocalizationsUtils.localizations.unlimited,
                      style: AppTextStyle.textXs
                          .copyWith(color: AppColors.grey73, fontSize: 12.sp))
                ],
              ),
            ),
            Gap(12.sp),
            SvgPicture.asset(
              waterIndex.icon,
              width: 20.sp,
              height: 20.sp,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ]),
        ),
        if (_cubit.state.isEdit)
          Positioned(
              right: 0,
              child: CircleAvatar(
                radius: 8.sp,
                backgroundColor: isAdd ? AppColors.green50 : AppColors.red14,
                child: InkWell(
                  onTap: () {
                    _cubit.addToListSelected(waterIndex, isAdd);
                  },
                  child: Icon(
                    isAdd ? Icons.add : Icons.remove,
                    color: AppColors.white,
                    size: 16.sp,
                  ),
                ),
              ))
      ],
    );
  }

  Widget _warning() {
    return Container(
      padding: EdgeInsets.all(12.sp).copyWith(bottom: 4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalizationsUtils.localizations.nearestWarning,
                style: AppTextStyle.textSm.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.allAlarmWater);
                  },
                  child: Text(
                    LocalizationsUtils.localizations.seeMore,
                    style: AppTextStyle.textXs.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueF8),
                  ))
            ],
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const ItemAlarmWater(),
              separatorBuilder: (context, index) => const Divider(
                    color: AppColors.greyCC,
                    height: 0,
                  ),
              itemCount: 3)
        ],
      ),
    );
  }

  Widget _waterConsumption() {
    return BlocBuilder<ManagerWaterCubit, ManagerWaterState>(
      buildWhen: (previous, current) =>
          previous.loadPowers != current.loadPowers,
      builder: (context, state) => Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
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
          children: [
            Text(
              LocalizationsUtils.localizations.waterConsumption,
              style: AppTextStyle.textSm.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary),
            ),
            Gap(8.sp),
            SizedBox(
              height: 1.sw / 2,
              child: SfCartesianChart(
                  // Enable legend
                  legend: const Legend(isVisible: false),
                  primaryXAxis: CategoryAxis(
                    labelStyle: AppTextStyle.textXs.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400),
                    desiredIntervals: 10,
                    labelRotation: 0,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLabelFormatter: (AxisLabelRenderDetails details) {
                      final formattedValue = details.value.toStringAsFixed(2);
                      return ChartAxisLabel(
                          '$formattedValue L',
                          AppTextStyle.textXs.copyWith(
                              fontSize: 10.sp,
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
                      format: 'point.y L',
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
                  series: <CartesianSeries<BaseChartLine, String>>[
                    SplineSeries<BaseChartLine, String>(
                        dataSource: state.loadPowers,
                        xValueMapper: (BaseChartLine sales, _) => sales.year,
                        yValueMapper: (BaseChartLine sales, _) => sales.sales,
                        color: const Color(0xFF1dd1a1),
                        name: LocalizationsUtils.localizations.pv_power,
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

  Widget _waterIndexWarning() {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
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
            LocalizationsUtils.localizations.warning,
            style: AppTextStyle.textSm.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary),
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: warningWidget(
                name: "1",
                colors: AppColors.greyAE.withOpacity(0.7),
                onPress: () => Navigator.pushNamed(
                    context, RouteName.indexWarning,
                    arguments: IndexType.normal),
              )),
              4.horizontalSpace,
              Expanded(
                  child: warningWidget(
                name: "1",
                colors: AppColors.green50.withOpacity(0.3),
                onPress: () => Navigator.pushNamed(
                    context, RouteName.indexWarning,
                    arguments: IndexType.good),
              )),
              4.horizontalSpace,
              Expanded(
                  child: warningWidget(
                name: "1",
                colors: AppColors.yellow57.withOpacity(0.7),
                onPress: () => Navigator.pushNamed(
                    context, RouteName.indexWarning,
                    arguments: IndexType.high),
              )),
              4.horizontalSpace,
              Expanded(
                  child: warningWidget(
                name: "1",
                colors: AppColors.red14.withOpacity(0.7),
                onPress: () => Navigator.pushNamed(
                    context, RouteName.indexWarning,
                    arguments: IndexType.very_hight),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget warningWidget(
      {required String name, VoidCallback? onPress, Color? colors}) {
    return GestureDetector(
      onTap: () {
        onPress?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: colors ?? AppColors.white,
        ),
        child: Text(
          name,
          style: AppTextStyle.textSm.copyWith(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
