import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/cubit/app_cubit.dart';
import 'package:solar_energy/domain/arguments/electric_meter/electric_meter_argument.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/device/widget/item_device.dart';
import 'add_device_screen.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key, required this.argument});

  final ElectricMeterArgument argument;

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  late final DeviceCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DeviceCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDevices();
    });
  }

  void _loadDevices() {
    _cubit.getDevices(
      powerStationId: widget.argument.project.id,
      type: widget.argument.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          LocalizationsUtils.localizations.device_list,
          style: AppTextStyle.textBase.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: AppColors.greyFB,

      body: SafeArea(
        child: BlocConsumer<DeviceCubit, DeviceState>(
          listener: (context, state) {
            state.resultDevices.when(
              loading: () =>
                  BlocProvider.of<AppCubit>(context).showLoading(),
              success: (_) =>
                  BlocProvider.of<AppCubit>(context).hideShowLoading(),
              error: (error) {
                BlocProvider.of<AppCubit>(context).hideShowLoading();
                AppToast.showToastError(title: error);
              },
            );
          },
          builder: (context, state) {
            final devices = state.resultDevices.data;

            if (devices != null && devices.isNotEmpty) {
              return ListView.separated(
                padding: EdgeInsets.all(12.sp),
                itemBuilder: (context, index) {
                  final device = devices[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddDeviceScreen(
                            powerStationId: device.powerStationId,
                            meterId: device.id,
                          ),
                        ),
                      );
                    },
                    child: ItemDevice(device: device),
                  );
                },
                separatorBuilder: (_, __) => Gap(12.sp),
                itemCount: devices.length,
              );
            }

            return Center(
              child: Text(
                LocalizationsUtils.localizations.no_value,
                style: AppTextStyle.textXs.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
