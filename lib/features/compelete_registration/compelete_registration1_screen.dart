import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';
import 'package:nara/features/compelete_registration/widgets/complete_registration1_app_bar.dart';
import 'package:nara/features/verify/verify_screen.dart';

class CompeleteRegistration1Screen extends StatelessWidget {
  const CompeleteRegistration1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CompleteRegistration1AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0.w),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 25.h,
          children: [
            SizedBox(height: 10.h),
            CustomTextFormField(
              textHint: "ادخل اعمرك",
              icon: Image.asset(AppAssets.imagesTextfeildIcon),
              headerTitle: "العمر",
            ),
            CustomTextFormField(
              textHint: "ادخل بلدك",
              icon: Image.asset(AppAssets.imagesTextfeildIcon),
              headerTitle: "البلد",
            ),
            CustomTextFormField(
              textHint: "ادخل الرقم",
              icon: Image.asset(AppAssets.imagesTextfeildIcon),
              headerTitle: "رقم شخص قريب منك",
            ),
            SizedBox(
              height: 115.h,
            ),
            GestureDetector(
              onTap: () {
                Go.to(const VerifyScreen());
              },
              child: Image.asset(AppAssets.imagesCompeleteIcon),
            ),
          ],
        ),
      ),
    );
  }
}
