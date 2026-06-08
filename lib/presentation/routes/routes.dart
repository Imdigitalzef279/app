import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_energy/application/enums/index_type.dart';
import 'package:solar_energy/data/dto/device/response/device_response.dart';
import 'package:solar_energy/domain/arguments/electric_meter/electric_meter_argument.dart';
import 'package:solar_energy/presentation/routes/route_name.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/automat_list_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/automat_detail_screen.dart';
import 'package:solar_energy/presentation/screen/Electricity/automat/bloc/atomat_detail_cubit.dart';
import 'package:solar_energy/presentation/screen/Home/home.dart';
import 'package:solar_energy/presentation/screen/alarm_water/all_alarm_water_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device/detail_device_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device_water/detail_device_water_screen.dart';
import 'package:solar_energy/presentation/screen/detail_factory/detail_factory.dart';
import 'package:solar_energy/presentation/screen/device/bloc/device_cubit.dart';
import 'package:solar_energy/presentation/screen/device_index/device_index_screen.dart';
import 'package:solar_energy/presentation/screen/general_device/general_device_screen.dart';
import 'package:solar_energy/presentation/screen/detail_device_water/widget/index_warning_screen.dart';
import 'package:solar_energy/presentation/screen/login/bloc/login_cubit.dart';
import 'package:solar_energy/presentation/screen/login/login_screen.dart';
import 'package:solar_energy/presentation/screen/manager_water/bloc/manager_water_cubit.dart';
import 'package:solar_energy/presentation/screen/manager_water/manager_water_screen.dart';
import 'package:solar_energy/presentation/screen/overview/bloc/overview_cubit.dart';
import 'package:solar_energy/presentation/screen/register/Bloc/register_cubit.dart';
import 'package:solar_energy/presentation/screen/register/register_widget.dart';

import '../../data/dto/power_station/response/power_station_response.dart';
import '../screen/general_device/add_product_screen.dart';
import '../screen/market/market_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    Widget routeWidget = BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginScreen(),
    );

    switch (routeSettings.name) {
      /// ================= HOME =================
      case RouteName.homeScreen:
        routeWidget = const HomeWidget();
        break;

      /// ================= APTOMAT LIST =================
      case RouteName.aptomatScreen:
        if (arguments == null || arguments is! Map<String, dynamic>) {
          routeWidget = const Scaffold(
            body: Center(child: Text("Thiếu arguments cho Aptomat")),
          );
          break;
        }

        final args = arguments;
        final powerStationId = args['powerStationId'];

        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AtomatDetailCubit()),
            BlocProvider(create: (_) => DeviceCubit()),
          ],
          child: AutomatListScreen(
            powerStationId: powerStationId,
          ),
        );

        break;
    /// ================= Thêm sản phẩm =================
      case RouteName.addProduct:
        final powerStationId = arguments as int;

        return MaterialPageRoute(
          builder: (_) => AddProductScreen(
            powerStationId: powerStationId,
          ),
        );
      /// ================= APTOMAT DETAIL =================
      case RouteName.automatDetail:
        if (arguments == null || arguments is! DeviceResponse) {
          routeWidget = const Scaffold(
            body: Center(child: Text("Thiếu device để mở detail")),
          );
          break;
        }

        routeWidget = BlocProvider(
            create: (context) => AtomatDetailCubit(),
            child: AutomatDetailScreen(
              device: arguments,
            ));
        break;

      /// ================= LOGIN =================
      case RouteName.loginScreen:
        routeWidget = BlocProvider(
          create: (_) => LoginCubit(),
          child: const LoginScreen(),
        );
        break;

      /// ================= ALARM WATER =================
      case RouteName.allAlarmWater:
        routeWidget = const AllAlarmWaterScreen();
        break;

      /// ================= INDEX WARNING =================
      case RouteName.indexWarning:
        routeWidget = IndexWarningScreen(
          indexType: arguments as IndexType,
        );
        break;

      /// ================= DETAIL DEVICE WATER =================
      case RouteName.detailDeviceWater:
        routeWidget = const DetailDeviceWaterScreen();
        break;

      /// ================= REGISTER =================
      case RouteName.registerWidget:
        routeWidget = BlocProvider(
          create: (_) => RegisterCubit(),
          child: const RegisterWidget(),
        );
        break;

      /// ================= FACTORY DETAIL =================
      case RouteName.factoryDetail:
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => OverviewCubit()),
            BlocProvider(create: (_) => DeviceCubit()),
          ],
          child: DetailFactoryScreen(
            type: arguments as ElectricMeterArgument,
          ),
        );
        break;

      /// ================= DEVICE INDEX =================
      case RouteName.deviceIndex:
        routeWidget = BlocProvider(
          create: (_) => ManagerWaterCubit(),
          child: const DeviceIndexScreen(),
        );
        break;

      /// ================= MANAGER WATER =================
      case RouteName.managerWater:
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ManagerWaterCubit()),
            BlocProvider(create: (_) => DeviceCubit()),
          ],
          child: ManagerWaterScreen(
            station: arguments as PowerStationResponse,
          ),
        );
        break;

      /// ================= GENERAL DEVICE =================
      case RouteName.generalDevice:
        routeWidget = GeneralDeviceScreen(
          project: arguments as PowerStationResponse,
        );
        break;

      /// ================= DETAIL DEVICE =================
      case RouteName.detailDevice:
        routeWidget = DetailDeviceScreen(
          device: arguments as DeviceResponse,
        );
        break;
      case RouteName.market:
        return MaterialPageRoute(
          builder: (_) => const MarketScreen(),
        );
      default:
        break;
    }

    return MaterialPageRoute(
      builder: (_) => routeWidget,
      settings: routeSettings,
    );
  }
}
