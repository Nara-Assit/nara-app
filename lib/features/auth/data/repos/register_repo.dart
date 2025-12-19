import 'package:nara/core/helpers/dio_helper.dart';
import 'package:nara/core/networking/api_endpoints.dart';
import 'package:nara/core/networking/base_model.dart';
import 'package:nara/features/auth/data/models/login_response_model.dart';

class RegisterRepository {
  Future<BaseModel<LoginResponseModel>> register(
    String email,
    String password,
  ) async {
    try {
      return await DioHelper().postData(
        url: ApiEndpoints.register,
        mapper: (json) => LoginResponseModel.fromJson(json),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
