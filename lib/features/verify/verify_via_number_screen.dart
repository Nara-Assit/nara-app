import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/sms_code/sms_code_screen.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

class VerifyViaNumberScreen extends StatelessWidget {
  const VerifyViaNumberScreen({super.key});

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
              Image.asset(AppAssets.imagesVerifyAvatar),
              SizedBox(height: 25.h),
              Text(
                textAlign: .center,
                "ادخل رقمك للتحقق من هويتك",
                style: TextStyleManager.font20BoldBlack,
              ),
              SizedBox(height: 72.h),
              CustomTextFormField(
                textHint: "ادخل رقم هاتفك",
                icon: Image.asset(AppAssets.imagesTextfeildIcon),
                headerTitle: "رقم الهاتف",
              ),
              SizedBox(height: 72.h),
              CustomButton(
                title: "ارسال الكود",
                onTap: () {
                  Go.to(const SmsCodeScreen());
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
