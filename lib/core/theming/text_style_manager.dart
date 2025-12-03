import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/app_constatnts.dart';
import 'color_manager.dart';

class TextStyleManager {
  TextStyleManager._();
  static TextStyle font24Thin = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w100,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Extralight = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w200,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Light = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w300,
    color: ColorManager.secondColor,
  );
  static TextStyle font20RegularGrey = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.greyColor,
  );
  static TextStyle font15RegularGrey = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 121, 119, 119),
  );
  static TextStyle font14Regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0XFF333333),
  );
  static TextStyle font20RegularBlack = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font14RegularBlack = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font15MeduimBlack = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.secondColor,
  );
  static TextStyle font20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font15Bold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );

  static TextStyle font24Bold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font20BoldWhite = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font16MediumBlack = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.secondColor,
  );
  static TextStyle font16BoldWhite = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font16BoldBlack = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font14BoldWhite = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.whiteColors,
  );
  static TextStyle font14RegularPrimaryColor = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.primaryColor,
  );
  static TextStyle font14SemiBoldWhite = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.whiteColors,
  );
  static TextStyle font20BoldBlack = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font20BoldPrimaryColor = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.primaryColor,
  );

  static TextStyle appBarTitle = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.primaryColor,
  );
}
