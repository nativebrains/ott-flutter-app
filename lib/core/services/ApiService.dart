import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:islamforever/core/models/API.dart';

import '../../constants/ApiEndpoints.dart';
import '../../constants/routes_names.dart';
import '../../main.dart';
import '../interceptors/ApiLoggerInterceptor.dart';
import '../interceptors/DataCleaningInterceptor.dart';
import '../models/ApiResponseModel.dart';
import 'shared_preference.dart';

class ApiService {
  final Dio _dio = Dio();
  final API _api = API();

  ApiService() {
    _dio.options.baseUrl = dotenv.env['SERVER_API_URL']?.toString() ?? '';
    _dio.options.followRedirects = true;
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // Determine the Content-Type based on the request data
          if (options.data is FormData) {
            // If the data is multipart
            options.headers['Content-Type'] =
                'application/x-www-form-urlencoded';
          } else if (options.data is Map) {
            // If the data is a map (JSON)
            options.headers['Content-Type'] = 'application/json';
          }
          // Set common headers
          options.headers['Accept'] = 'application/json';
          handler.next(options);
        },
      ))
      ..add(ApiLoggerInterceptor());
  }

  Future<ApiResponseModel> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return ApiResponseModel.fromJson(
          response.data, response.statusCode); // Parse to ApiResponse
    } catch (error) {
      throw Exception('Failed to perform GET request: $error');
    }
  }

  Future<ApiResponseModel> post(String path, dynamic data,
      {int? page, File? user_image, bool isImage = false}) async {
    try {
      Map<String, dynamic> jsonData;
      // Handle different types of data
      if (data is Map<String, dynamic>) {
        jsonData = data;
      } else if (data is String) {
        jsonData = jsonDecode(data);
      } else {
        throw Exception('Invalid data type. Expected Map or JSON String.');
      }

      // Add sign and salt to jsonData
      jsonData['sign'] = _api.sign;
      jsonData['salt'] = _api.salt;

      // Base64 encode the jsonData
      String base64Data = API.toBase64(jsonEncode(jsonData));

      // Send the POST request
      final response = await _dio.post(
        path,
        data: FormData.fromMap({
          'data': base64Data,
          if (page != null) 'page': page,
          if (isImage && user_image != null)
            'user_image': user_image
          else
            'user_image': "",
        }),
      );

      return ApiResponseModel.fromJson(response.data, response.statusCode);
    } catch (error) {
      print("Error: $error");
      throw Exception('Failed to post data: $error');
    }
  }

  Future<ApiResponseModel> patch(String path, [dynamic data]) async {
    try {
      Map<String, dynamic> jsonData = data.toJson();
      jsonData['sign'] = _api.sign;
      jsonData['salt'] = _api.salt;

      String base64Data = API.toBase64(jsonEncode(jsonData));

      final response = await _dio.patch(
        path,
        data: {'data': base64Data},
      );

      return response.data;
    } catch (error) {
      throw Exception('Failed to patch data: $error');
    }
  }

  Future<ApiResponseModel> put(String path, dynamic data) async {
    try {
      Map<String, dynamic> jsonData = data.toJson();
      jsonData['sign'] = _api.sign;
      jsonData['salt'] = _api.salt;

      String base64Data = API.toBase64(jsonEncode(jsonData));

      final response = await _dio.put(
        path,
        data: {'data': base64Data},
      );

      return response.data;
    } catch (error) {
      throw Exception('Failed to perform PUT request: $error');
    }
  }

  Future<ApiResponseModel> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return ApiResponseModel.fromJson(
          response.data, response.statusCode); // Parse to ApiResponse
    } catch (error) {
      throw Exception('Failed to perform DELETE request: $error');
    }
  }

  Future<void> _logoutUser() async {
    try {
      await SharedPrefs.clear();
    } catch (e) {}
  }
}
