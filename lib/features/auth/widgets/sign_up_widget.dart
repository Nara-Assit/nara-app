import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_button.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';
import 'package:nara/features/compelete_registration/compelete_registration_screen.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomTextFormField(
            textHint: "ادخل اسمك",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "الاسم",
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "ادخل بريدك الالكترونى",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "البريد الالكترونى",
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "انشى كلمة مرور",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "كلمة المرور",
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "ادخل كلمة المرور",
            icon: Image.asset(AppAssets.imagesTextfeildIcon),
            headerTitle: "تأكيد كلمة المرور",
          ),
          // SizedBox(height: 35.h),
          SizedBox(height: 35.h),
          CustomButton(
            title: "انشاء حساب",
            onTap: () {
              Go.to(CompeleteRegistrationScreen());
            },
          ),
          SizedBox(height: 30.h),
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
          SizedBox(height: 30.h),
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
