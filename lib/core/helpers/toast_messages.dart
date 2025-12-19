import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nara/core/theming/color_manager.dart';

class ToastMessages {
  static void showSimpleToast({
    required String msg,
    Color? color,
    Color? textColor,
    MessageType type = MessageType.success,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: switch (type) {
        MessageType.success => ColorManager.greenColor,
        MessageType.error => ColorManager.redColor,
        MessageType.warning => ColorManager.orangeColor,
        MessageType.info => ColorManager.primaryColor200,
      },
      textColor: textColor ?? Colors.white,
      fontSize: 16.sp,
    );
  }
}

enum MessageType {
  success,
  error,
  warning,
  info,
}
