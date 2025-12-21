import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:nara/features/home/data/models/change_text_to_voice_model.dart';
import 'package:nara/features/home/data/webservice/change_text_to_voice_web_service.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class ChangeTextToVoiceRepo {
  final ChangeTextToVoiceWebService changeTextToVoiceWebService;
  ChangeTextToVoiceRepo(this.changeTextToVoiceWebService);
  Future<RepoResult<ChangeTextToSpeachModel>> changeTextToVoice(
    String text,
  ) async {
    try {
      final response = await changeTextToVoiceWebService.changeTextToVoice(
        text,
      );
      log("Data: $response");
      final voice = ChangeTextToSpeachModel.fromJson(response["data"]);
      log(voice.toString());
      return Right(voice);
    } catch (e) {
      log("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
