class ChangeTextToSpeachModel {
  final String? publicUrl;
  final String? transcription;

  ChangeTextToSpeachModel({
     this.publicUrl,
    this.transcription = '',
  });
  factory ChangeTextToSpeachModel.fromJson(Map<String, dynamic> json) {
    return ChangeTextToSpeachModel(
      publicUrl: json['publicUrl'] ?? '',
      transcription: json['transcription'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'publicUrl': publicUrl,
      'transcription': transcription,
    };
  }
}
