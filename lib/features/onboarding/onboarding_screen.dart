import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/features/onboarding/models/onboarding_model.dart';
import 'package:nara/features/sign_in_up/sign_in_up_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/navigation/navigator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (context, index) => OnBoardingItem(
                onboardingModel: OnboardingModel.onboardingPages[index],
              ),
              itemCount: OnboardingModel.onboardingPages.length,
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: OnboardingModel.onboardingPages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              spacing: 4.w,
              activeDotColor: ColorManager.primaryColor,
              dotColor: ColorManager.primaryColor200,
            ),
          ),
          SizedBox(height: 90.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Go.offAll(const SignInUpScreen());
                  },
                  child: Text(
                    "تخطي",
                    style: TextStyleManager.font20BoldPrimaryColor,
                  ),
                ),
                GestureDetector(
                  // onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoardingScreen()));},
                  child: Image.asset(AppAssets.imagesNextArrow),
                ),
              ],
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}

class OnBoardingItem extends StatelessWidget {
  final OnboardingModel onboardingModel;
  const OnBoardingItem({super.key, required this.onboardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        SizedBox(height: 210.h),
        Image.asset(onboardingModel.imagePath),
        SizedBox(height: 65.h),
        Text(onboardingModel.title, style: TextStyleManager.font20BoldBlack),
        SizedBox(height: 20.h),
        Text(
          textAlign: .center,
          onboardingModel.description,
          style: TextStyleManager.font14RegularBlack,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
