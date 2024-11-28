import 'package:flutter/material.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/account_information/account_screen.dart';
import 'package:solar_energy/presentation/screen/home_page/home_page_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late int indexPage;

  @override
  void initState() {
    super.initState();
    indexPage = (0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            indexPage = index;
          });
        },
        selectedIndex: indexPage,
        backgroundColor: Colors.white,
        indicatorColor: Colors.blue.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.home_rounded, color: Colors.blue),
            icon: const Icon(Icons.home_outlined),
            label: LocalizationsUtils.localizations.home,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.build_circle, color: Colors.blue),
            icon: const Icon(Icons.build_circle_outlined),
            label: LocalizationsUtils.localizations.maintenance,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.developer_board, color: Colors.blue),
            icon: const Icon(Icons.developer_board),
            label: LocalizationsUtils.localizations.device,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.account_circle, color: Colors.blue),
            icon: const Icon(Icons.account_circle_outlined),
            label: LocalizationsUtils.localizations.me,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (indexPage) {
      case 0:
        return const HomePageWidget();
      case 1:
        return Center(
          child: Text(
            LocalizationsUtils.localizations.maintenance,
            style: AppTextStyle.textXl,
          ),
        );
      case 2:
        return Center(
          child: Text(
            LocalizationsUtils.localizations.device,
            style: AppTextStyle.textXl,
          ),
        );
      case 3:
        return const AccountScreen();
      default:
        return Center(
            child: Text(
          LocalizationsUtils.localizations.home,
          style: AppTextStyle.textXl,
        ));
    }
  }
}
