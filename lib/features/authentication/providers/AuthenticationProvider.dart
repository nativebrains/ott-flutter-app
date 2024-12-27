import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/account/models/LoginUserModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';

class AuthenticationProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  AuthenticationProvider() {}

  static String? get getStatusMessage {
    return _statusMessage;
  }

  Future<bool> login(bool rememberMe, String email, String password) async {
    bool isSuccess = false;
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String brand = androidInfo.brand;
      String model = androidInfo.model;

      final response = await apiService.post(
        ApiEndpoints.LOGIN_URL,
        jsonEncode({
          'email': email,
          'password': password,
          'brand': brand,
          'model': model,
          'platform': Platform.isAndroid ? "Android OS" : "Apple OS"
        }),
      );

      if (response.status == 200) {
        final jsonData = response.data;
        if (int.parse(jsonData[0]['success']) == 1) {
          isSuccess = true;
          LoginUserModel user = LoginUserModel.fromJson(jsonData[0]);
          _statusMessage = user.message;
          // Storing User Profile
          await SharedPrefs.storeLoginUserData(user);
          await SharedPrefs.setBool(Constants.IS_LOGGED_ID, true);
          await SharedPrefs.setString(Constants.LOGIN_TYPE, "normal");
          await SharedPrefs.setBool(Constants.REMEMBER_ME, rememberMe);
        } else {
          isSuccess = false;
          _statusMessage = jsonData[0]['msg'];
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    notifyListeners(); // Notify UI of the state change
    return isSuccess;
  }

  Future<bool> forgotPassword(String email) async {
    _statusMessage = "";
    bool isSuccess = false;
    try {
      final response = await apiService.post(
        ApiEndpoints.FORGOT_PASSWORD_URL,
        jsonEncode({
          'email': email,
        }),
      );

      if (response.status == 200) {
        final jsonData = response.data;
        if (int.parse(jsonData[0]['success']) == 1) {
          isSuccess = true;
          _statusMessage = jsonData[0]['msg'];
        } else {
          isSuccess = false;
          _statusMessage = jsonData[0]['msg'];
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    notifyListeners(); // Notify UI of the state change
    return isSuccess;
  }
}
