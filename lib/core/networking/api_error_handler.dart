import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
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
          final response = error.response;
          if (response != null) {
            final statusCode = response.statusCode ?? 500;

            String message = "حدث خطأ غير متوقع من الخادم.";
            if (response.data is Map && response.data['message'] != null) {
              message = _translateMessage(response.data['message']);
            } else if (response.data is String) {
              message = _translateMessage(response.data);
            }

            return ApiErrorModel(message: message, statusCode: statusCode);
          } else {
            return ApiErrorModel(
              message: "الخادم أرجع استجابة غير صالحة.",
              statusCode: 500,
            );
          }

        case DioExceptionType.unknown:
        default:
          return _handleUnknownError(error);
      }
    } else {
      return ApiErrorModel(message: "حدث خطأ غير متوقع.", statusCode: 500);
    }
  }

  static ApiErrorModel _handleUnknownError(dynamic error) {
    if (error is Error) {
      return ApiErrorModel(message: error.toString(), statusCode: 500);
    }
    return ApiErrorModel(
      message: "حدث خطأ غير معروف. حاول مرة أخرى لاحقًا.",
      statusCode: 500,
    );
  }

  static String _translateMessage(String message) {
    final lower = message.toLowerCase();

    if (lower.contains("invalid") || lower.contains("wrong")) {
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
