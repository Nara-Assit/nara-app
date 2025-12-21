import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/features/otp/logic/cubit/otp_cubit.dart';
import 'package:nara/features/otp/widgets/enter_otp_widget.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  final bool isLoginScreen;
  const OtpScreen({super.key, this.email, this.isLoginScreen = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // if (widget.isLoginScreen) {
        //   return OtpCubit()..resend(widget.email!);
        // } else {
        return OtpCubit();
        // }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (context) {
            return SizedBox(
              width: .infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(AppAssets.imagesSmsCodeAvatar),
                      SizedBox(height: 20.h),
                      Text(
                        "كود التحقق",
                        style: TextStyleManager.font20BoldBlack,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        textAlign: .center,
                        "تم إرسال كود تحقق إلى بريدك الالكترونى.\n ادخل الكود للمتابعة",
                        style: TextStyleManager.font14RegularPrimaryColor,
                      ),
                      SizedBox(height: 35.h),
                      EnterOtpWidget(
                        formKey: _formKey,
                      ),
                      const SizedBox(height: 34),
                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            "لم تستلم الكود؟",
                            style: TextStyleManager.font14RegularPrimaryColor,
                          ),
                          SizedBox(width: 4.w),
                          GestureDetector(
                            onTap: () {
                              context.read<OtpCubit>().resend(widget.email!);
                            },
                            child: Text(
                              "أعد الارسال  ",
                              style: TextStyleManager.font14RegularBlack,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                      Center(
                        child: CustomButton(
                          title: "تأكيد",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<OtpCubit>().verify(widget.email!);
                            }
                          },
                        ),
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
