import 'package:nara/core/helpers/dio_helper.dart';
import 'package:nara/core/models/user_model.dart';
import 'package:nara/core/networking/api_endpoints.dart';
import 'package:nara/core/networking/base_model.dart';
import 'package:nara/features/auth/data/models/register_request_model.dart';

class RegisterRepository {
  Future<BaseModel<UserModel>> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    try {
      return await DioHelper().postData(
        url: ApiEndpoints.register,
        body: registerRequestModel.toJson(),
        mapper: (json) => UserModel.fromJson(json['publicUser']),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
