import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/validators.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/otp/otp_screen.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class VerifyViaEmailScreen extends StatelessWidget {
  const VerifyViaEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: .infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.asset(AppAssets.imagesVerifyAvatar),
                SizedBox(height: 25.h),
                Text(
                  textAlign: .center,
                  "ادخل بريدك الالكترونى للتحقق\n من هويتك",
                  style: TextStyleManager.font20BoldBlack,
                ),
                SizedBox(height: 72.h),
                CustomTextFormField(
                  textHint: "ادخل بريدك الالكترونى",
                  headerTitle: "البريد الالكترونى",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validators.validateEmail(value),
                ),
                SizedBox(height: 72.h),
                CustomButton(
                  title: "ارسال الكود",
                  onTap: () {
                    Go.to(const OtpScreen());
                  },
                ),
                SizedBox(height: 47.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
