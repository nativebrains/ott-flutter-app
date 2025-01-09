import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../constants/constants.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../models/ItemDashboardModel.dart';
import '../models/LoginUserModel.dart';

class AccountProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ItemDashBoardModel? itemDashBoardModel;

  LoginUserModel? get loginUserModel => SharedPrefs.getLoginUserData();

  static get isLoggedIn {
    return SharedPrefs.getBool(Constants.IS_LOGGED_ID);
  }

  Future<bool> logout() async {
    bool isLogoutSuccess = false;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndpoints.LOGOUT_URL,
        jsonEncode({
          'user_id': loginUserModel?.userId ?? 0,
          'user_session_name': loginUserModel?.userSessionName ?? "",
        }),
      );

      if (response.status == 200) {
        // Cache the fresh data
        final objJson = response.data[0];

        if (int.parse(objJson['success']) == 1) {
          isLogoutSuccess = true;
          await SharedPrefs.clearLoginUserData();
          await SharedPrefs.setBool(Constants.IS_LOGGED_ID, false);
          await SharedPrefs.setBool(Constants.REMEMBER_ME, false);
        }
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchFilterData";
    }

    _isLoading = false;
    notifyListeners();
    return isLogoutSuccess;
  }

  Future<ItemDashBoardModel?> fetchDashboardAccountDetails(
      {bool refresh = false}) async {
    if (!refresh) {
      final String? cachedDataString =
          await SharedPrefs.getCachedData(ApiEndpoints.DASH_BOARD_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final List<dynamic> dataList = json.decode(cachedDataString);
        itemDashBoardModel = ItemDashBoardModel.fromJson(dataList[0]);
        notifyListeners();
        return itemDashBoardModel;
      }
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndpoints.DASH_BOARD_URL,
        jsonEncode({'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0}),
      );

      if (response.status == 200) {
        var dataList = response.data;
        // Cache the fresh data
        await SharedPrefs.cacheData(
            json.encode(dataList), ApiEndpoints.DASH_BOARD_URL);
        itemDashBoardModel = ItemDashBoardModel.fromJson(dataList[0]);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    _isLoading = false;
    notifyListeners();
    return itemDashBoardModel;
  }
}
