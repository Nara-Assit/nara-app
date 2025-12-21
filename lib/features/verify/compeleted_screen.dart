import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/otp/otp_screen.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';

class CompeletedScreen extends StatelessWidget {
  const CompeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: .infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: 158.h),
              Image.asset(AppAssets.imagesCompeleteAvatar),
              SizedBox(height: 85.h),
              Text(
                textAlign: .center,
                "تم انشاء الحساب لنبدأ رحتلنا\n معاً!!",
                style: TextStyleManager.font20BoldBlack,
              ),

              SizedBox(height: 95.h),
              CustomButton(
                title: "بدأ",
                onTap: () {
                  Go.to(const OtpScreen());
                },
              ),
              SizedBox(height: 47.h),
            ],
          ),
        ),
      ),
    );
  }
}
