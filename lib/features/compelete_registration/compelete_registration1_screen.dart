import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/widgets/custom_text_form_field.dart';
import 'package:nara/features/auth/logic/cubit/register_cubit.dart';
import 'package:nara/features/compelete_registration/widgets/complete_registration1_app_bar.dart';
import '../../core/widgets/custom_button.dart';

class CompeleteRegistration1Screen extends StatefulWidget {
  final RegisterCubit registerCubit;
  const CompeleteRegistration1Screen({super.key, required this.registerCubit});

  @override
  State<CompeleteRegistration1Screen> createState() =>
      _CompeleteRegistration1ScreenState();
}

class _CompeleteRegistration1ScreenState
    extends State<CompeleteRegistration1Screen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.registerCubit,
      child: Scaffold(
        appBar: const CompleteRegistration1AppBar(),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 25.h,
                    children: [
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        controller: context.read<RegisterCubit>().ageController,
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
                        controller: context
                            .read<RegisterCubit>()
                            .countryController,
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
                        controller: context
                            .read<RegisterCubit>()
                            .closeContactNumberController,
                        textHint: "ادخل الرقم",
                        headerTitle: "رقم شخص قريب منك",
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال رقم الهاتف';
                          }
                          final phoneRegExp = RegExp(r'^\+?[0-9]{11,15}$');
                          if (!phoneRegExp.hasMatch(value)) {
                            return 'الرجاء ادخال رقم هاتف صحيح';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 115.h,
                      ),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          return CustomButton(
                            title: "انشاء حساب",
                            isLoading: state is RegisterLoading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().register();
                              }

                              // context.read<RegisterCubit>().register();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




// GestureDetector(
//                       onTap: () {
//                         // Go.to(const VerifyScreen());
//                         context.read<RegisterCubit>().register();
//                       },
//                       child: Image.asset(AppAssets.imagesCompeleteIcon),
//                     )