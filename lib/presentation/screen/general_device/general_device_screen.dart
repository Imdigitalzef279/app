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
    "assets/images/1.webp",
    "assets/images/2.webp",
    "assets/images/3.webp"
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

    return Container(
      color: Colors.white, // Nền trắng tinh
      child: Stack(
        children: [
          // Lớp bọc ngoài cùng chứa hiệu ứng Mesh Gradient (Ánh sáng hắt)
          Positioned(
            top: 150.h,
            left: -50.w,
            right: -50.w,
            child: Container(
              height: 350.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // Màu xanh lá ngọc (Mint/Jade) với độ trong suốt 15%
                    color: const Color(0xFF00E676).withOpacity(0.15),
                    blurRadius: 150, // Độ nhòe siêu lớn để hòa tan màu
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -50.h,
            right: -20.w,
            child: Container(
              width: 250.w,
              height: 250.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // Màu xanh lam nhạt với độ trong suốt 12%
                    color: const Color(0xFF00B4D8).withOpacity(0.12),
                    blurRadius: 120,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent, // Nền trong suốt
            appBar: AppBar(
              toolbarHeight: 80.h,
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              forceMaterialTransparency: true,

              // 1. THÊM DÒNG NÀY ĐỂ XÓA MŨI TÊN TRÁI (ARROW LEFT)
              automaticallyImplyLeading: false,

              titleSpacing: 16.w,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo nằm tách biệt bên trái
                  Image.asset(
                    "assets/images/logo.png",
                    height: 26.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 12.w),

                  // Cụm Title và Trạng thái nằm bên phải Logo
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nhà máy ${widget.project.name}",
                          style: AppTextStyle.textBase.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              "Đang hoạt động",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(
                                    0xFF20C997), // Giữ màu xanh ngọc cho đẹp
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Vị trí : Hà Nội",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. TRẢ LẠI CHÍNH XÁC 3 NÚT BẤM CỦA BẠN (CÓ DẤU +)
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black54),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none,
                      color: Colors.black54),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined,
                      color: Colors.black54),
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
                              // Chỉnh bo góc cho banner giống trong ảnh
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.asset(
                                    _banners[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                        ? const Color(0xFF20C997) // Xanh ngọc
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

                    SizedBox(height: 24.h),

                    // ================= 2. TÍNH NĂNG =================
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
                          SizedBox(height: 16.h),

                          // THẺ CARD LỚN BỌC TẤT CẢ TÍNH NĂNG
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white, // Nền trắng cho Card
                              borderRadius:
                                  BorderRadius.circular(16.r), // Bo góc Card
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00B4D8)
                                      .withOpacity(0.12), // Đổ bóng xanh ngọc
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(
                                      0, 6), // Bóng đổ xuôi xuống dưới
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // Thêm padding right để lướt mượt không bị sát lề
                              padding: EdgeInsets.only(right: 8.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _featureIconItem(
                                    imagePath:
                                        "assets/images/Quan_ly_thiet_bi.png",
                                    title: "Quản lý\nthết bị",
                                    color: Colors.blue,
                                  ),
                                  _featureIconItem(
                                    imagePath: "assets/images/nangluong.png",
                                    title: "Phân tích \nnăng lượng",
                                    color: Colors.purple,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider(
                                            create: (_) => DeviceCubit(),
                                            child: AutomatListScreen(
                                              powerStationId:
                                                  widget.project.id!,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  _featureIconItem(
                                    imagePath: "assets/images/moitruong.png",
                                    title: "Thiết bị\nmôi trường",
                                    color: Colors
                                        .green, // Đổi màu mờ nền icon cho đa dạng
                                  ),
                                  _featureIconItem(
                                    imagePath: "assets/images/kra.png",
                                    title: "KRA Smart \n Safety",
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // ================= 4. THIẾT BỊ HAY DÙNG =================
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
                          SizedBox(height: 12.h),

                          // Danh sách dọc thay vì lướt ngang
                          _deviceListItem(
                            imagePath: "assets/images/circuit_breaker.png",
                            title: "MCB-001",
                            status: "Đang bật",
                            powerText: "P=0.5W",
                            isSwitched: true,
                            onSwitchChanged: (value) {
                              // Gọi hàm xử lý bật tắt ở đây sau
                            },
                          ),
                          _deviceListItem(
                            imagePath: "assets/images/pump.png",
                            title: "Bơm Nước 1",
                            status: "Đang chạy",
                            powerText: "P=11KW",
                            isSwitched: true,
                          ),
                          _deviceListItem(
                            imagePath: "assets/images/circuit_breaker.png",
                            title: "MCB-001",
                            status: "Đang bật",
                            powerText: "P=0.5W",
                            isSwitched: true,
                            onSwitchChanged: (value) {
                              // Gọi hàm xử lý bật tắt ở đây sau
                            },
                          ),
                          _deviceListItem(
                            imagePath: "assets/images/pump.png",
                            title: "Bơm Nước 1",
                            status: "Đang chạy",
                            powerText: "P=11KW",
                            isSwitched: true,
                          ),

                          SizedBox(height: 30.h), // Khoảng trống lề dưới cùng
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== WIDGET CON: NÚT TÍNH NĂNG THEO STYLE ẢNH MỚI =====
  Widget _featureIconItem({
    IconData? icon,
    String? imagePath,
    required String title,
    String? subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    final bool isUsingImage = imagePath != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w, // Chiều rộng cố định để các text không bị xô lệch
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: isUsingImage ? EdgeInsets.zero : EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color:
                    isUsingImage ? Colors.transparent : color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: isUsingImage
                  ? Image.asset(
                      imagePath,
                      width: 52.w,
                      height: 52.w,
                      fit: BoxFit.contain,
                    )
                  : Icon(icon, color: color, size: 28.w),
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
          ],
        ),
      ),
    );
  }

  // ===== WIDGET CON: DANH SÁCH THIẾT BỊ BỌC TRONG THẺ CARD TRẮNG ĐỔ BÓNG VỚI ẢNH MỚI =====
  Widget _deviceListItem({
    required String imagePath,
    required String title,
    required String status,
    String? powerText,
    bool isSwitched = false,
    ValueChanged<bool>? onSwitchChanged,
  }) {
    return Container(
      // margin thay cho Padding cũ để tạo khoảng cách giữa các thẻ
      margin: EdgeInsets.only(bottom: 16.h),
      // padding bên trong thẻ Card để nội dung không bị sát viền
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white, // Nền trắng cho Card
        borderRadius:
            BorderRadius.circular(16.r), // Bo góc giống phần Tính năng
        boxShadow: [
          BoxShadow(
            color:
                const Color(0xFF00B4D8).withOpacity(0.12), // Đổ bóng xanh ngọc
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6), // Bóng đổ xuôi xuống dưới
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Biểu tượng hình ảnh bên trái (Không còn nền khung xanh)
          Image.asset(
            imagePath,
            width: 48.w, // Kích thước biểu tượng nhỏ hơn
            height: 48.w,
            fit: BoxFit.contain,
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
                SizedBox(height: 2.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: (status == "Đang bật" || status == "Đang chạy")
                        ? const Color(
                            0xFF20C997) // Màu xanh như ảnh người dùng hoặc xanh ngọc
                        : Colors.grey, // Màu xám cho "Đang tắt"
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (powerText != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    powerText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey, // Chữ công suất màu xám
                    ),
                  ),
                ],
              ],
            ),
          ),

          // 3. Công tắc (Switch) hiển thị sát lề phải
          // 3. Công tắc (Switch) hiển thị sát lề phải
          Transform.scale(
            scale: 0.9, // Cho công tắc to lên một xíu nhìn cho cân đối
            child: Switch.adaptive(
              value: isSwitched,
              // THAY ĐỔI: Đổi màu nền của công tắc lúc bật sang màu xanh lá ngọc
              activeTrackColor: const Color(0xFF63C77D),

              // Cục tròn lúc tắt (mặc định là xám/trắng tùy HDH, nên set cố định màu trắng)
              inactiveThumbColor: Colors.white,

              // Nền lúc tắt (Xám nhạt)
              inactiveTrackColor: Colors.grey.shade300,

              // Bỏ viền đen bao quanh cục tròn lúc tắt (chỉ áp dụng từ Flutter 3.16+)
              trackOutlineColor: MaterialStateProperty.all(Colors.transparent),

              onChanged: onSwitchChanged ?? (val) {},
            ),
          ),
        ],
      ),
    );
  }
}
