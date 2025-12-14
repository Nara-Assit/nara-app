import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';

class ChatTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool isTyping;
  const ChatTextFormField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.isTyping,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: isTyping ? 262.w : 216.w,
      margin: EdgeInsets.only(left: 23.w),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor1,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextFormField(
        minLines: 1,
        maxLines: 20,
        cursorColor: ColorManager.primaryColor,
        cursorHeight: 20,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          isDense: true,
          border: const OutlineInputBorder(borderSide: BorderSide.none),

          icon: const Icon(
            Icons.message,
            color: ColorManager.primaryColor,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
