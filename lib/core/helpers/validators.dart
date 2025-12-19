import 'dart:developer';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء ادخال البريد الالكترونى';
    }
    final emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{3,4}$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'الرجاء ادخال بريد الكترونى صحيح';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء ادخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب ان تكون اكثر من 6 احرف';
    }
    return null;
  }

  static String? validatepasswordConfirmation(
    String? value,
    String pasController,
  ) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور';
    }
    if (value != pasController) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }
}
