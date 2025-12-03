import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/features/onboarding/models/onboarding_model.dart';

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
