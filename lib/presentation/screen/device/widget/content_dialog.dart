import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/utils/navigation_utils.dart';
import 'package:solar_energy/presentation/common_widgets/app_button.dart';

import '../../../../data/dto/device/response/device_response.dart';

class ContentDialog extends StatelessWidget {
  const ContentDialog({super.key, required this.device});

  final DeviceResponse device;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        device.status == 1 ? "Thiết bị đang hoạt động" : "Thiết bị đang dừng ",
        style: AppTextStyle.textSm.copyWith(
            color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      ),
      content: Text(
        device.status == 1
            ? "⚠️ Ngừng kích hoạt thiết bị ${device.name} ?"
            : "⚠️ Kích hoạt lại thiêt bị ${device.name}",
        style: AppTextStyle.textXs.copyWith(
            color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      ),
      actions: [
        Row(
          children: [
            Expanded(
                child: AppButton(
              onPressed: () => Navigator.pop(context),
              title: "Hủy bỏ",
              color: AppColors.white,
              fontSize: 12.sp,
              textColor: AppColors.red14,
              borderColor: AppColors.red14,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
            )),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
                child: AppButton(
                    title: device.status == 1 ? "Dừng" : "Kích hoạt",
                    color: AppColors.white,
                    fontSize: 12.sp,
                    textColor: AppColors.blueF8,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                    onPressed: () {
                      openInputCode();
                    }))
          ],
        )
      ],
    );
  }

  Future<void> openInputCode() async {
    Navigator.pop(NavigatorUtils.currentContext);
    showModalBottomSheet(
      context: NavigatorUtils.currentContext,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nhập mã code',
                style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Mã Code',
                  border: OutlineInputBorder(),
                  counterText: ""
                ),
                style: AppTextStyle.textSm.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                maxLength: 6,

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    child: const Text('Xác nhận'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
