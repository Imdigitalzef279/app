import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/application/constants/localizations.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import 'package:solar_energy/presentation/screen/account_information/account_screen.dart';
import 'package:solar_energy/presentation/screen/home_page/bloc/home_page_cubit.dart';
import 'package:solar_energy/presentation/screen/service_solar/bottom_contact_info.dart';


import '../../../application/enums/load_status.dart';
import '../general_device/general_device_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int indexPage = 0;
  late List<bool> _tabLoaded;

  @override
  void initState() {
    super.initState();
    _tabLoaded = [true, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,

      body: _buildBody(),


      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ================= FLOATING ADD DEVICE =================


  // ================= BODY =================

  Widget _buildBody() {
    return IndexedStack(
      index: indexPage,
      children: [
        // HOME – Nhà máy
        _tabLoaded[0]
            ? BlocProvider(
          create: (_) => HomePageCubit()..getProjects(),
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {

              if (state.resultProjects.status == LoadStatus.success &&
                  state.resultProjects.data != null &&
                  state.resultProjects.data!.isNotEmpty) {

                final projects = state.resultProjects.data!;

                final project = projects.firstWhere(
                      (e) => e.id == 181,
                  orElse: () => projects.first,
                );

                return GeneralDeviceScreen(project: project);
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
            : const SizedBox(),

        // ACCOUNT
        _tabLoaded[2]
            ? BlocProvider(
          create: (_) => AccountCubit(),
          child: const AccountScreen(),
        )
            : const SizedBox(),

        // MARKET (chưa làm)
        const SizedBox(),
      ],
    );
  }

  // ================= BOTTOM BAR =================

  Widget _buildBottomBar() {
    return NavigationBar(
      selectedIndex: indexPage,
      backgroundColor: Colors.white,
      indicatorColor: Colors.blue.withOpacity(0.2),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (index) {
        if (index == 1) {
          // 👉 TAB SERVICE → mở bottom sheet
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => const BottomContactInfo(),
          );
          return;
        }

        setState(() {
          indexPage = index;
          _tabLoaded[index] = true;
        });
      },
      destinations: [
        NavigationDestination(
          selectedIcon:
          const Icon(Icons.home_rounded, color: Colors.blue),
          icon: const Icon(Icons.home_outlined,
              color: AppColors.grey73),
          label: LocalizationsUtils.localizations.home,
        ),
        NavigationDestination(
          selectedIcon:
          const Icon(Icons.developer_board, color: Colors.blue),
          icon: const Icon(Icons.developer_board,
              color: AppColors.grey73),
          label: LocalizationsUtils.localizations.service,
        ),
        NavigationDestination(
          selectedIcon:
          const Icon(Icons.account_circle, color: Colors.blue),
          icon: const Icon(Icons.account_circle_outlined,
              color: AppColors.grey73),
          label: LocalizationsUtils.localizations.me,
        ),
        const NavigationDestination(
          selectedIcon:
          Icon(Icons.shopping_cart, color: Colors.blue),
          icon: Icon(Icons.shopping_cart_outlined,
              color: AppColors.grey73),
          label: 'Market',
        ),
      ],
    );
  }
}
