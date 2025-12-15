import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/application/enums/cbs_status.dart';
import 'package:solar_energy/application/extensions/extensions.dart';
import 'package:solar_energy/application/utils/navigation_utils.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/device/widget/content_dialog.dart';

class ItemDevice extends StatefulWidget {
  const ItemDevice({super.key, required this.device});

  final DeviceResponse device;

  @override
  State<ItemDevice> createState() => _ItemDeviceState();
}

class _ItemDeviceState extends State<ItemDevice> {
  late final DeviceCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<DeviceCubit>(context);
  }

  DeviceStatus getStatus(int status) {
    switch (status) {
      case 0:
        return DeviceStatus.off;
      case 1:
        return DeviceStatus.on;
      default:
        return DeviceStatus.unknown;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: NavigatorUtils.currentContext,
      builder: (context) => ContentDialog(
        device: widget.device,
      ),
    );
  }

  bool values = true;

  bool getValues(int status) {
    switch (status) {
      case 0:
        return false;
      case 1:
        return true;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteName.detailDevice,
            arguments: widget.device);
      },
      borderRadius: BorderRadius.circular(12.sp),
      child: Ink(
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
            // title

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.device.name,
                        style: AppTextStyle.textBase.copyWith(
                            //fontSize: 14.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                      Gap(12.sp),
                      // body
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              LocalizationsUtils.localizations.device_code,
                              style: AppTextStyle.textXs.copyWith(
                                  color: AppColors.textPrimary.withOpacity(0.5),
                                  fontSize: 12.sp),
                            ),
                          ),
                          Gap(12.sp),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.device.code,
                              style: AppTextStyle.textXs.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                const Spacer(),

                Column(
                  children: [
                    Switch(
                      value: getValues(widget.device.status),
                      onChanged: (value) {
                        _cubit.switchCbs(widget.device);
                      },
                    ),
                    Text(getStatus(widget.device.status).text)
                  ],
                )
              ],
            ),

            const Divider(
              color: AppColors.greyFB,
            ),
            rowItem(
                name: LocalizationsUtils.localizations.description,
                content: widget.device.description),
          ],
        ),
      ),
    );
  }

  Widget rowItem({required String name, required String content}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary.withOpacity(0.5), fontSize: 12.sp),
          ),
        ),
        Gap(12.sp),
        Expanded(
          flex: 10,
          child: Text(
            content,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          ),
        )
      ],
    );
  }
}
