import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';

class DashboardProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;
  static MediaContentType? _selectedMixScreenContentType;

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

  Future<dynamic> fetchDashboardData({bool refresh = false}) async {
    dynamic dashboardData;

    if (!refresh) {
      final String? cachedDataString =
          await SharedPrefs.getCachedData(ApiEndpoints.HOME_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final Map<String, dynamic> data = json.decode(cachedDataString);
        return data;
      }
    }

    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_URL,
        jsonEncode({'user_id': 0}),
      );

      if (response.status == 200) {
        dashboardData = response.data;
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
