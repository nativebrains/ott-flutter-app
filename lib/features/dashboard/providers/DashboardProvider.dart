import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../models/HomeDataModel.dart';

class DashboardProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;
  static MediaContentType? _selectedMixScreenContentType;
  HomeDataModel? dashboardData;

  static get selectedMixScreenContentType {
    return _selectedMixScreenContentType;
  }

  static get selectedMixScreenContentTypeName {
    return _selectedMixScreenContentType?.displayName;
  }

  void setSelectedMixScreenContentType(MediaContentType contentType) {
    _selectedMixScreenContentType = contentType;
    notifyListeners();
  }

  Future<HomeDataModel?> fetchDashboardData({bool refresh = false}) async {
    if (!refresh) {
      final String? cachedDataString =
          await SharedPrefs.getCachedData(ApiEndpoints.HOME_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final Map<String, dynamic> data = json.decode(cachedDataString);
        dashboardData = HomeDataModel.fromJson(data);
        notifyListeners();
        return dashboardData;
      }
    }

    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_URL,
        jsonEncode({'user_id': 0}),
      );

      if (response.status == 200) {
        dashboardData = HomeDataModel.fromJson(response.data);
        // Cache the fresh data
        await SharedPrefs.cacheData(
            json.encode(response.data), ApiEndpoints.HOME_URL);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }
    notifyListeners();
    return dashboardData;
  }
}
