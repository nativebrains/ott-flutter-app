import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants/ApiEndpoints.dart';
import '../../constants/routes_names.dart';
import '../../main.dart';
import '../models/ApiResponseModel.dart';
import 'shared_preference.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = dotenv.env['SERVER_API_URL']?.toString() ?? '';
    _dio.options.followRedirects = true;
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors
      // ..add(DataCleaningInterceptor())
      ..add(InterceptorsWrapper(
        onRequest: (options, handler) {
          // Determine the Content-Type based on the request data
          if (options.data is FormData) {
            // If the data is multipart
            options.headers['Content-Type'] = 'multipart/form-data';
          } else if (options.data is Map) {
            // If the data is a map (JSON)
            options.headers['Content-Type'] = 'application/json';
          }
          // Set common headers
          options.headers['Accept'] = 'application/json';
          options.headers['Authorization'] = 'Bearer ';

          handler.next(options);
        },
        onResponse: (response, handler) async {
          // it works as when we get 403 we logout the user
          if (response.statusCode == 403) {
            await _logoutUser();
            // navigatorKey.currentState?.pushNamedAndRemoveUntil(
            //   RouteConstantName.authenticationScreen,
            //   (route) => false,
            // );
          } else {
            handler.next(response);
          }
        },
      ));
    // ..add(ApiLoggerInterceptor());
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

  Future<ApiResponseModel> post(String path, [dynamic data]) async {
    try {
      final response = await _dio.post(path, data: data ?? {});
      return ApiResponseModel.fromJson(
          response.data, response.statusCode); // Parse to ApiResponse
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }

  Future<ApiResponseModel> patch(String path, [dynamic data]) async {
    try {
      final response = await _dio.patch(path, data: data ?? {});
      return ApiResponseModel.fromJson(
          response.data, response.statusCode); // Parse to ApiResponse
    } catch (error) {
      throw Exception('Failed to patch data: $error');
    }
  }

  Future<ApiResponseModel> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return ApiResponseModel.fromJson(
          response.data, response.statusCode); // Parse to ApiResponse
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
