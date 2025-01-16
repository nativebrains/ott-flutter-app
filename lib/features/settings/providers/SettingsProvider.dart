import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/settings/models/AboutAppModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';

class SettingsProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  Future<AboutAppModel?> fetchAboutData() async {
    AboutAppModel? aboutAppModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.APP_DETAIL_URL,
        jsonEncode({'user_id': ""}),
      );

      if (response.status == 200) {
        aboutAppModel = AboutAppModel.fromJson(response.data[0]);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return aboutAppModel;
  }
}
