import 'package:flutter/material.dart';
import 'package:nara/features/auth/auth_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'named_routes.dart';
import 'page_router/imports_page_router_builder.dart';

class RouterGenerator {
  RouterGenerator._();

  static final PageRouterBuilder _pageRouter = PageRouterBuilder();

  static Route<dynamic> getRoute(RouteSettings settings) {
    try {
      final namedRoute = NamedRoutes.values.firstWhere(
        (e) => e.routeName == settings.name,
        orElse: () => NamedRoutes.splash,
      );
      return switch (namedRoute) {
        NamedRoutes.splash => _pageRouter.build(
          const SplashScreen(),
          settings: settings,
        ),
        NamedRoutes.onBoarding => _pageRouter.build(
          const OnBoardingScreen(),
          settings: settings,
        ),
        NamedRoutes.login => _pageRouter.build(
          const AuthScreen(),
          settings: settings,
        ),
      };
    } catch (e) {
      // Return undefined route if any error occurs
      return undefineRoute();
    }
  }

  static Route<dynamic> undefineRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('No route exists here ! '),
        ),
      ),
    );
  }
}
