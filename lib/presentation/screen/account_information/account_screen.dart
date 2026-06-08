import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import '../../../application/cubit/app_cubit.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../Electricity/automat/import_device/import_device_screen.dart';
import '../device/bloc/device_cubit.dart';
import '../general_device/project_setting_screen.dart';
import 'AccountDetailScreen.dart';
import 'DeviceLifecycle/DeviceLifecycleScreen.dart';
import 'DeviceLifecycle/bloc/DeviceLifecycleCubit.dart';


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
        body: Container(
          color: Color(0xFFF5F6FA), // nền xám nhạt iOS
          child: BlocConsumer<AccountCubit, AccountState>(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// ===== HEADER (KHÔNG CARD) =====
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.name ?? "User",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Quản lý tài khoản",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  /// TAG nhỏ
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "1  • 0 thiết bị",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// AVATAR TO
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: user?.avatar != null
                                  ? NetworkImage(user!.avatar!)
                                  : null,
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        /// ===== PHONE CARD (CHỈ 1 CÁI) =====
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                            Text(user?.phoneNumber ?? ""),
                              Spacer(),
                              CircleAvatar(
                                radius: 10,
                                backgroundImage:
                                NetworkImage("https://i.pravatar.cc/100"),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.add, size: 16),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        /// ===== MENU LIST =====
                        /// ===== MENU CHUNG =====
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _item(Icons.person, "Tài khoản", Colors.blue, 0),
                              _divider(),
                              _item(Icons.language, "Ngôn ngữ", Colors.orange, 2),
                              _divider(),
                              _item(Icons.settings, "Cài đặt chung", Colors.grey, 3),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        /// ===== KRA-DLM =====
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: _item(
                            Icons.devices,
                            "KRA-DLM\nQuản lý Vòng Đời Thiết Bị",
                            Colors.green,
                            1,
                          ),
                        ),

                        SizedBox(height: 16),

                        Spacer(),

                        /// ===== ĐĂNG XUẤT =====
                        _buildLogoutButton(),
                      ],
                    )
                )
              );
            },
          ),
        ),
    );
  }
  Widget _item(IconData icon, String title, Color color, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2),
      child: ListTile(
        leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),

        title: Text(title),

        trailing: Icon(
          Icons.chevron_right,
          size: 18,
          color: Colors.grey.shade400,
        ),

        onTap: () {
          _handleNavigate(index);
        },
      ),
    );
  }
  void _handleNavigate(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AccountDetailScreen()),
        );
        break;

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => DeviceLifecycleCubit(),
              child: const DeviceLifecycleScreen(),
            ),
          ),
        );
        break;

      case 2:
        _showLanguageBottomSheet();
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProjectSettingScreen(
              project: PowerStationResponse(), //
            ),
          ),
        );
        break;

      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImportDeviceScreen(powerStationId: 1),
          ),
        );
        break;
    }
  }
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Đăng xuất"),
          content: Text("Bạn có chắc muốn đăng xuất không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Huỷ"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              child: Text("Đăng xuất"),
            ),
          ],
        );
      },
    );
  }
  Widget _buildLogoutButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.logout, color: Colors.red),
        ),
        title: Text(
          "Đăng xuất",
          style: TextStyle(color: Colors.red),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () => _confirmLogout(),
      ),
    );
  }
  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Chọn ngôn ngữ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              ListTile(
                leading: Text("🇻🇳"),
                title: Text("Tiếng Việt"),
                onTap: () {
                  context.setLocale(Locale('vi'));
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Text("🇺🇸"),
                title: Text("English"),
                onTap: () {
                  context.setLocale(Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _divider() {
    return Padding(
      padding: EdgeInsets.only(left: 56),
      child: Divider(
        height: 0.3,
        thickness: 0.3,
        color: Colors.grey.shade300,
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

