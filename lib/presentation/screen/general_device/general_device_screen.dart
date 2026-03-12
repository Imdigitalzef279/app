import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/general_device/project_setting_screen.dart';

import '../../../data/dto/power_station/response/power_station_response.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../device/bloc/device_cubit.dart';
import 'dart:async';

class GeneralDeviceScreen extends StatefulWidget {
  const GeneralDeviceScreen({super.key, required this.project});

  final PowerStationResponse project;

  @override
  State<GeneralDeviceScreen> createState() => _GeneralDeviceScreenState();
}

class _GeneralDeviceScreenState extends State<GeneralDeviceScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late bool isLandscape;
  int _currentIndex = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  int _currentBanner = 0;

  // Danh sách ảnh trình chiếu
  final List<String> _banners = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentBanner < _banners.length - 1) {
        _currentBanner++;
      } else {
        _currentBanner = 0;
      }
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBanner,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor:
          Colors.white, // Đổi màu nền thành trắng hoàn toàn theo thiết kế mới
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16.w, // Đẩy logo ra một chút
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 24.h,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Nhà máy ${widget.project.name}",
                    style: AppTextStyle.textBase.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  "Đang hoạt động",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue, // Chữ xanh dương theo ảnh
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              "Vị trí : Hà Nội", // Thêm vị trí theo ảnh
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          // Thêm icon dấu + theo thiết kế mới
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProjectSettingScreen(
                    project: widget.project,
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= 1. BANNER TRÀN VIỀN =================
              SizedBox(
                height: 180.h, // Chiều cao banner
                width: double.infinity,
                child: Stack(
                  children: [
                    // 1. Ảnh Banner
                    PageView.builder(
                      controller: _bannerController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentBanner = index;
                        });
                        _startBannerTimer(); // Khi vuốt tay cũng reset timer tự động chạy
                      },
                      itemCount: _banners.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _banners[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),

                    // 2. Chấm tròn đè lên banner
                    Positioned(
                      bottom: 12.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_banners.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: _currentBanner == index ? 20.w : 8.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: _currentBanner == index
                                  ? const Color(0xFF8CC63F)
                                  : Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // ================= 2. TÍNH NĂNG (GIAO DIỆN MỚI )=================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tính năng",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                        color: Colors.orange.withOpacity(0.5),
                        thickness: 1), // Kẻ vạch trên
                    SizedBox(height: 12.h),

                    // Lướt ngang 6 tính năng cũ
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _featureIconItem(
                            icon: Icons.water_drop,
                            title: "Quản lý\nnước",
                            // subtitle: "Ổn định",
                            color: Colors.blue,
                          ),
                          _featureIconItem(
                            icon: Icons.flash_on,
                            title: "Tiết kiệm\nđiện",
                            // subtitle: "-12% hôm nay",
                            color: Colors.orange,
                          ),
                          _featureIconItem(
                            icon: Icons.bar_chart,
                            title: "Quản lý\nnăng lượng",
                            // subtitle: "3.2 kW",
                            color: Colors.purple,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => DeviceCubit(),
                                    child: AutomatListScreen(
                                      powerStationId: widget.project.id!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          _featureIconItem(
                            icon: Icons.health_and_safety,
                            title: "KRA Care",
                            // subtitle:
                            //     "Bảo vệ",
                            color: Colors.green,
                          ),
                          _featureIconItem(
                            icon: Icons.lightbulb,
                            title: "Quản lý\nchiếu sáng",
                            // subtitle: "5 phòng bật",
                            color: Colors.amber,
                          ),
                          _featureIconItem(
                            icon: Icons.water,
                            title: "Nước -\nNóng lạnh",
                            // subtitle: "Hoạt động tốt",
                            color: Colors.blueAccent,
                          ),
                          _featureIconItem(
                            icon: Icons.ac_unit,
                            title: "Điều hòa",
                            // subtitle: "26°C · 3 TB",
                            color: Colors.cyan,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 8.h),
                    // Divider(
                    //     color: Colors.yellow.withOpacity(0.8),
                    //     thickness: 1),
                  ],
                ),
              ),

              // SizedBox(height: 12.h),

              // ================= 3. KRA CARE (GIỮ LẠI TỪ CODE CŨ) =================
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: Container(
              //     padding: EdgeInsets.all(14.w),
              //     decoration: BoxDecoration(
              //       color: Colors.grey
              //           .shade50, // Chỉnh lại màu xám nhẹ cho hợp giao diện trắng
              //       borderRadius: BorderRadius.circular(16.r),
              //       border: Border.all(color: Colors.grey.shade200),
              //     ),
              //     child: Row(
              //       children: [
              //         const Icon(Icons.health_and_safety, color: Colors.green),
              //         SizedBox(width: 10.w),
              //         Expanded(
              //           child: Text(
              //             "KRA Care",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w600,
              //               fontSize: 14.sp,
              //             ),
              //           ),
              //         ),
              //         const Icon(Icons.arrow_forward_ios, size: 16),
              //       ],
              //     ),
              //   ),
              // ),

              SizedBox(height: 20.h),

              // ================= 4. THIẾT BỊ HAY DÙNG (GIAO DIỆN MỚI + DATA CŨ) =================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thiết bị hay dùng",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Divider(
                        color: Colors.yellow.withOpacity(0.8),
                        thickness: 1), // Kẻ vạch vàng
                    SizedBox(height: 12.h),

                    // Danh sách dọc thay vì lướt ngang
                    _deviceListItem(
                      title: "MCB-001",
                      status: "Đang bật",
                      powerText: "P=0.5W",
                      color: Colors.green,
                      icon: Icons.power,
                      isSwitched: true, // Thêm dòng này: Công tắc bật (Xanh lá)
                      onSwitchChanged: (value) {
                        // Gọi hàm xử lý bật tắt ở đây sau
                      },
                    ),
                    _deviceListItem(
                      title: "Bơm Nước 1",
                      status: "Đang chạy",
                      powerText: "P=11KW",
                      color: Colors.blue,
                      icon: Icons.water,
                      isSwitched: true, // Công tắc bật
                    ),
                    _deviceListItem(
                      title: "MCB-001",
                      status: "Đang bật",
                      powerText: "P=0.5W",
                      color: Colors.green,
                      icon: Icons.power,
                      isSwitched: true, // Thêm dòng này: Công tắc bật (Xanh lá)
                      onSwitchChanged: (value) {
                        // Gọi hàm xử lý bật tắt ở đây sau
                      },
                    ),
                    _deviceListItem(
                      title: "Bơm Nước 1",
                      status: "Đang chạy",
                      powerText: "P=11KW",
                      color: Colors.blue,
                      icon: Icons.water,
                      isSwitched: true, // Công tắc bật
                    ),
                    _deviceListItem(
                      title: "Điều hòa phòng ngủ 1",
                      status: "Đang tắt", // Ví dụ trạng thái tắt
                      color: Colors.grey, // Đổi màu trạng thái thành xám
                      icon: Icons.ac_unit,
                      isSwitched: false, // Công tắc tắt (Xám)
                    ),

                    SizedBox(height: 30.h), // Khoảng trống lề dưới cùng
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== WIDGET CON: NÚT TÍNH NĂNG THEO STYLE ẢNH MỚI =====
  Widget _featureIconItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w, // Rộng vừa đủ
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, color: color, size: 28.w),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 4.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ THEO STYLE ẢNH MỚI =====
  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ BỔ SUNG SWITCH =====
  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ BỔ SUNG SWITCH (ĐÃ XÓA ICON CÀI ĐẶT) =====
  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ BỔ SUNG SWITCH (ĐÃ XÓA ICON CÀI ĐẶT) =====
  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ BỔ SUNG SWITCH VÀ CÔNG SUẤT =====
  Widget _deviceListItem({
    required String title,
    required String status,
    String? powerText, // BỔ SUNG THÊM DÒNG NÀY ĐỂ NHẬN CHỮ "P=..."
    required Color color,
    required IconData icon,
    bool isSwitched = false,
    ValueChanged<bool>? onSwitchChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Khung icon bên trái
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(width: 16.w),

          // 2. Chi tiết text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // --- BỔ SUNG ĐOẠN NÀY ĐỂ HIỆN DÒNG P = 0.5W ---
                if (powerText != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    powerText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey, // Chữ màu xám theo thiết kế
                    ),
                  ),
                ],
              ],
            ),
          ),

          // 3. Công tắc (Switch) hiển thị sát lề phải
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              value: isSwitched,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF65C466),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
              onChanged: onSwitchChanged ?? (val) {},
            ),
          ),
        ],
      ),
    );
  }
}
