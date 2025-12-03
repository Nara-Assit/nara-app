import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/features/verify/verify_via_email_screen.dart';
import 'package:nara/features/verify/verify_via_number_screen.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/navigation/navigator.dart';
import '../../core/theming/color_manager.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: .infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              Image.asset(AppAssets.imagesSignInUpAvatar),
              SizedBox(height: 40.h),
              Text(
                "اختر طريقة التحقق من هويتك",
                style: TextStyleManager.font20BoldBlack,
              ),
              SizedBox(height: 120.h),
              CustomButton(
                title: "بواسطة البريد الالكترونى",
                onTap: () {
                  Go.to(
                    const VerifyViaEmailScreen(),
                  );
                },
              ),
              SizedBox(height: 47.h),
              CustomButton(
                title: "بواسطة رقم الهاتف",
                color: ColorManager.primaryColor,
                textColor: Colors.white,
                onTap: () {
                  Go.to(
                    const VerifyViaNumberScreen(),
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
