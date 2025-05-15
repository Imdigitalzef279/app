import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/app_text_style.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import 'package:solar_energy/presentation/screen/account_information/account_screen.dart';
import 'package:solar_energy/presentation/screen/home_page/bloc/home_page_cubit.dart';
import 'package:solar_energy/presentation/screen/home_page/home_page_widget.dart';
import 'package:solar_energy/presentation/screen/service_solar/widget/service_screen.dart';

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
            icon: const Icon(
              Icons.home_outlined,
              color: AppColors.grey73,
            ),
            label: LocalizationsUtils.localizations.home,
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.developer_board, color: Colors.blue),
            icon: Icon(
              Icons.developer_board,
              color: AppColors.grey73,
            ),
            label: "Dịch vụ",
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.account_circle, color: Colors.blue),
            icon: const Icon(Icons.account_circle_outlined,
                color: AppColors.grey73),
            label: LocalizationsUtils.localizations.me,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (indexPage) {
      case 0:
        return BlocProvider(
            create: (BuildContext context) => HomePageCubit(),
            child: const HomePageWidget());
      case 1:
        return const ServiceScreen();
      case 2:
        return BlocProvider(
          create: (context) => AccountCubit(),
          child: const AccountScreen(),
        );
      default:
        return Center(
            child: Text(
          LocalizationsUtils.localizations.home,
          style: AppTextStyle.textXl,
        ));
    }
  }
}
