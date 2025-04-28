import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/cubit/app_cubit.dart';
import 'package:solar_energy/application/enums/electric_type.dart';
import 'package:solar_energy/application/enums/search_type.dart';
import 'package:solar_energy/data/dto/solar_electric/request/solar_electric_request.dart';
import 'package:solar_energy/presentation/screen/overview/bloc/overview_cubit.dart';
import 'package:solar_energy/presentation/screen/overview/widget/currently_widget.dart';
import 'package:solar_energy/presentation/screen/overview/widget/header_widget.dart';
import 'package:solar_energy/presentation/screen/overview/widget/saving_energy.dart';

import '../../../data/dto/power_station/response/power_station_response.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({
    super.key,
    required this.type,
    required this.project
  });

  final ElectricType type;
  final PowerStationResponse project;


  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  late final OverviewCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<OverviewCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      String currentDay = DateFormat('dd/MM/yyyy').format(DateTime.now());
      cubit.getSolarElectric(SolarElectricRequest(
          powerStationId: widget.project.id,
          searchType: SearchType.hour,
          searchValue: currentDay));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.blueFB,
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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.menu, size: 16.sp),
        //   )
        // ],
      ),
      backgroundColor: AppColors.greyFB,
      body: BlocConsumer<OverviewCubit, OverviewState>(
        listener: (BuildContext context, OverviewState state) {
          state.resultSolar.when(
              loading: () => BlocProvider.of<AppCubit>(context).showLoading(),
              success: (data) =>
                  BlocProvider.of<AppCubit>(context).hideShowLoading(),
              error: (error) =>
                  BlocProvider.of<AppCubit>(context).hideShowLoading());
        },
        builder: (BuildContext context, OverviewState state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(
                  type: widget.type,
                  productionPower: state.totalProductionPower,
                  gridPower: state.totalGridPower,
                  loadPower: state.totalLoadPower,
                ),
                CurrentlyWidget(
                    productionPower: state.totalProductionPower,
                    gridPower: state.totalGridPower,
                    loadPower: state.totalLoadPower,
                    maxGridPower: state.maxGridPower,
                    maxProductionPower: state.maxProductionPower),
              ],
            ),
          );
        },
      ),
    );
  }
}
