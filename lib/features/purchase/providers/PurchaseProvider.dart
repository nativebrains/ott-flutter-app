import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/purchase/models/ItemPlanModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../constants/constants.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../../account/models/LoginUserModel.dart';

class PurchaseProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;
  static get statusMessage => _statusMessage;
  List<ItemPlanModel> plansList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoginUserModel? get loginUserModel => SharedPrefs.getLoginUserData();

  static get isLoggedIn {
    return SharedPrefs.getBool(Constants.IS_LOGGED_ID);
  }

  Future<List<ItemPlanModel>> fetchPurchasePlans() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndpoints.PLAN_LIST_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0,
        }),
      );

      if (response.status == 200) {
        var dataList = response.data;
        plansList = dataList
            .map<ItemPlanModel>((item) => ItemPlanModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    _isLoading = false;
    notifyListeners();
    return plansList;
  }

  Future<bool> purchasePlan(
    int? planId,
    String paymentId,
    String paymentGateway,
    String couponCode,
    String couponPercentage,
  ) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.TRANSACTION_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0,
          'plan_id': planId,
          'payment_id': paymentId,
          'payment_gateway': paymentGateway,
          if (couponCode.isNotEmpty) 'coupon_code': couponCode,
          if (couponPercentage.isNotEmpty)
            'coupon_percentage': couponPercentage,
        }),
      );

      if (response.status == 200) {
        var dataList = response.data[0];
        isSuccess = true;
        _statusMessage = dataList[Constants.MSG];
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
