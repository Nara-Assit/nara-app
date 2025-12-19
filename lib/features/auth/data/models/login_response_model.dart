import 'package:nara/core/models/user_model.dart';

class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;
  const LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
    );
  }

  @override
  String toString() =>
      '''LoginResponseModel(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)''';
}
