import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../application/utils/app_utils.dart';
import '../../application/utils/navigation_utils.dart';
import '../routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (_, child) => MaterialApp(
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
            child: MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            ),
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        title: "solar power",
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
