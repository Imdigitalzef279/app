import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/presentation/screen/statistical/bloc/statistical_cubit.dart';
import 'package:solar_energy/presentation/screen/statistical/widget/detail_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StatisticalScreen extends StatefulWidget {
  const StatisticalScreen({super.key});

  @override
  State<StatisticalScreen> createState() => _StatisticalScreenState();
}

class _StatisticalScreenState extends State<StatisticalScreen>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<int> index;
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    index = ValueNotifier(0);
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyFB,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              margin: EdgeInsets.all(12.sp),
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
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: TabBar(
                      tabs: <Widget>[
                        Tab(
                          text: "Ngày",
                          height: 35.sp,
                        ),
                        Tab(
                          text: "Tháng",
                          height: 35.sp,
                        ),
                        Tab(
                          text: "Năm",
                          height: 35.sp,
                        ),
                      ],
                      controller: controller,
                      labelStyle: AppTextStyle.textSm.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.blueEA,
                          fontWeight: FontWeight.w500),
                      indicatorColor: AppColors.blueFD,
                      unselectedLabelColor: AppColors.grey73,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: AppColors.blueFD.withOpacity(0.8)),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 0,
                      dividerColor: Colors.transparent,
                      onTap: (value) {
                        index.value = value;
                      },
                    ),
                  ),
                  Gap(12.sp),
                  ValueListenableBuilder(
                      valueListenable: index,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            BlocProvider(
                              create: (context) =>
                                  StatisticalCubit(DateRangePickerView.month),
                              child: Visibility(
                                visible: value == 0,
                                child: const DetailWidget(),
                              ),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  StatisticalCubit(DateRangePickerView.year),
                              child: Visibility(
                                visible: value == 1,
                                child: const DetailWidget(),
                              ),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  StatisticalCubit(DateRangePickerView.decade),
                              child: Visibility(
                                visible: value == 2,
                                child: const DetailWidget(),
                              ),
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
