import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../../../application/constants/localizations.dart';

class CreateNewStation extends StatefulWidget {
  const CreateNewStation({super.key});

  @override
  State<CreateNewStation> createState() => _CreateNewStationState();
}

class _CreateNewStationState extends State<CreateNewStation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Tạo mới trạm",
          style: AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            CustomLabelTextField(
              label: "Tên trạm",
            ),
            CustomLabelTextField(
              label: "Tên trạm",
            ),
            CustomLabelTextField(
              label: "Tên trạm",
            )
            ,
            CustomLabelTextField(
              label: "Tên trạm",
            )
          ],
        ),
      ),
    );
  }
}
