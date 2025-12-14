import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/app_assets.dart';
import '../theming/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? pathAsset;
  const CustomAppBar({super.key, this.pathAsset});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 80,
      backgroundColor: ColorManager.whiteColors,
      actions: [
        Container(
          margin: EdgeInsets.only(left: 24.w),
          height: 48.h,
          width: 48.w,
          child: Image.asset(
            pathAsset ?? AppAssets.arrowBack,
            fit: BoxFit.cover,
          ),
        ),
      ],
      leading: Container(
        alignment: Alignment.center,
        height: 48.h,
        width: 48.w,
        margin: EdgeInsets.only(right: 24.w),
        decoration: BoxDecoration(
          color: ColorManager.darkYellowColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Badge(
          alignment: Alignment.topRight,

          backgroundColor: ColorManager.whiteColors,
          child: Icon(
            Icons.notifications,
            size: 24.w,
            color: ColorManager.whiteColors,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
