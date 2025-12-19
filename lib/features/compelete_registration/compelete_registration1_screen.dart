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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 25.h,
            children: [
              SizedBox(height: 10.h),
              CustomTextFormField(
                textHint: "ادخل اعمرك",
                headerTitle: "العمر",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال العمر';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'الرجاء ادخال عمر صحيح';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                textHint: "ادخل بلدك",
                headerTitle: "البلد",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال البلد';
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                textHint: "ادخل الرقم",
                headerTitle: "رقم شخص قريب منك",
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء ادخال رقم الهاتف';
                  }
                  final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'الرجاء ادخال رقم هاتف صحيح';
                  }
                  return null;
                },
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
      ),
    );
  }
}
