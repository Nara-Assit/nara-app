class ChangeTextToSpeachModel {
  final String publicUrl;

  ChangeTextToSpeachModel({
    required this.publicUrl,
  });
  factory ChangeTextToSpeachModel.fromJson(Map<String, dynamic> json) {
    return ChangeTextToSpeachModel(
      publicUrl: json['publicUrl'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'publicUrl': publicUrl,
    };
  }
}
