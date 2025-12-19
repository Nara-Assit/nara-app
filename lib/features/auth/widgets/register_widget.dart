import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_button.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';
import 'package:nara/features/compelete_registration/compelete_registration_screen.dart';

import '../../../core/helpers/validators.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomTextFormField(
            textHint: "ادخل اسمك",
            headerTitle: "الاسم",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء ادخال الاسم';
              }
              return null;
            },
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "ادخل بريدك الالكترونى",
            headerTitle: "البريد الالكترونى",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validators.validateEmail(value),
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "انشى كلمة مرور",
            headerTitle: "كلمة المرور",
            controller: passController,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => Validators.validatePassword(value),
          ),
          SizedBox(height: 25.h),
          CustomTextFormField(
            textHint: "ادخل كلمة المرور",
            headerTitle: "تأكيد كلمة المرور",
            controller: confirmPassController,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => Validators.validatepasswordConfirmation(
              value,
              passController.text,
            ),
          ),
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
