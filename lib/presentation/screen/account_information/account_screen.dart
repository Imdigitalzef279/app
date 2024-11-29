import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/account_information/widget/basic_account_widget.dart';
import 'package:solar_energy/presentation/screen/account_information/widget/item_option_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              const BasicAccountWidget(
                email: "nguyenhongxd2002@gmail.com",
                userName: "NguyenHong",
                imageLink:
                    "https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/avatar-anh-meo-cute-5.jpg",
              ),
              SizedBox(
                height: 12.h,
              ),
              container(
                  child: Column(
                children: [
                  ItemOptionWidget(
                    icon: Icon(Icons.account_circle, size: 22.w,),
                    optionName: "Lê Nguyên Hồng",
                  ),
                  const Divider(
                    color: AppColors.greyFB,
                  ),
                  ItemOptionWidget(
                    icon: Icon(Icons.attach_email, size: 22.w,),
                    optionName: "nguyenhongxd2002@gmail.com",
                  ),
                  const Divider(
                    color: AppColors.greyFB,
                  ),
                  ItemOptionWidget(
                    icon: Icon(Icons.phone_android, size: 22.w,),
                    optionName: "+84941386236",
                  )
                ],
              )),
              SizedBox(
                height: 42.h,
              ),


              InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {},
                child: Ink(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.red14.withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        Assets.icons.signOutAlt.svg(
                          width: 16.w,
                          height: 16.w,
                          colorFilter: const ColorFilter.mode(
                              AppColors.red14, BlendMode.srcIn),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                            child: Text(
                          "Đăng xuất",
                          style: AppTextStyle.textSm.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.red14),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget container({Widget? child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
      ),
      child: child,
    );
  }
}
