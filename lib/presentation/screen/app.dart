import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_energy/application/cubit/app_cubit.dart';
import 'package:solar_energy/application/utils/app_utils.dart';
import 'package:solar_energy/application/utils/navigation_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:solar_energy/presentation/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common_widgets/app_loading_indicator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (_, child) => MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
            scaffoldBackgroundColor: const Color(0xFFF3F6FB),
          ),
          debugShowCheckedModeBanner: false,
          navigatorObservers: [NavigatorUtils.navigatorObserver],
          navigatorKey: NavigatorUtils.navigatorKey,
          locale: const Locale('vi'),
          localeResolutionCallback: (locale, supportedLocales) =>
              const Locale("vi"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (BuildContext context, Widget? child) =>
              ResponsiveBreakpoints.builder(
            child: GestureDetector(
              onTap: () {
                AppUtils.dismissKeyboard();
              },
              child: Stack(
                children: [
                  MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.0)),
                    child: child ?? const SizedBox(),
                  ),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (BuildContext context, AppState state) {
                      return Visibility(
                        visible: state.isShowLoading,
                        child: Container(
                          width: 1.sw,
                          height: 1.sh,
                          color: Colors.black.withOpacity(0.5),
                          child: const AppLoadingIndicator(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
            ],
          ),
          title: "Kra Power",
          onGenerateRoute: AppRouter().onGenerateRoute,
        ),
      ),
    );
  }
}
