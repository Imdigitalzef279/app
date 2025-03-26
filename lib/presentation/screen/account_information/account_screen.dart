import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import 'package:solar_energy/presentation/screen/account_information/widget/basic_account_widget.dart';
import 'package:solar_energy/presentation/screen/account_information/widget/item_option_widget.dart';

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
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      cubit.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (BuildContext context, AccountState state){
          state.request.when(
              loading: () => BlocProvider.of<AppCubit>(context).showLoading(),
              success: (data) => BlocProvider.of<AppCubit>(context).hideShowLoading(),
              error: (error) => BlocProvider.of<AppCubit>(context).hideShowLoading(),
          );
        },
        builder: (context, state) =>  SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                BasicAccountWidget(
                  email: state.request.data?.email ?? "Không có thông tin",
                  userName: state.request.data?.userName ?? "Không có thông tin",
                  imageLink:
                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                ),
                SizedBox(
                  height: 12.h,
                ),
                container(
                    child: Column(
                  children: [
                    ItemOptionWidget(
                      icon: Icon(
                        Icons.account_circle,
                        size: 22.w,
                      ),
                      optionName: "${state.request.data?.surname} ${state.request.data?.name}",
                    ),
                    const Divider(
                      color: AppColors.greyFB,
                    ),
                    ItemOptionWidget(
                      icon: Icon(
                        Icons.attach_email,
                        size: 22.w,
                      ),
                      optionName: state.request.data?.email ?? "Không có thông tin",
                    ),
                    const Divider(
                      color: AppColors.greyFB,
                    ),
                    ItemOptionWidget(
                      icon: Icon(
                        Icons.phone_android,
                        size: 22.w,
                      ),
                      optionName: state.request.data?.phoneNumber ?? "Không có thông tin",
                    )
                  ],
                )),
                SizedBox(
                  height: 42.h,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    cubit.removeToken();
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteName.loginScreen, (Route<dynamic> route) => false);
                  },
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
