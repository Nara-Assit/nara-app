class BaseModel<T> {
  final T? data;
  final String message;
  final bool success;
  BaseModel({this.data, required this.message, required this.success});

  factory BaseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return BaseModel<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'] ?? "",
      success: json['success'] ?? false,
    );
  }

  @override
  String toString() =>
      '''BaseModel(data: $data, message: $message, success: $success)''';
}
