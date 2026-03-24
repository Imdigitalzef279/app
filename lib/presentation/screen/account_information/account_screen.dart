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
import '../../../data/dto/device/response/device_response.dart';
import '../Electricity/automat/device_info_screen/device_info_screen.dart';
import '../general_device/notification/notification_screen.dart';
import 'AccountDetailScreen.dart';
import 'DeviceManagementScreen.dart';
import 'GuideScreen.dart';
import 'SupportScreen.dart';
import 'ThemeScreen.dart';

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
        body: AnimatedBg(
            child: Stack(
                children: [

                  /// 🌟 GLOW (3D effect)
                  Positioned(
                    top: -60,
                    left: -40,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.25),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -80,
                    right: -60,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.greenAccent.withOpacity(0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// 📱 UI chính của bạn
                  BlocConsumer<AccountCubit, AccountState>(
                    listener: (context, state) {
                      state.request.when(
                        loading: () => context.read<AppCubit>().showLoading(),
                        success: (_) =>
                            context.read<AppCubit>().hideShowLoading(),
                        error: (_) =>
                            context.read<AppCubit>().hideShowLoading(),
                      );
                    },
                    builder: (context, state) {
                      final user = state.request.data;

                      return SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: Column(
                            children: [

                              /// HEADER
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Color(0xFF1ABC9C)
                                        .withOpacity(0.1),
                                    child: Icon(
                                        Icons.person, color: Color(0xFF1ABC9C)),
                                  ),
                                  SizedBox(width: 10.w),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          user?.name ?? "User",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Tài khoản",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Image.asset(
                                    "assets/images/logo.png",
                                    height: 36,
                                  ),

                                  SizedBox(width: 6),

                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      cubit.removeToken();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteName.loginScreen,
                                            (route) => false,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.red14.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Assets.icons.signOutAlt.svg(
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.red14,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.h),

                              Spacer(),

                              /// GRID
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 7,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12.w,
                                  mainAxisSpacing: 12.h,
                                  childAspectRatio: 0.9,
                                ),
                                itemBuilder: (context, index) {
                                  final items = [
                                    [Icons.devices, "Quản lý thiết bị"],
                                    [Icons.menu_book, "Hướng dẫn sử dụng"],
                                    [Icons.support_agent, "Hỗ trợ kỹ thuật"],
                                    [Icons.palette, "Giao diện"],
                                    [Icons.notifications, "Thông báo"],
                                    [Icons.person, "Tài khoản"],
                                    [Icons.person, "Quản lý thiết bị bảo hành"],
                                  ];

                                  return _menuItem(
                                    items[index][0] as IconData,
                                    items[index][1] as String,
                                    index,
                                  );
                                },
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ]
            )
        )
    );
  }

  Widget _menuItem(IconData icon, String title, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => DeviceManagementScreen()));
            break;

          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => GuideScreen()));
            break;

          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => SupportScreen()));
            break;

          case 3:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ThemeScreen()));
            break;

          case 4:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => NotificationScreen()));
            break;

          case 5:
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AccountDetailScreen()));
            break;

          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DeviceInfoScreen(
                  device: DeviceResponse(
                    id: 1,
                    name: "Demo Device",
                    serialNumber: "ABC123",
                    creator: "KRA",
                  ),
                ),
              ),
            );
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1ABC9C).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1ABC9C),
                size: 24,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AnimatedBg extends StatefulWidget {
  final Widget child;
  const AnimatedBg({super.key, required this.child});

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> {
  Alignment begin = Alignment.topLeft;
  Alignment end = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 6));
      setState(() {
        begin = begin == Alignment.topLeft
            ? Alignment.bottomLeft
            : Alignment.topLeft;
        end = end == Alignment.bottomRight
            ? Alignment.topRight
            : Alignment.bottomRight;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        AnimatedContainer(
          duration: const Duration(seconds: 6),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: const [
                Color(0xFF42E150),
                Color(0xFF97E14A),
                Colors.white,
              ],
            ),
          ),
        ),


        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: 0.18,
            child: Image.asset(
              "assets/images/backgrounds/36804.jpg",
              fit: BoxFit.cover,
              height: 260,
            ),
          ),
        ),

        /// CONTENT
        widget.child,
      ],
    );
  }
}