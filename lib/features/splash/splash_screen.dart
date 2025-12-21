import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/helpers/sharedpref_helper.dart';
import 'package:nara/core/helpers/storage_constants.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/bottomnavbar/ui/bottom_nav_bar.dart';
import 'package:nara/features/onboarding/onboarding_screen.dart';
import 'package:nara/features/sign_in_up/sign_in_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      await navigation();
    });
  }

 Future<void> navigation() async {
  final hasOnBoarded =
      SharedprefHelper.getBoolData(StorageConstants.onBoarding) ?? false;

  if (!hasOnBoarded) {
    Go.to(const OnBoardingScreen());
    return;
  }

  final token =
      await SharedprefHelper.getSecurityString(StorageConstants.savedToken);

  Go.to(
    (token?.isNotEmpty ?? false)
        ? const BottomNavBarScreen()
        : const SignInUpScreen(),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: .infinity,
        child: Column(
          spacing: 30.h,
          mainAxisAlignment: .center,
          children: [
            Image.asset(AppAssets.imagesSplashLogo),
            // Image.asset(AppAssets.imagesNara),
          ],
        ),
      ),
    );
  }
}
