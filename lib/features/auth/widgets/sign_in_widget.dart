import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_button.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomTextFormField(
            textHint: "ادخل بريدك الالكترونى",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "البريد الالكترونى",
          ),
          SizedBox(height: 35.h),
          CustomTextFormField(
            textHint: "ادخل كلمة مرورك",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "كلمة المرور",
          ),
          SizedBox(height: 90.h),
          const CustomButton(
            title: "تسجيل الدخول",
          ),
          SizedBox(height: 75.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5.w,
            children: [
              const Expanded(
                child: Divider(
                  thickness: 3,
                  color: ColorManager.primaryColor,
                ),
              ),
              Text(
                "أو من خلال",
                style: TextStyleManager.font16MediumBlack,
              ),
              const Expanded(
                child: Divider(
                  thickness: 3,
                  color: ColorManager.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 75.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                title: "جوجل",
                image: AppAssets.imagesGoogle,
                width: 112.w,
                radius: 25.r,
              ),
              CustomButton(
                color: ColorManager.primaryColor,
                title: "فيسبوك",
                textColor: Colors.white,
                image: AppAssets.imagesFacebook,
                width: 142.w,
                radius: 25.r,
              ),
            ],
          ),
          SizedBox(
            height: 95.h,
          ),
        ],
      ),
    );
  }
}
