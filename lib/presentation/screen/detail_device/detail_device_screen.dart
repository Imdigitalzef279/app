import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/gen/assets.gen.dart';
import 'package:solar_energy/presentation/screen/alarm_infor/alarm_infor_screen.dart';
import 'package:solar_energy/presentation/screen/infor_device/info_device_screen.dart';

import '../../../data/dto/device/response/device_response.dart';

class DetailDeviceScreen extends StatefulWidget {
  const DetailDeviceScreen({super.key, required this.device});

  final DeviceResponse device;

  @override
  State<DetailDeviceScreen> createState() => _DetailDeviceScreenState();
}

class _DetailDeviceScreenState extends State<DetailDeviceScreen> {
  late int indexPage;
  late List<bool> _tabLoaded;

  @override
  void initState() {
    super.initState();
    indexPage = (0);
    _tabLoaded = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          widget.device.name,
          style: AppTextStyle.textBase.copyWith(
              color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            indexPage = index;
            _tabLoaded[index] = true;
          });
        },
        selectedIndex: indexPage,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            selectedIcon: Assets.icons.bell.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.bellLine.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: LocalizationsUtils.localizations.alarm_information,
          ),
          NavigationDestination(
            selectedIcon: Assets.icons.info.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            icon: Assets.icons.infoLine.svg(
                width: 16.w,
                height: 16.w,
                colorFilter:
                    const ColorFilter.mode(AppColors.grey73, BlendMode.srcIn)),
            label: LocalizationsUtils.localizations.device_information,
          ),
        ],
      ),
      body: IndexedStack(
        index: indexPage,
        children: [
          _tabLoaded[0]
              ? InfoDeviceScreen(
                  deviceResponse: widget.device,
                )
              : const SizedBox(),
          _tabLoaded[1] ? const AlarmInfoScreen() : const SizedBox(),
        ],
      ),
    );
  }
}
