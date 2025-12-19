import 'package:dio/dio.dart';

String? savedToken;

class DioHelper {
  late Dio dio;
  DioHelper() {
    final BaseOptions baseOptions = BaseOptions(
      //    baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Accept": "application/json",
        'Authorization': "Bearer $savedToken",
      },
    );
    dio = Dio(baseOptions);
  }
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.delete(url, queryParameters: query);
  }
}
