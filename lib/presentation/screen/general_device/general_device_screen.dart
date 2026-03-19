import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/general_device/project_setting_screen.dart';
import 'package:solar_energy/presentation/screen/general_device/scan_qr/scan_qr_screen.dart';
import '../../../data/dto/atomat/atomat_log_response.dart';
import '../../../data/dto/device/response/device_response.dart';
import '../../../data/dto/power_station/response/power_station_response.dart';
import '../../../data/services/signalr_service.dart';
import '../../widgets/password_dialog.dart';
import '../Electricity/automat/automat_chart/bloc/automat_chart_cubit.dart';
import '../Electricity/automat/automat_detail_screen.dart';
import '../Electricity/automat/automat_list_screen.dart';
import '../Electricity/automat/bloc/atomat_detail_cubit.dart';
import '../device/bloc/device_cubit.dart';
import '../device/device_card/device_card_widget.dart';
import '../kra_care/kra_care_screen.dart';
import 'ai_chat/ai_chat_screen.dart';

class GeneralDeviceScreen extends StatefulWidget {
  const GeneralDeviceScreen({super.key, required this.project});

  final PowerStationResponse project;

  @override
  State<GeneralDeviceScreen> createState() => _GeneralDeviceScreenState();
}
class _GeneralDeviceScreenState extends State<GeneralDeviceScreen>

    with TickerProviderStateMixin {
  bool _isGridView = true; // 👈 thêm dòng này
  late final AnimationController _controller;
  late bool isLandscape;
  late SignalRService signalR;
  StreamSubscription? _signalSub;
  int _currentIndex = 0;
  double _aiTop = 500;
  double _aiLeft = 300;

  bool _showChat = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    signalR = SignalRService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      final cubit = context.read<DeviceCubit>();
      final devices = cubit.state.resultDevices.data ?? [];
      /// load log lần đầu
      for (var d in devices) {
        if (d.code != null) {
          await cubit.loadBreakerLog(d.code);
        }
      }

      if (devices.isNotEmpty && devices.first.code != null) {
        for (var d in devices) {
          await signalR.connect(meterCode: d.code!);
        }
      }
      _signalSub = signalR.stream.listen((data) {
        if (!mounted) return; // 👈 THÊM DÒNG NÀY

        final dto = data["breakerMeterDataDto"];
        if (dto == null) return;

        final raw = Map<String, dynamic>.from(dto);

        raw.updateAll((key, value) {
          if (value is String) {
            final numValue = num.tryParse(value);
            return numValue ?? value;
          }
          return value;
        });

        final log = AtomatLogResponse.fromJson(raw);
        final code = raw["breakerSn"] ?? raw["meterSn"] ?? raw["deviceCode"];

        if (code == null) return;

        context.read<DeviceCubit>().updateRealtimeLogByCode(code, log);
      });

    });
  }
  @override
  void dispose() {
    _signalSub?.cancel();
    signalR.disconnect();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final devices =
       context.select((DeviceCubit c) => c.state.resultDevices.data) ?? [];
    final favoriteDevices =
    devices.where((d) => d.isFavorite).take(6).toList();
    String locationText = "Hà Nội";
    final bannerImages = [
      "assets/images/matis/1.png",
      "assets/images/matis/2.png",
      "assets/images/matis/4.png",
      "assets/images/matis/5.png",
    ];
    return Scaffold(
      backgroundColor: AppColors.greyFB,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 12,

          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 32,
              ),
              SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nhà máy ${widget.project.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Đang hoạt động",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "Vị trí: $locationText",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              /// 👇 icon nằm cùng hàng (đúng mẫu)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.add, size: 18),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScanQrScreen(),
                        ),
                      );
                    },
                  ),

                  SizedBox(width: 2), // 👈 giảm xuống cực nhỏ

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.notifications_none, size: 20),
                    onPressed: () {},
                  ),

                  SizedBox(width: 2), // 👈 giảm tiếp

                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.settings_outlined, size: 20),
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
                ],
              )
            ],
          ),
        ),
      body: Stack(
          children: [
      Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFDDF3EA),
                Color(0xFFEFF8F4),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),

          child: Column(
            children: [
              // ===== HEADER =====
              Container(
                height: 260, // 👈 tăng thêm
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: PageView.builder(
                    itemCount: bannerImages.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        bannerImages[index],
                        fit: BoxFit.contain, // 🔥 QUAN TRỌNG (thay cover)
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // ===== FEATURES =====
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizationsUtils.localizations.features,
                      style: AppTextStyle.textSm.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(10.h),
                    SizedBox(
                        height: 70.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          featureItem(
                            iconPath: "assets/icons/icons_new/icon_energy_meter.png",
                            title: "Năng lượng",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<DeviceCubit>(),
                                    child: AutomatListScreen(
                                      powerStationId: widget.project.id!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),


                      featureItem(
                        iconPath: "assets/icons/icons_new/icon_energy_analytics.png",
                        title: "Phân tích",
                      ),
                          featureItem(
                            iconPath: "assets/icons/icons_new/icon_environment.png",
                            title: "Môi trường",
                          ),
                          featureItem(
                            iconPath: "assets/icons/icons_new/icon_kra_smart_safety.png",
                            title: "KRA Care",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const KraCareScreen(),
                                ),
                              );
                            },
                          ),
                      ]
                    )
                    )
                ]
                ),
              ),
              SizedBox(height: 6.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Thiết bị hay dùng",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      Row(
                        children: [
                          /// 👇 NÚT ĐỔI VIEW
                          IconButton(
                            icon: Icon(
                              _isGridView ? Icons.grid_view : Icons.view_list,
                              size: 18,
                              color: Color(0xFF1ABC9C),
                            ),
                            onPressed: () {
                              setState(() {
                                _isGridView = !_isGridView;
                              });
                            },
                          ),

                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1ABC9C),
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14.sp,
                                  color: Color(0xFF1ABC9C),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Gap(4.h),
                  favoriteDevices.isEmpty
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      "Chưa có thiết bị hay dùng",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.sp,
                      ),
                    ),
                  )
                      : _isGridView
                      ? _buildFixed6AndScroll(
                      devices.where((d) => d.isFavorite).toList()
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: favoriteDevices.length,
                    itemBuilder: (context, index) {
                      return DeviceCardWidget(
                        device: favoriteDevices[index],
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),

      ),


            Positioned(
              top: _aiTop,
              left: _aiLeft,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _aiTop += details.delta.dy;
                    _aiLeft += details.delta.dx;


                    _aiTop = _aiTop.clamp(0, MediaQuery.of(context).size.height - 120);
                    _aiLeft = _aiLeft.clamp(0, MediaQuery.of(context).size.width - 80);
                  });
                },
                onTap: () {
                  setState(() {
                    _showChat = !_showChat;
                  });
                },
                child: _buildAiButton(),
              ),

            ),
            if (_showChat)
              Positioned(
                top: _aiTop - 360,
                left: _aiLeft - 200,
                child: AnimatedScale(
                  scale: _showChat ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  child: _buildChatBox(),
                ),
              ),
          ]
      )

    );

  }
  Widget _buildFixed6AndScroll(List<DeviceResponse> devices) {
    final chunks = <List<DeviceResponse>>[];

    for (int i = 0; i < devices.length; i += 6) {
      chunks.add(
        devices.sublist(
          i,
          i + 6 > devices.length ? devices.length : i + 6,
        ),
      );
    }

    return SizedBox(
      height: 120 * 2 + 8,
      child: PageView.builder(
        itemCount: chunks.length,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, pageIndex) {
          final pageDevices = chunks[pageIndex];

          return Column(
            children: [
              /// HÀNG 1
              Row(
                children: List.generate(3, (index) {
                  if (index >= pageDevices.length) {
                    return Expanded(child: SizedBox());
                  }
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      child: _deviceGridItem(pageDevices[index]),
                    ),
                  );
                }),
              ),

              SizedBox(height: 8),

              /// HÀNG 2
              Row(
                children: List.generate(3, (index) {
                  final i = index + 3;
                  if (i >= pageDevices.length) {
                    return Expanded(child: SizedBox());
                  }
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      child: _deviceGridItem(pageDevices[i]),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget featureItem({
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 70.w, // 👈 fix width để các item đều nhau
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🔥 ICON NGUYÊN BẢN (KHÔNG NỀN)
              Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                child: Image.asset(
                  iconPath,
                  width: 32.w,
                  height: 32.w,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget featureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
              )
            ],
          ),
      child: Row(
        children: [

          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
        )
    );
  }
  Widget _deviceGridItem(DeviceResponse device) {
    final state = context.watch<DeviceCubit>().state;

    final currentSwitch =
        state.breakerLogs[device.code]?.rlySta ??
            device.realtimeLog?.rlySta ??
            device.status ??
            0;

    final isOnline = device.status == 1;
    final isOn = currentSwitch == 1;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<DeviceCubit>(),
                ),
                BlocProvider(
                  create: (_) => AtomatDetailCubit(),
                ),
                BlocProvider(
                  create: (_) => AutomatChartCubit(),
                ),
              ],
              child: AutomatDetailScreen(device: device),
            ),
          ),
        );
      },

      child: Container(
        height: 105,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            /// HEADER
            Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF4F1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.power,
                    size: 13,
                    color: Color(0xFF6BB6A6),
                  ),
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name ?? device.code ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isOnline ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOnline ? "Online" : "Offline",
                            style: TextStyle(
                              fontSize: 9,
                              color: isOnline ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOn ? "Đóng" : "Cắt",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isOn ? Colors.green : Colors.red,
                  ),
                ),

                /// 🔥 FIX SWITCH KHÔNG BỊ CLICK CHỒNG
                SizedBox(
                  width: 50,
                  height: 30,
                  child: Switch(
                    value: isOn,
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF43A047),
                    inactiveTrackColor: const Color(0xFFE53935),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: isOnline
                        ? (value) async {
                      final password = await showPasswordDialog(context);
                      if (password == null) return;

                      await context.read<DeviceCubit>().togglePower(
                        device,
                        password: password,
                      );
                    }
                        : null,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _statCard({
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22.w,
            color: const Color(0xFF1ABC9C),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1ABC9C),
            ),
          ),
        ],
      ),
    );
  }
  Widget _deviceCard({
    required String title,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          Icon(icon, size: 30.w, color: color),
          SizedBox(height: 10.h),
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget itemService({
    required String name,
    required Widget icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: (1.sw - 68.w) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 4.h),
            Text(
              name,
              style: AppTextStyle.textXs.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildAiButton() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF1ABC9C),
              Color(0xFF6BB6A6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1ABC9C).withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.smart_toy,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    ],
  );
}

Widget _buildChatBox() {
  return Container(
    width: 280,
    height: 350,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
        )
      ],
    ),
    child: Column(
      children: [
        /// HEADER
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF2D6BFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Icon(Icons.smart_toy, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "AI Tư vấn",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),

        /// BODY
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              Text("Xin chào 👋"),
              Text("Bạn cần hỗ trợ gì?"),
            ],
          ),
        ),

        /// INPUT
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Nhập câu hỏi...",
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    ),
  );
}