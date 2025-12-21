import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/helpers/dio_helper.dart';
import '../../../../core/networking/api_endpoints.dart';

class ChangeTextToVoiceWebService {
  DioHelper dioHelper = DioHelper();
  Future<dynamic> changeTextToVoice(
    String text,
  ) async {
    final Response response = await dioHelper.postData(
      url: ApiEndpoints.changeTexttoSpeach,
      data: {
        "text": text,
      },
    );
    log(response.statusCode.toString());
    return response.data;
  }
}
