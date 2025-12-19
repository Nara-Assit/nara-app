import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/color_manager.dart';
import '../theming/text_style_manager.dart';

Widget buildMesaage(String message) {
  return Align(
    alignment: AlignmentGeometry.centerRight,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),

      child: Text(
        message,
        style: TextStyleManager.font12RegularWhite.copyWith(fontSize: 14.sp),
      ),
    ),
  );
}
