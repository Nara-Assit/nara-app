import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/sms_code/widgets/enter_otp_widget.dart';
import 'package:nara/features/verify/compeleted_screen.dart';
import '../../core/helpers/app_assets.dart';
import '../../core/theming/text_style_manager.dart';
import '../../core/widgets/custom_button.dart';

class SmsCodeScreen extends StatefulWidget {
  const SmsCodeScreen({super.key});

  @override
  State<SmsCodeScreen> createState() => _SmsCodeScreenState();
}

class _SmsCodeScreenState extends State<SmsCodeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
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
                    Text(
                      "أعد الارسال  ",
                      style: TextStyleManager.font14RegularBlack,
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                Center(
                  child: CustomButton(
                    title: "تأكيد",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Go.to(const CompeletedScreen());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
