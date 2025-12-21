import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/features/onboarding/models/onboarding_model.dart';
import 'package:nara/features/onboarding/widgets/on_boarding_item.dart';
import 'package:nara/features/sign_in_up/sign_in_up_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/helpers/sharedpref_helper.dart';
import '../../core/helpers/storage_constants.dart';
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
                    SharedprefHelper.setBoolData(
                      StorageConstants.onBoarding,
                      true,
                    );
                    Go.offAll(const SignInUpScreen());
                  },
                  child: Text(
                    "تخطي",
                    style: TextStyleManager.font20BoldPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_controller.page ==
                        OnboardingModel.onboardingPages.length - 1) {
                      SharedprefHelper.setBoolData(
                        StorageConstants.onBoarding,
                        true,
                      );
                      Go.offAll(const SignInUpScreen());
                      return;
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
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
