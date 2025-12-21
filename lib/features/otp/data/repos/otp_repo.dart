import 'package:nara/core/helpers/dio_helper.dart';
import 'package:nara/core/networking/api_endpoints.dart';
import 'package:nara/core/networking/base_model.dart';
import 'package:nara/features/otp/data/models/otp_response_model.dart';

class OtpRepository {
  Future<BaseModel<OtpResponseModel>> verify(String email, String otp) async {
    try {
      return DioHelper().patchData(
        url: ApiEndpoints.verify,
        data: {"email": email, "otpCode": otp},
        mapper: (json) => OtpResponseModel.fromJson(json),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<BaseModel<void>> resend(String email) {
    try {
      return DioHelper().postData(
        url: ApiEndpoints.resend,
        body: {"email": email},
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
