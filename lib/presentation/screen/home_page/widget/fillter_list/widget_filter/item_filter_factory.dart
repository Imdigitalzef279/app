import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';

class ItemFilterFactory extends StatelessWidget {
  const ItemFilterFactory({super.key, required this.listValues, required this.valueSelected, required this.nameFilter, required this.selectItem});

  final List<ItemFactoryFilter> listValues;
  final String valueSelected;
  final String nameFilter;
  final Function(String) selectItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Loại nhà máy",
          style: AppTextStyle.textSm
              .copyWith(color: AppColors.textPrimary.withOpacity(0.3)),
        ),
        SizedBox(height: 4.h,),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List.generate(
            listValues.length,
            (index) => filterValues(
                name: listValues[index].name,
                defaultValues: listValues[index].value,
                valuesSelected: valueSelected),
          ),
        )
      ],
    );
  }

  Widget filterValues(
      {required String name,
      required String defaultValues,
      required String valuesSelected}) {
    return GestureDetector(
      onTap: (){
        selectItem.call(defaultValues);
      },
      child: Container(
        width: 1.sw / 2 - 40.w,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: defaultValues == valuesSelected
              ? AppColors.blueFB.withOpacity(0.3)
              : AppColors.greyFB,
        ),
        child: Text(
          name,
          style: AppTextStyle.textXs.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.textPrimary,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ItemFactoryFilter {
  final String name;
  final String value;

  const ItemFactoryFilter({required this.name, required this.value});
}
