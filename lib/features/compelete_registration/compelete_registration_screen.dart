import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/enum/role_enum.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/features/auth/logic/cubit/register_cubit.dart';
import 'package:nara/features/compelete_registration/compelete_registration1_screen.dart';

class CompeleteRegistrationScreen extends StatelessWidget {
  final RegisterCubit registerCubit;
  const CompeleteRegistrationScreen({super.key, required this.registerCubit});

  @override
  Widget build(BuildContext context) {
    final roles = RoleEnum.values;
    return BlocProvider.value(
      value: registerCubit,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    "من فضلك اختر الفئة لتكمل رحلتك,",
                    style: TextStyleManager.font16MediumBlack,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 50.0,
                            crossAxisSpacing: 21.0,
                          ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            registerCubit.role = roles[index].apiValue;
                            Go.to(
                              CompeleteRegistration1Screen(
                                registerCubit: registerCubit,
                              ),
                            );
                          },
                          child: Container(
                            width: 155.w,
                            height: 167.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              border: Border.all(
                                color: ColorManager.primaryColor,
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                roles[index].arabicName,
                                style: TextStyleManager.font20BoldBlack,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: roles.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
