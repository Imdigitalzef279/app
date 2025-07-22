import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/common_widgets/app_button.dart';
import 'package:solar_energy/presentation/common_widgets/app_lable_text_field.dart';
import 'package:solar_energy/presentation/common_widgets/app_loading.dart';
import 'package:solar_energy/presentation/common_widgets/app_toast.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/auth/bloc/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ValueNotifier<bool> check;
  late final LoginCubit cubit;

  @override
  void initState() {
    super.initState();
    check = ValueNotifier(false);
    cubit = BlocProvider.of(context);

    checkToken();
  }

  Future<void> checkToken() async {
    if (await cubit.checkToken()) {
      AppToast.showToastSuccess(title: "Đăng nhập thành công");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeWidget()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đăng nhập",
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        backgroundColor: AppColors.blueF8,
      ),
      backgroundColor: AppColors.white,
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            previous.request.status != current.request.status,
        listener: (context, state) async {
          if (state.request.status == LoadStatus.loading) {
            showDialog(
                context: context,
                builder: (context) => const AppLoading(),
                barrierDismissible: false);
            Future.delayed(
              const Duration(seconds: 15),
              () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                  cubit.state.copyWith(error: "Kết nối không ổn định !!!");
                  ;
                }
                if (state.error == "Kết nối không ổn định !!!") {
                  AppToast.showToastError(title: state.error);
                }
              },
            );
          }
          if (state.request.status == LoadStatus.failure) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            if (state.error != "") {
              AppToast.showToastError(title: state.error);
            }
          }
          if (state.request.status == LoadStatus.success) {
            AppToast.showToastSuccess(title: "Đăng nhập thành công");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeWidget()),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // header
                SizedBox(
                  height: 1.sh / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 100.h,
                              width: 1.sw,
                              child: Assets.images.logo.image(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                12.verticalSpace,
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (BuildContext context, state) {
                    return Column(children: [
                      username(),
                      Gap(12.h),
                      password(),
                      Gap(12.h),
                      Row(
                        children: [
                          buttonRegister(),
                        ],
                      ),
                      Gap(32.h),
                      Column(
                        children: [
                          buttonLogin(),
                          Gap(32.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 42.w),
                            child: const Divider(color: AppColors.greyE5),
                          ),
                          loginTest(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) => Checkbox(
                                  shape: const CircleBorder(),
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return Colors
                                            .white; // Color when disabled
                                      }
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return AppColors
                                            .blueF8; // Color when selected
                                      }
                                      return Colors.white; // Default color
                                    },
                                  ),
                                  value: state.clause,
                                  onChanged: (value) => {
                                    cubit.changeDataQuery(
                                        clause: !state.clause),
                                  },
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                "Tôi đồng ý với điều khoản dịch vụ và chính sách bảo mật của Kra Power",
                                style: AppTextStyle.textXs.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w400),
                              ))
                            ],
                          )
                        ],
                      )
                    ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget username() {
    return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) => CustomLabelTextField(
              radius: 8.r,
              prefixIcon: Icon(
                Icons.account_circle,
                color: AppColors.blueF8,
                size: 24.r,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              hintText: "Tên đăng nhập",
              errorMessage: state.errorUserName,
              colorBorder: AppColors.white,
              backgroundColor: AppColors.greyFB,
              textStyleHint: AppTextStyle.textSm
                  .copyWith(color: AppColors.textPrimary.withOpacity(0.5)),
              onChanged: (value) => cubit.changeDataQuery(userName: value),
              defaultValue: state.userName,
              textStyleInput: AppTextStyle.textSm.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            ));
  }

  Widget password() {
    return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) => CustomLabelTextField(
              radius: 8.r,
              //colorBorder: AppColors.white,
              prefixIcon: Icon(
                Icons.lock_person_rounded,
                color: AppColors.blueF8,
                size: 24.r,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  cubit.showPass();
                },
                child: Icon(
                  state.showPass ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grey73.withOpacity(0.5),
                ),
              ),
              obscureText: !state.showPass,
              colorBorder: AppColors.white,
              backgroundColor: AppColors.greyFB,
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
              errorMessage: state.errorPassword,
              onChanged: (value) => cubit.changeDataQuery(password: value),
              hintText: "Mật Khẩu",
              defaultValue: state.password,
              textStyleHint: AppTextStyle.textSm
                  .copyWith(color: AppColors.textPrimary.withOpacity(0.5)),
              textStyleInput: AppTextStyle.textSm.copyWith(
                  color: AppColors.textPrimary, fontWeight: FontWeight.w600),
            ));
  }

  Widget buttonLogin() {
    return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) => AppButton(
              onPressed: () async {
                await cubit.login();
              },
              title: "Đăng nhập",
              color: AppColors.blue,
              fontSize: 12.sp,
              heightText: 16.sp / 12.sp,
              textColor: AppColors.white,
              radius: 8.r,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
            ));
  }

  Widget buttonRegister() {
    return InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: () {
          Navigator.pushNamed(context, RouteName.registerWidget);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
          child: Text(
            "Chưa có tài khoản? Đăng ký ngay",
            style: AppTextStyle.textSm.copyWith(color: AppColors.blue),
          ),
        ));
  }

  Widget loginTest() {
    return InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: () {
          cubit.loginTest();
        },
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
          child: Text(
            "Đăng nhập thử nghiệm",
            style: AppTextStyle.textSm.copyWith(color: AppColors.blue),
          ),
        ));
  }
}
