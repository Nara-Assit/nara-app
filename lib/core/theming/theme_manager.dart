import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nara/core/theming/text_style_manager.dart';
import 'package:nara/core/widgets/custom_back_button.dart';

import '../helpers/app_constatnts.dart';

class ThemeManager {
  ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppConstants.fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const CustomBackButton(),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: TextStyleManager.appBarTitle,
      toolbarHeight: 80.h,
      leadingWidth: 77.w,
      titleSpacing: 0,
      centerTitle: true,
    ),
    textTheme: GoogleFonts.alexandriaTextTheme(),
  );
}
