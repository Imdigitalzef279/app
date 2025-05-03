import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/enums/index_type.dart';
import 'package:solar_energy/application/extensions/index_extension.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';

import '../../../../application/constants/app_color.dart';
import '../../../../application/constants/app_text_style.dart';

class IndexWarningScreen extends StatefulWidget {
  const IndexWarningScreen({super.key, required this.indexType});

  final IndexType indexType;

  @override
  State<IndexWarningScreen> createState() => _IndexWarningScreenState();
}

class _IndexWarningScreenState extends State<IndexWarningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          widget.indexType.title,
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Danh sách các thiết bị",
              style: AppTextStyle.textSm.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            ),
            8.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                4,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(12.sp),
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.detailDeviceWater);
                  },
                  child: Column(
                    children: [
                      itemDevice(
                          nameDevice: "100KTL - M2(COM1-12) - Đo đầu nguồn",
                          serialNumber: "mbl8320ML",
                          statusDevice: widget.indexType.title,
                          typeDevice: "Van nước",
                          expirationDate: "05/01/2026"),
                      8.verticalSpace
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget itemDevice(
      {String? nameDevice,
      String? serialNumber,
      String? typeDevice,
      String? statusDevice,
      String? expirationDate}) {
    return Ink(
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
            nameDevice ?? "Lỗi",
            style: AppTextStyle.textSm.copyWith(
                fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
          8.verticalSpace,
          rowItem(name: "Số sê-ri", content: serialNumber ?? "Lỗi"),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(name: "Loại thiết bị", content: typeDevice ?? "Lỗi"),
          const Divider(
            color: AppColors.greyFB,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Trạng thái",
                  style: AppTextStyle.textXs.copyWith(
                      color: AppColors.textPrimary.withOpacity(0.5)),
                ),
              ),
              12.verticalSpace,
              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
                    decoration: BoxDecoration(
                      color: AppColors.green50,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      statusDevice ?? "Lỗi",
                      style: AppTextStyle.textXs.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.greyFB,
          ),
          rowItem(name: "Thời gian cập nhật", content: "2029/09/23"),
        ],
      ),
    );
  }

  Widget rowItem({required String name, required String content}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary.withOpacity(0.5)),
          ),
        ),
        12.verticalSpace,
        Expanded(
          flex: 3,
          child: Text(
            content,
            style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
