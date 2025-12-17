import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import 'package:solar_energy/presentation/screen/account_information/account_screen.dart';
import 'package:solar_energy/presentation/screen/home_page/bloc/home_page_cubit.dart';
import 'package:solar_energy/presentation/screen/home_page/home_page_widget.dart';
import 'package:solar_energy/presentation/screen/service_solar/bottom_contact_info.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late int indexPage;
  late List<bool> _tabLoaded;



  @override
  void initState() {
    super.initState();
    indexPage = (0);
    _tabLoaded = [true, false ,false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          if (index == 1) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (builder) {
                return const BottomContactInfo();
              },
            );
          } else {
            setState(() {
              indexPage = index;
              _tabLoaded[index] = true;
            });
          }
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
          NavigationDestination(
            selectedIcon: const Icon(Icons.developer_board, color: Colors.blue),
            icon: const Icon(
              Icons.developer_board,
              color: AppColors.grey73,
            ),
            label: LocalizationsUtils.localizations.service,
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
    return IndexedStack(index: indexPage, children: [
      _tabLoaded[0] ? BlocProvider(
          create: (BuildContext context) => HomePageCubit(),
          child: const HomePageWidget()) : const SizedBox(),
      const SizedBox(),
      _tabLoaded[2] ? BlocProvider(
        create: (context) => AccountCubit(),
        child: const AccountScreen(),
      ) : const SizedBox()
    ]);
  }
}
