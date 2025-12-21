class ChangeTextToSpeachModel {
  final String text;
  final bool success;
  final String message;
  final String publicUrl;

  ChangeTextToSpeachModel({
    required this.text,
    required this.success,
    required this.message,
    required this.publicUrl,
  });
  factory ChangeTextToSpeachModel.fromJson(Map<String, dynamic> json) {
    return ChangeTextToSpeachModel(
      text: json['text'] ?? '',
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      publicUrl: json['publicUrl'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'success': success,
      'message': message,
      'publicUrl': publicUrl,
    };
  }
}
