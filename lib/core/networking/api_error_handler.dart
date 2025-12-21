import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nara/core/helpers/sharedpref_helper.dart';
import 'package:nara/core/navigation/navigator.dart';
import 'package:nara/features/auth/auth_screen.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      final dioError = error;
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message: "انتهت مهلة الاتصال. من فضلك حاول مرة أخرى لاحقًا.",
            statusCode: 408,
          );

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message:
                "انتهت مهلة الإرسال. استغرقت العملية وقتًا أطول من المتوقع.",
            statusCode: 408,
          );

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "انتهت مهلة الاستقبال. الخادم لم يستجب في الوقت المحدد.",
            statusCode: 504,
          );

        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            message: "شهادة الأمان غير صالحة. يرجى التحقق من إعدادات الشبكة.",
            statusCode: 495,
          );

        case DioExceptionType.cancel:
          return ApiErrorModel(message: "تم إلغاء الطلب.", statusCode: 499);

        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "حدث خطأ في الاتصال. تأكد من اتصالك بالإنترنت.",
            statusCode: 0,
          );

        case DioExceptionType.badResponse:
          final response = dioError.response;
          if (response != null) {
            final statusCode = response.statusCode ?? 500;

            // 🔴 HANDLE UNAUTHORIZED HERE
            if (statusCode == 401 || statusCode == 403) {
              SharedprefHelper.clearAllSecuredData();
              Go.offAll(const AuthScreen());
              return ApiErrorModel(
                message: "انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.",
                statusCode: statusCode,
              );
            }

            String message = "حدث خطأ غير متوقع من الخادم.";
            // Handle typical validation error structure: { errors: [{ field, message }, ...] }
            if (response.data is Map) {
              final data = response.data as Map;
              if (data['errors'] != null && data['errors'] is List) {
                try {
                  final errors = List.from(data['errors'] as List);
                  final messages = errors
                      .map((e) {
                        if (e is Map && e['message'] != null) {
                          return e['message'].toString();
                        }
                        return e.toString();
                      })
                      .where((m) => m.isNotEmpty)
                      .toList();
                  if (messages.isNotEmpty) {
                    message = messages.join('\n');
                  }
                } catch (_) {
                  // fallback to generic message on parse errors
                }
              } else if (data['message'] != null) {
                message = _translateMessage(data['message'].toString());
              } else if (data['error'] != null) {
                message = _translateMessage(data['error'].toString());
              }
            } else if (response.data is String) {
              message = _translateMessage(response.data as String);
            }

            return ApiErrorModel(message: message, statusCode: statusCode);
          } else {
            return ApiErrorModel(
              message: "الخادم أرجع استجابة غير صالحة.",
              statusCode: 500,
            );
          }

        case DioExceptionType.unknown:
          return _handleUnknownError(dioError, stackTrace);
      }
    }
    return _handleUnknownError(error, stackTrace);
  }

  static ApiErrorModel _handleUnknownError(
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    final baseMessage = (error is Error || error is Exception)
        ? error.toString()
        : "حدث خطأ غير معروف. حاول مرة أخرى لاحقًا.";

    if (kDebugMode && stackTrace != null) {
      final messageWithTrace =
          '$baseMessage\n\nStackTrace:\n${stackTrace.toString()}';
      log(messageWithTrace, error: error);
      return ApiErrorModel(message: messageWithTrace, statusCode: 500);
    }

    return ApiErrorModel(message: baseMessage, statusCode: 500);
  }

  static String _translateMessage(String message) {
    final lower = message.toLowerCase();
    log("message $lower");
    if (lower.contains("expired otp")) {
      return "كود التحقق غير صالح يرجي اعادة الارسال";
    } else if (lower.contains("invalid") || lower.contains("wrong")) {
      return "البيانات غير صحيحة. يرجى التحقق من المدخلات.";
    } else if (lower.contains("unauthorized") ||
        lower.contains("forbidden") ||
        lower.contains("token")) {
      return "ليس لديك صلاحية للوصول إلى هذا المحتوى.";
    } else if (lower.contains("not found")) {
      return "العنصر المطلوب غير موجود.";
    } else if (lower.contains("timeout")) {
      return "انتهت المهلة أثناء الاتصال بالخادم.";
    } else if (lower.contains("server") || lower.contains("internal")) {
      return "حدث خطأ في الخادم. حاول لاحقًا.";
    } else if (lower.contains("network")) {
      return "تحقق من اتصالك بالإنترنت.";
    } else if (lower.contains("email")) {
      return "البريد الإلكتروني غير صحيح أو مستخدم بالفعل.";
    } else if (lower.contains("password")) {
      return "كلمة المرور غير صحيحة.";
    } else if (lower.contains("exists")) {
      return "العنصر موجود بالفعل.";
    } else if (lower.contains("limit")) {
      return "لقد وصلت إلى الحد الأقصى المسموح به.";
    }
    return message.length < 100 ? message : "حدث خطأ أثناء تنفيذ الطلب.";
  }
}
