import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_button.dart';
import 'package:nara/features/auth/auth_screen.dart';

class SignInUpScreen extends StatelessWidget {
  const SignInUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: .infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(height: 150.h),
              Image.asset(AppAssets.imagesSignInUpAvatar),
              SizedBox(height: 100.h),
              Text(
                textAlign: .center,
                "أهلا بيك! ابدأ تجربتك\n بسهولة",
                style: TextStyleManager.font20BoldBlack,
              ),
              SizedBox(height: 95.h),
              CustomButton(
                title: "تسجيل الدخول",
                onTap: () {
                  Go.to(const AuthScreen());
                },
              ),
              SizedBox(height: 16.h),
              CustomButton(
                title: "انشاء حساب",
                color: ColorManager.primaryColor,
                textColor: Colors.white,
                onTap: () {
                  Go.to(
                    const AuthScreen(index: 1),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
