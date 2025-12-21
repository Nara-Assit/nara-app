import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/features/otp/logic/cubit/otp_cubit.dart';
import 'package:pinput/pinput.dart';

class EnterOtpWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const EnterOtpWidget({
    super.key,
    required this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            length: 6,
            disabledPinTheme: const PinTheme(
              constraints: BoxConstraints(minWidth: 50),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: ColorManager.secondColor,
                ),
              ],
            ),
            onChanged: (value) {
              context.read<OtpCubit>().otp = value;
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 5) {
                return 'الرجاء إدخال كود التحقق الصحيح';
              }
              return null;
            },
            defaultPinTheme: PinTheme(
              textStyle: const TextStyle(fontSize: 16),
              width: 56,
              height: 74,
              decoration: BoxDecoration(
                color: const Color(0xffF8F8FA),
                border: Border.all(color: ColorManager.primaryColor1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
