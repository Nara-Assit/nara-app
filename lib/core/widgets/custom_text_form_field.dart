import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nara/core/theming/color_manager.dart';

import '../helpers/app_assets.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.textHint,
    this.prefixIcon,
    this.headerTitle,
    this.suffixIcon,
    this.hintColor,
    this.contentPadding,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.enabled = true,
    this.isPassword = false,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  final String textHint;
  final Widget? prefixIcon;
  final String? headerTitle;
  final Icon? suffixIcon;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final bool enabled;
  final bool isPassword;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerTitle != null) ...[
          Text(
            widget.headerTitle!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscure : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          cursorColor: ColorManager.primaryColor,
          readOnly: widget.readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.textHint,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
            hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: widget.hintColor ?? ColorManager.primaryColor,
            ),
            prefixIcon:
                widget.prefixIcon ?? Image.asset(AppAssets.imagesTextfeildIcon),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: ColorManager.primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: ColorManager.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: ColorManager.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
