import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/constants/app_color.dart';
import 'package:solar_energy/presentation/screen/account_information/Bloc/account_cubit.dart';
import 'package:solar_energy/presentation/screen/home_page/bloc/home_page_cubit.dart';
import '../../../application/enums/load_status.dart';
import '../account_information/account_screen.dart';
import '../device/bloc/device_cubit.dart';
import '../general_device/create_project/create_project_screen.dart';
import '../general_device/general_device_screen.dart';
import '../market/bloc/market_cubit.dart';
import '../market/market_screen.dart';

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
    _tabLoaded = [true, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyFB,

      body: _buildBody(),


      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ================= BODY =================

  Widget _buildBody() {
    return IndexedStack(
      index: indexPage,
      children: [

        /// TAB 0 - TRANG CHỦ
        _tabLoaded[0]
            ? BlocProvider(
          create: (_) => HomePageCubit()..getProjects(),
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {

              if (state.resultProjects.status == LoadStatus.success &&
                  state.resultProjects.data != null &&
                  state.resultProjects.data!.isNotEmpty) {

                final projects = state.resultProjects.data!;
                print("========== STATIONS ==========");
                for (var s in projects) {
                  print(
                    "ID=${s.id} | PROJECT=${s.projectId} | NAME=${s.name}",
                  );
                }
                print("==============================");
                final project = projects.firstWhere(
                      (e) => e.id == 181,
                  orElse: () => projects.first,
                );

                return BlocProvider(
                  create: (_) => DeviceCubit()

                    ..getAllDevices(
                      powerStationId: project.id!,
                    ),
                  child: GeneralDeviceScreen(
                    project: project,
                  ),
                );
              }
              if (state.resultProjects.status == LoadStatus.failure) {
                return Center(
                  child: Text(
                    state.resultProjects.error,
                  ),
                );
              }
              if (state.resultProjects.status == LoadStatus.empty) {
                return const CreateProjectScreen(
                  projectId: 0,
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
        )

        )
            : const SizedBox(),

        /// TAB 1 - THIẾT BỊ
        _tabLoaded[1]
        ? BlocProvider(
        create: (_) => MarketCubit(),
    child: const MarketScreen(),
    )
        : const SizedBox(),

        /// TAB 4 ACCOUNT
        BlocProvider(
          create: (_) => AccountCubit(),
          child: const AccountScreen(),
        ),
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
        setState(() {
          indexPage = index;
          _tabLoaded[index] = true;
        });
      },

      destinations: const [

        /// HOME
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.blue),
          icon: Icon(Icons.home_outlined, color: AppColors.grey73),
          label: "Trang chủ",
        ),

        /// DEVICE
        NavigationDestination(
          selectedIcon: Icon(Icons.grid_view, color: Colors.blue),
          icon: Icon(Icons.grid_view_outlined, color: AppColors.grey73),
          label: "Cửa Hàng",
        ),



        /// ACCOUNT (TAB CUỐI)
        NavigationDestination(
          selectedIcon: Icon(Icons.person, color: Colors.blue),
          icon: Icon(Icons.person_outline, color: AppColors.grey73),
          label: "Tài khoản",
        ),
      ],
    );
  }
}