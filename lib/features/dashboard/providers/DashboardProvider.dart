import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';

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

  Future<dynamic> fetchDashboardData() async {
    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_URL,
        jsonEncode({'user_id': 0}),
      );

      if (response.status == 200) {
        print(response.data.toString());
      }
    } catch (e) {
      print("Error: $e");
    }

    notifyListeners(); // Notify UI of the state change
  }
}
