import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';

import '../../../application/cubit/app_cubit.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final AccountCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          state.request.when(
            loading: () => context.read<AppCubit>().showLoading(),
            success: (_) => context.read<AppCubit>().hideShowLoading(),
            error: (_) => context.read<AppCubit>().hideShowLoading(),
          );
        },
        builder: (context, state) {
          final user = state.request.data;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                children: [

                  /// HEADER
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    child: Stack(
                      children: [

                        /// IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            "assets/images/factory.png",
                            width: double.infinity,
                            height: 220.h,
                            fit: BoxFit.contain,
                          ),
                        ),

                        /// USER INFO
                        Positioned(
                          left: 16.w,
                          bottom: 16.h,
                          child: Row(
                            children: [

                              CircleAvatar(
                                radius: 26.w,
                                backgroundColor: Colors.green,
                                child: const Icon(Icons.home, color: Colors.white),
                              ),

                              SizedBox(width: 10.w),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    user?.userName ??
                                        LocalizationsUtils.localizations.no_information,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),

                                  Text(
                                    user?.phoneNumber ??
                                        LocalizationsUtils.localizations.no_information,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// MENU GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final items = [
                        [Icons.storage, "Quản lý"],
                        [Icons.settings, "Giao diện"],
                        [Icons.search, "Hỗ trợ"],
                        [Icons.notifications, "Thông báo"],
                        [Icons.person, "Tài khoản"],
                        [Icons.card_giftcard, "Sản phẩm"],
                      ];

                      return menuItem(
                        items[index][0] as IconData,
                        items[index][1] as String,
                      );
                    },
                  ),

                  SizedBox(height: 42.h),

                  /// LOGOUT
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      cubit.removeToken();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteName.loginScreen,
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
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
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              LocalizationsUtils.localizations.logout,
                              style: AppTextStyle.textSm.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.red14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget menuItem(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1ABC9C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1ABC9C),
              size: 20,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}