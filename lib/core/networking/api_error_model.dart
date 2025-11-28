class ApiErrorModel {
  final String message;
  final int? statusCode;
  ApiErrorModel({required this.message, this.statusCode});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] ?? 'An unknown error occurred',
      statusCode: json['statusCode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'message': message, 'statusCode': statusCode};
  }
}
