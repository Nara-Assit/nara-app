class ApiEndpoints {
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String verify = "auth/verify-user";
  static const String resend = "auth/resend-verification-otp";
  static const String refreshToken = "auth/refresh";
  

  static const String baseUrl = "https://nara-api-rj90.onrender.com/api/";
  static const String changeTexttoSpeach = "${baseUrl}ai/text-to-speech";
}
