import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nara/core/theming/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.textHint,
    this.icon,
    this.headerTitle,
    this.suffixIcon,
    this.hintColor,
    this.contentPadding,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.enabled = true,
  });

  final String textHint;
  final Widget? icon;
  final String? headerTitle;
  final Icon? suffixIcon;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerTitle != null) ...[
          Text(
            headerTitle!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
        ],
        TextFormField(
          enabled: enabled,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onTap: onTap,
          onChanged: onChanged,
          cursorColor: ColorManager.primaryColor,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
            hintText: textHint,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
            hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: hintColor ?? ColorManager.primaryColor,
            ),
            prefixIcon: icon,
            // prefixIconColor: MyColors.myGray4,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: ColorManager.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: ColorManager.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
