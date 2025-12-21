
class OtpResponseModel {
  final String accessToken;
  final String refreshToken;
  const OtpResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() => '''OtpResponseModel(accessToken: $accessToken, refreshToken: $refreshToken)''';
}