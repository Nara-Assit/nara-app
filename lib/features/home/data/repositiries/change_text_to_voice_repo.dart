import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:nara/core/helpers/dio_helper.dart';
import 'package:nara/core/networking/api_endpoints.dart';
import 'package:nara/features/home/data/models/change_text_to_voice_model.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class ChangeTextToVoiceRepo {
  ChangeTextToVoiceRepo();
  Future<RepoResult<ChangeTextToSpeachModel>> changeTextToVoice(
    String text,
  ) async {
    try {
      final response = await DioHelper().postData(
        url: ApiEndpoints.changeTexttoSpeach,
        body: {
          "text": text,
        },
        mapper: (json) => ChangeTextToSpeachModel.fromJson(json),
      );
      log("Data: $response");
      return Right(response.data!);
    } catch (e) {
      log("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
