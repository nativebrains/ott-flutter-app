import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/settings/models/AboutAppModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';

class SettingsProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  Future<AboutAppModel?> getSettingsFromCache() async {
    final String? cachedDataString =
        await SharedPrefs.getCachedData(ApiEndpoints.APP_DETAIL_URL);
    if (cachedDataString != null) {
      final List<dynamic> data = jsonDecode(cachedDataString);
      return AboutAppModel.fromJson(data[0]);
    }
    return null;
  }

  Future<AboutAppModel?> fetchAboutData({bool refresh = false}) async {
    AboutAppModel? aboutAppModel;

    if (!refresh) {
      // Check if data is cached
      final String? cachedDataString =
          await SharedPrefs.getCachedData(ApiEndpoints.APP_DETAIL_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final List<dynamic> data = jsonDecode(cachedDataString);
        aboutAppModel = AboutAppModel.fromJson(data[0]);
        notifyListeners();
        return aboutAppModel;
      }
    }

    try {
      final response = await apiService.post(
        ApiEndpoints.APP_DETAIL_URL,
        jsonEncode({'user_id': ""}),
      );

      if (response.status == 200) {
        aboutAppModel = AboutAppModel.fromJson(response.data[0]);
        // Cache the fresh data
        await SharedPrefs.cacheData(
            jsonEncode(response.data), ApiEndpoints.APP_DETAIL_URL);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return aboutAppModel;
  }
}
