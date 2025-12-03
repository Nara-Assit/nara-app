import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/features/compelete_registration/compelete_registration1_screen.dart';

class CompeleteRegistrationScreen extends StatelessWidget {
  CompeleteRegistrationScreen({super.key});
  final List<String> categories = [
    'طبيب',
    'أخصائى',
    'ولى أمر',
    'أصم',
    'أبكم',
    'زراعة قوقعة',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 50.0,
                  crossAxisSpacing: 21.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Go.to(const CompeleteRegistration1Screen());
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
                          categories[index],
                          style: TextStyleManager.font20BoldBlack,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
