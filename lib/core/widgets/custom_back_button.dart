import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/helpers/app_assets.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.imagesBackArrow,
      // width: 48.w,
      // height: 48.h,
      fit: BoxFit.contain,
    );
  }
}
