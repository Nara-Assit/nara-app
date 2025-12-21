import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/theme_manager.dart';
import 'package:nara/features/sign_in_up/sign_in_up_screen.dart';
import 'package:nara/features/splash/splash_screen.dart';
import 'core/get_it.dart' as di;
import 'core/helpers/sharedpref_helper.dart';
import 'core/navigation/app_navigation_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedprefHelper.cacheInitialization();
  await di.init();
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
          theme: ThemeManager().lightTheme,

          navigatorObservers: [AppNavigationObserver()],
          home: const SplashScreen(),
        );
      },
    );
  }
}
