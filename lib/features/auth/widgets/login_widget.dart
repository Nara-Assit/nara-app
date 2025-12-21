import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_button.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';

import '../../../core/helpers/validators.dart';
import '../logic/cubit/login_cubit.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                textHint: "ادخل بريدك الالكترونى",
                headerTitle: "البريد الالكترونى",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validators.validateEmail(value),
              ),
              SizedBox(height: 35.h),
              CustomTextFormField(
                textHint: "ادخل كلمة مرورك",
                headerTitle: "كلمة المرور",
                controller: passController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validators.validatePassword(value),
              ),
              SizedBox(height: 90.h),
              Builder(
                builder: (context) {
                  return BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        title: "تسجيل الدخول",
                        isLoading: state is LoginLoading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              emailController.text,
                              passController.text,
                            );
                          }
                        },
                      );
                    },
                  );
                },
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
        ),
      ),
    );
  }
}
