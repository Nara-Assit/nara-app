import 'package:dio/dio.dart';

String? savedToken;

class DioHelper {
  late Dio dio;
  DioHelper() {
    BaseOptions baseOptions = BaseOptions(
      //    baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {"Accept": "application/json"},
    );
    dio = Dio(baseOptions);
  }
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {'Authorization': "Bearer $savedToken"};
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {'Authorization': "Bearer $savedToken"};
    return await dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {'Authorization': "Bearer $savedToken"};
    return await dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {'Authorization': "Bearer $savedToken"};
    return await dio.delete(url, queryParameters: query);
  }
}
