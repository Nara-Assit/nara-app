import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nara/core/helpers/app_constatnts.dart';
import 'package:nara/core/networking/base_model.dart';
import 'package:nara/core/helpers/toast_messages.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../networking/api_error_handler.dart';

String? savedToken;

class DioHelper {
  late final Dio dio;

  DioHelper() {
    final baseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        "Accept-Language": 'ar',
      },
    );
    dio = Dio(baseOptions);

    if (kDebugMode) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printErrorHeaders: false,
          ),
        ),
      );
    }
  }

  void _applyAuthHeader([String? token]) {
    final t = token ?? savedToken;
    if (t != null && t.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $t';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }

  /// Generic GET
  Future<BaseModel<T>> getData<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    String? token,
    Options? options,
    T Function(dynamic json)? mapper,
  }) async {
    _applyAuthHeader(token);
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: options,
      );
      if (mapper != null) return BaseModel.fromJson(response.data, mapper);
      return BaseModel.fromJson(response.data, (json) => json as T);
    } catch (error, stackTrace) {
      final apiError = ApiErrorHandler.handle(error, stackTrace);
      throw apiError;
    }
  }

  /// Generic POST
  Future<BaseModel<T>> postData<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    dynamic body,
    Options? options,
    T Function(dynamic json)? mapper,
    final bool isFormData = false,
  }) async {
    _applyAuthHeader();
    try {
      final response = await dio.post(
        url,
        queryParameters: queryParams,
        data: body is Map<String, dynamic> && isFormData == true
            ? await _mapToFormData(body)
            : body,
        options: options,
      );
      if (mapper != null) return BaseModel.fromJson(response.data, mapper);
      return BaseModel.fromJson(response.data, (json) => json as T);
    } catch (error, stackTrace) {
      final apiError = ApiErrorHandler.handle(error, stackTrace);
      if (error is DioException) {
        ToastMessages.showSimpleToast(msg: apiError.message, type: .error);
      }
      throw apiError;
    }
  }

  /// Generic PUT
  Future<BaseModel<T>> putData<T>({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String? token,
    Options? options,
    T Function(dynamic json)? mapper,
  }) async {
    _applyAuthHeader(token);
    try {
      dynamic payload = data;
      if (data is FormData) {
        payload = data;
      } else if (data is Map<String, dynamic> && data['isFormData'] == true) {
        payload = await _mapToFormData(data);
      }

      final response = await dio.put(
        url,
        queryParameters: query,
        data: payload,
        options: options,
      );

      if (mapper != null) return BaseModel.fromJson(response.data, mapper);
      return BaseModel.fromJson(response.data, (json) => json as T);
    } catch (error, stackTrace) {
      final apiError = ApiErrorHandler.handle(error, stackTrace);
      throw apiError;
    }
  }

  Future<BaseModel<T>> deleteData<T>({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
    T Function(dynamic json)? mapper,
  }) async {
    _applyAuthHeader(token);
    try {
      final response = await dio.delete(
        url,
        queryParameters: query,
        options: options,
      );
      if (mapper != null) return BaseModel.fromJson(response.data, mapper);
      return BaseModel.fromJson(response.data, (json) => json as T);
    } catch (error, stackTrace) {
      final apiError = ApiErrorHandler.handle(error, stackTrace);
      throw apiError;
    }
  }

  Future<FormData> _mapToFormData(Map<String, dynamic> data) async {
    final formData = FormData();

    // copy entries except the control key
    final entries = Map.of(data);
    entries.remove('isFormData');

    for (final entry in entries.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value == null) continue;

      // Helper to add a file
      Future<void> addFileFromPath(String path) async {
        final file = File(path);
        if (!file.existsSync()) return;
        final filename = file.uri.pathSegments.isNotEmpty
            ? file.uri.pathSegments.last
            : 'file';
        final multipart = await MultipartFile.fromFile(
          path,
          filename: filename,
        );
        formData.files.add(MapEntry(key, multipart));
      }

      if (value is MultipartFile) {
        formData.files.add(MapEntry(key, value));
      } else if (value is File) {
        final multipart = await MultipartFile.fromFile(
          value.path,
          filename: value.uri.pathSegments.isNotEmpty
              ? value.uri.pathSegments.last
              : 'file',
        );
        formData.files.add(MapEntry(key, multipart));
      } else if (value is String) {
        // if the string points to an existing file, treat as file
        final file = File(value);
        if (file.existsSync()) {
          await addFileFromPath(value);
        } else {
          formData.fields.add(MapEntry(key, value));
        }
      } else if (value is Iterable) {
        for (final item in value) {
          if (item == null) continue;
          if (item is MultipartFile) {
            formData.files.add(MapEntry(key, item));
          } else if (item is File) {
            final multipart = await MultipartFile.fromFile(
              item.path,
              filename: item.uri.pathSegments.isNotEmpty
                  ? item.uri.pathSegments.last
                  : 'file',
            );
            formData.files.add(MapEntry(key, multipart));
          } else if (item is String) {
            final file = File(item);
            if (file.existsSync()) {
              await addFileFromPath(item);
            } else {
              formData.fields.add(MapEntry(key, item.toString()));
            }
          } else {
            formData.fields.add(MapEntry(key, item.toString()));
          }
        }
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    }

    return formData;
  }
}
