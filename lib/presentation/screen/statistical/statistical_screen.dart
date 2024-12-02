import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/screen/statistical/widget/descrip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({super.key});

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen>
    with TickerProviderStateMixin {
  late bool selectPV;
  late bool selectNet;
  late bool selectConsumer;
  late final TabController _tabController;

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

  final List<_ChartData> chartData = [
    _ChartData('Công suất tự dùng', 1.61),
    _ChartData('Xuất', 0.00),
  ];

  final List<_ChartData> chartData2 = [
    _ChartData('Công suất tự cấp', 1.61),
    _ChartData('Nhập', 6.57),
  ];

  double total = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectPV = true;
    selectNet = true;
    selectConsumer = true;

    total = chartData.fold(0, (sum, data) => sum + data.y);
    _tabController = TabController(length: 3, vsync: this);
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
          "Thien son",
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
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white),
                child: Column(
                  children: [
                    TabBar(
                        tabs: const <Widget>[
                          Tab(
                            text: "Ngày",
                          ),
                          Tab(
                            text: "Tháng",
                          ),
                          Tab(
                            text: "Năm",
                          ),
                        ],
                        controller: _tabController,
                        labelStyle:
                            AppTextStyle.textSm.copyWith(color: AppColors.blueEA),
                        indicatorColor: AppColors.blueFD,
                        unselectedLabelColor: AppColors.grey73,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.blueFD.withOpacity(0.5)),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0,
                        dividerColor: Colors.transparent),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.chevron_left_rounded, size: 16.w,)),
                        Text("25/11/2024", style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right_rounded, size: 16.w,))
                      ],
                    )
                  ],
                ),
              ),
              Gap(8.h),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.white),
                    height: 1.sw / 2,
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: "Sản Lượng",
                        textStyle: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                        alignment: ChartAlignment.near,
                      ),
                      legend: Legend(
                        isVisible: true,
                        // Hiển thị chú thích
                        position: LegendPosition.right,
                        // Đặt vị trí chú thích
                        legendItemBuilder:
                            (legendText, series, point, seriesIndex) {
                          double value = (series as DoughnutSeries)
                              .dataSource?[seriesIndex]
                              .y;
                          return Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              '$legendText: ${value.toStringAsFixed(2)} kW',
                              style: AppTextStyle.textXs.copyWith(
                                  color: legendText == "Xuất"
                                      ? Colors.grey
                                      : Colors.green),
                            ),
                          );
                        },
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Center(
                            child: Text(
                              '${(chartData[0].y + chartData[1].y).toStringAsFixed(2)} kW',
                              // Hiển thị tổng giá trị
                              style: AppTextStyle.textSm
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      ],
                      // Bật tooltip
                      series: <CircularSeries>[
                        DoughnutSeries<_ChartData, String>(
                          strokeColor: Colors.white,
                          cornerStyle: CornerStyle.bothCurve,
                          dataSource: chartData,
                          xValueMapper: (_ChartData data, _) => data.x,
                          // Gán nhãn
                          yValueMapper: (_ChartData data, _) => data.y,
                          // Gán giá trị
                          radius: '70%',
                          innerRadius: '80%',
                          pointColorMapper: (_ChartData data, _) =>
                              data.x == 'Công suất tự dùng'
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Gap(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.white),
                    height: 1.sw / 2,
                    child: SfCircularChart(
                      title: ChartTitle(
                        text: "Mức sử dụng",
                        textStyle: AppTextStyle.textSm.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                        alignment: ChartAlignment.near,
                      ),
                      legend: Legend(
                        isVisible: true,
                        // Hiển thị chú thích
                        position: LegendPosition.right,
                        // Đặt vị trí chú thích
                        legendItemBuilder:
                            (legendText, series, point, seriesIndex) {
                          double value = (series as DoughnutSeries)
                              .dataSource?[seriesIndex]
                              .y;
                          return Container(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                '$legendText: ${value.toStringAsFixed(2)} kW',
                                style: AppTextStyle.textXs.copyWith(
                                  color: legendText == "Nhập"
                                      ? const Color(0xFFff9f43)
                                      : const Color(0xFFfeca57),
                                ),
                              ));
                        },
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Center(
                            child: Text(
                              '${(chartData2[0].y + chartData2[1].y).toStringAsFixed(2)} kW',
                              // Hiển thị tổng giá trị
                              style: AppTextStyle.textSm
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                          ),
                        ),
                      ],
                      // Bật tooltip
                      series: <CircularSeries>[
                        DoughnutSeries<_ChartData, String>(
                          strokeColor: Colors.white,
                          cornerStyle: CornerStyle.bothCurve,
                          dataSource: chartData2,
                          xValueMapper: (_ChartData data, _) => data.x,
                          // Gán nhãn
                          yValueMapper: (_ChartData data, _) => data.y,
                          // Gán giá trị
                          radius: '70%',
                          innerRadius: '80%',
                          pointColorMapper: (_ChartData data, _) =>
                              data.x == 'Nhập'
                                  ? const Color(0xFFff9f43)
                                  : const Color(0xFFfeca57),
                        )
                      ],
                    ),
                  ),
                  Gap(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.white),
                    child: Column(
                      children: [
                        SfCartesianChart(
                            // Enable legend
                            legend: const Legend(isVisible: false),
                            primaryXAxis: CategoryAxis(
                              labelStyle: AppTextStyle.textXs
                                  .copyWith(color: AppColors.textPrimary),
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
                              if (selectPV)
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
                              if (selectNet)
                                SplineSeries<_SalesData, String>(
                                    dataSource: generateSalesData(),
                                    xValueMapper: (_SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (_SalesData sales, _) =>
                                        sales.sales,
                                    color: const Color(0xFF576574),
                                    name: 'Nguồn điện từ lưới điện',

                                    // Enable data label
                                    dataLabelSettings:
                                        const DataLabelSettings(isVisible: false)),
                              if (selectConsumer)
                                SplineSeries<_SalesData, String>(
                                    dataSource: generateSalesData(),
                                    xValueMapper: (_SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (_SalesData sales, _) =>
                                        sales.sales,
                                    color: const Color(0xFFff9f43),
                                    name: 'Điện năng tiêu thụ',
                                    // Enable data label
                                    dataLabelSettings:
                                        const DataLabelSettings(isVisible: false))
                            ]),
                        Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 4.w,
                          spacing: 12.w,
                          children: [
                            DescripWidget(
                              color: const Color(0xFF1dd1a1),
                              name: 'Công suất PV',
                              selection: selectPV,
                              callback: () {
                                setState(() {
                                  selectPV = !selectPV;
                                });
                              },
                            ),
                            DescripWidget(
                              color: const Color(0xFF576574),
                              name: 'Nguồn điện từ lưới điện',
                              callback: () {
                                setState(() {
                                  selectNet = !selectNet;
                                });
                              },
                              selection: selectNet,
                            ),
                            DescripWidget(
                              color: const Color(0xFFff9f43),
                              name: 'Điện năng tiêu thụ',
                              callback: () => setState(() {
                                selectConsumer = !selectConsumer;
                              }),
                              selection: selectConsumer,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
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

class _ChartData {
  final String x;
  final double y;

  _ChartData(this.x, this.y);
}
