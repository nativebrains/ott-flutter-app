import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/API.dart';
import '../services/shared_preference.dart';

class ApiLoggerInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Log the API request path and body
    if (kDebugMode) {
      print(".");
      print("=");
      print("======================================================");
      print('API Request: ${options.method} ${options.baseUrl}${options.path}');
      print('Request Headers: ${options.headers}');
      print('Request Query Parameters: ${options.queryParameters}');
      if (options.data is FormData) {
        final formData = options.data as FormData;
        // Log the FormData fields
        print('FormData Fields:');
        formData.fields.forEach((field) {
          try {
            print('${field.key}: ${API.fromBase64(field.value)}');
          } catch (e) {
            print('${field.key}: ${field.value}');
          }
        });

        // Log the FormData files (just file names to keep it simple)
        if (formData.files.isNotEmpty) {
          print('FormData Files:');
          formData.files.forEach((fileEntry) {
            print('${fileEntry.key}: ${fileEntry.value.filename}');
          });
        }
      } else {
        print(
            'Request Encoded Data: ${options.data}'); // This should work for JSON or other data types
        print(
            'Request Decoded Data: ${API.fromBase64(options.data)}'); // This should work for JSON or other data types
      }
      print("======================================================");
      print(".");
      print("=");
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the API response data
    if (kDebugMode) {
      print(".");
      print("=");
      print("======================================================");
      print('API ResponseCpde: ${response.statusCode}');
      print('API Response: ${response.data}');
      print("======================================================");
      print(".");
      print("=");
    }
    handler.next(response);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    // Log the API error
    if (kDebugMode) {
      print(".");
      print("*");
      print("*************************************************************");
      print('API Error: $error');
      print('Error Response: ${error.response?.data}');
      print('Error Code: ${error.response?.statusCode}');
      print('Error Message: ${error.response?.statusMessage}');
      print("*************************************************************");
      print(".");
      print("*");
    }
    handler.next(error);
  }
}
