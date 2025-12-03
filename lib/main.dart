import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/onboarding/onboarding_screen.dart';
import 'package:nara/features/splash/splash_screen.dart';

import 'core/navigation/app_navigation_observer.dart';
import 'core/theming/theme_manager.dart';

void main() {
  runApp(const NaraApp());
}

class NaraApp extends StatelessWidget {
  const NaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Go.navigatorKey,
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          title: 'Flutter Demo',
          theme: ThemeManager().lightTheme,
          navigatorObservers: [AppNavigationObserver()],
          home: const SplashScreen(),
        );
      },
    );
  }
}
