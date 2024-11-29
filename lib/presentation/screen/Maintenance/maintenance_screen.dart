import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/screen/Maintenance/widget/item_error.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final List<ChartData> chartData = [
    ChartData('Cảnh báo', (1 / 9) * 100, const Color(0xFF48dbfb)),
    ChartData('Thấp', (1 / 9) * 100, const Color(0xFFfeca57)),
    ChartData('Cao', (3 / 9) * 100, const Color(0xFFff9f43)),
    ChartData('Nghiêm trọng', (4 / 9) * 100, const Color(0xFFee5253)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Báo động",
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 12.h),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: (1.sw - 32) / 3,
                        height: (1.sw - 32) / 3,
                        child: SfCircularChart(
                          series: <RadialBarSeries<ChartData, String>>[
                            RadialBarSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) =>
                                  data.category,
                              yValueMapper: (ChartData data, _) => data.value,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              radius: '100%',
                              innerRadius: '45%',
                              cornerStyle: CornerStyle.bothCurve,
                              gap: '2',
                            ),
                          ],
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                              widget: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '9',
                                    style: AppTextStyle.textSm,
                                  ),
                                  Text(
                                    'Tổng',
                                    style: AppTextStyle.textXs,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: itemInformation(
                                    color: const Color(0xFFee5253),
                                    name: "Nghiêm trọng",
                                    quantity: 4),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: itemInformation(
                                    color: const Color(0xFFff9f43),
                                    name: "Cao",
                                    quantity: 3),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: itemInformation(
                                    color: const Color(0xFFfeca57),
                                    name: "Thấp",
                                    quantity: 1),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: itemInformation(
                                    color: const Color(0xFF48dbfb),
                                    name: "Cảnh báo",
                                    quantity: 1),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: CustomLabelTextField(
                            backgroundColor: AppColors.greyFB,
                            hintText: "Nhập tên báo động",
                            textStyleHint: AppTextStyle.textXs
                                .copyWith(color: AppColors.grey73),
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                            radius: 99.r,
                            prefixIcon: Assets.icons.search.svg(
                                width: 16.w,
                                height: 16.w,
                                color: AppColors.textPrimary.withOpacity(0.7)),
                          )),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(99.r),
                            onTap: () {},
                            child: Icon(
                              Icons.filter_list_outlined,
                              size: 20.r,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemBuilder: (context, index) => const ItemErrorWidget(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 8.h,
                      ),
                  itemCount: 4))
        ],
      )),
    );
  }

  Widget itemInformation(
      {required Color color, required String name, required int quantity}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quantity.toString(),
          style: AppTextStyle.textSm.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textPrimary),
        ),
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(99.r)),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              name,
              style: AppTextStyle.textXs.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.textPrimary),
            )
          ],
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}
