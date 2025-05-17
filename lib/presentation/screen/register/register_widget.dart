import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/enums/load_status.dart';
import 'package:solar_energy/presentation/screen/register/Bloc/register_cubit.dart';

import '../../../application/constants/app_color.dart';
import '../../../application/constants/app_text_style.dart';
import '../../../application/cubit/app_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../common_widgets/app_button.dart';
import '../../common_widgets/app_lable_text_field.dart';
import '../../common_widgets/app_toast.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late RegisterCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<RegisterCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.only(left: 4.sp),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16.sp,
                  color: AppColors.white,
                )),
          ),
          title: Text(
            "Đăng ký",
            style: AppTextStyle.textBase
                .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
          ),
          backgroundColor: AppColors.blueF8,
        ),
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (BuildContext context, RegisterState state) {
            if (state.loadStatus == LoadStatus.loading) {
              BlocProvider.of<AppCubit>(context).showLoading();
              return;
            }
            if (state.loadStatus == LoadStatus.success) {
              BlocProvider.of<AppCubit>(context).hideShowLoading();
              AppToast.showToastSuccess(title: state.message);
              Navigator.pop(context);
              return;
            }
            if (state.loadStatus == LoadStatus.failure) {
              BlocProvider.of<AppCubit>(context).hideShowLoading();
              AppToast.showToastError(title: state.message);
              return;
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // header
                SizedBox(
                  height: 1.sh / 4,
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
                      // Text(
                      //   "Kra Power",
                      //   style: AppTextStyle.textBase.copyWith(
                      //     color: const Color(0xFFCA2E39),
                      //     fontWeight: FontWeight.w600,
                      //     shadows: [
                      //       Shadow(
                      //         color: Colors.black.withOpacity(0.3),
                      //         offset: const Offset(2, 2),
                      //         blurRadius: 4,
                      //       ),
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // )
                    ],
                  ),
                ),
                Column(children: [
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                        previous.gmail != current.gmail ||
                        previous.gmailError != current.gmailError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.mail_lock,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Gmail",
                      errorMessage: state.gmailError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      maxLine: 1,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(mail: value),
                      defaultValue: state.gmail,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.fullName != current.fullName ||
                        previous.fullNameError != current.fullNameError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Họ và tên",
                      maxLine: 1,
                      errorMessage: state.fullNameError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(name: value),
                      defaultValue: state.fullName,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.phoneNumber != current.phoneNumber ||
                        previous.phoneNumberError != current.phoneNumberError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Số điên thoại",
                      maxLine: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                      keyboardType: TextInputType.number,
                      errorMessage: state.phoneNumberError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(phoneNumber: value),
                      defaultValue: state.phoneNumber,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.accountName != current.accountName ||
                        previous.accountNameError != current.accountNameError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Tên tài khoản",
                      maxLine: 1,
                      errorMessage: state.accountNameError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(accountName: value),
                      defaultValue: state.accountName,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.password != current.password ||
                        previous.passwordError != current.passwordError || previous.showPass != current.showPass,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.mail_lock,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          final values = !state.showPass;
                          cubit.changeQuery(showPass: values);
                        },
                        child: Icon(
                          state.showPass ? Icons.visibility_off : Icons.visibility,
                          size: 24.r,
                          color: AppColors.blueF8,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Mật khẩu",
                      obscureText: !state.showPass,
                      maxLine: 1,
                      errorMessage: state.passwordError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(password: value),
                      defaultValue: state.password,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.confirmPassword != current.confirmPassword ||
                        previous.confirmPasswordError != current.confirmPasswordError || previous.showPassConfirm != current.showPassConfirm,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      prefixIcon: Icon(
                        Icons.mail_lock,
                        size: 24.r,
                        color: AppColors.blueF8,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          final values = !state.showPassConfirm;
                          cubit.changeQuery(showPassConfirm: values);
                        },
                        child: Icon(
                          state.showPassConfirm ? Icons.visibility_off : Icons.visibility,
                          size: 24.r,
                          color: AppColors.blueF8,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                      hintText: "Nhập lại mật khẩu",
                      maxLine: 1,
                      obscureText: !state.showPassConfirm,
                      errorMessage: state.confirmPasswordError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(confirmPassword: value),
                      defaultValue: state.confirmPassword,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.projectName != current.projectName ||
                        previous.projectNameError != current.projectNameError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                      label: "Tên dự án",
                      maxLine: 3,
                      textStyleLabel: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                      obscureText: false,
                      errorMessage: state.projectNameError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(projectName: value),
                      defaultValue: state.projectName,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(12.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.descriptionProject != current.descriptionProject ||
                        previous.descriptionProjectError != current.descriptionProjectError,
                    builder: (context, state) => CustomLabelTextField(
                      radius: 8.r,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                      label: "Mô tả dự án",
                      maxLine: 10,
                      textStyleLabel: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                      hintText: "Mô tả...",
                      obscureText: false,
                      errorMessage: state.descriptionProjectError,
                      colorBorder: AppColors.white,
                      backgroundColor: AppColors.greyFB,
                      textStyleHint: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.5)),
                      onChanged: (value) => cubit.changeQuery(descriptionProject: value),
                      defaultValue: state.descriptionProject,
                      textStyleInput: AppTextStyle.textSm.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Gap(32.h),
                  button(title: "Đăng Ký", callBack: () async {
                    if(cubit.validate()){
                      await cubit.sendMail();
                    }
                  },),
                ])
              ],
            ),
          ),
        ));
  }

  Widget inputText(
      {required String content,
      required String title,
      String? errorMessage,
      required Widget iconPrefix,
      Widget? iconSuffix,
      bool showPass = false}) {
    return CustomLabelTextField(
      radius: 8.r,
      prefixIcon: iconPrefix,
      suffixIcon: GestureDetector(onTap: () {}, child: iconSuffix),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
      hintText: title,
      obscureText: showPass,
      errorMessage: errorMessage,
      colorBorder: AppColors.white,
      backgroundColor: AppColors.greyFB,
      textStyleHint: AppTextStyle.textSm
          .copyWith(color: AppColors.textPrimary.withOpacity(0.5)),
      //onChanged: (value) => cubit.changeDataQuery(userName: value),
      //defaultValue: content,
      textStyleInput: AppTextStyle.textSm
          .copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
    );
  }

  Widget button({required String title, VoidCallback? callBack}) {
    return AppButton(
      onPressed: () async {
        callBack?.call();
      },
      title: title,
      color: AppColors.blue,
      fontSize: 12.sp,
      heightText: 16.sp / 12.sp,
      textColor: AppColors.white,
      radius: 8.r,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
    );
  }
}
