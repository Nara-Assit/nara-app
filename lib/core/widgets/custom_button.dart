import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nara/core/theming/color_manager.dart';
import 'package:nara/core/theming/text_style_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color = ColorManager.primaryColor1,
    required this.title,
    this.textColor = ColorManager.secondColor,
    this.width,
    this.hight,
    this.image,
    this.radius,
    this.onTap,
    this.isLoading = false,
  });

  final Color color;
  final String title;
  final Color textColor;
  final double? width;
  final double? hight;
  final String? image;
  final double? radius;
  final bool isLoading;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: hight ?? 55.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 16.r),
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (image != null) ...[
                    Image.asset(
                      image!,
                      fit: BoxFit.cover,
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 10.w),
                  ],
                  Text(
                    title,
                    style: TextStyleManager.font16MediumBlack.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
