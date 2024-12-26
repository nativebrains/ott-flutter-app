import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';

class AuthenticationProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  AuthenticationProvider() {}

  static String? get getStatusMessage {
    return _statusMessage;
  }

  Future<dynamic> login() async {
    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_URL,
        jsonEncode({'user_id': 1}),
      );

      if (response.status == 200) {
        print(response.data.toString());
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.receiveTimeout) {
        print("Receive timeout");
      } else if (e.type == DioErrorType.sendTimeout) {
        print("Send timeout");
      } else if (e.type == DioErrorType.cancel) {
        print("Request cancelled");
      } else {
        print("Error: ${e.message}");
      }
    } catch (e) {
      print("Error: $e");
    }

    notifyListeners(); // Notify UI of the state change
  }
}
