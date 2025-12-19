import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/splash/splash_screen.dart';
import 'core/navigation/app_navigation_observer.dart';

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
          title: 'Nara App',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Alexandria',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),

          navigatorObservers: [AppNavigationObserver()],
          home: const SplashScreen(),
        );
      },
    );
  }
}
