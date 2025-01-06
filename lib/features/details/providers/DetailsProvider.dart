import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../../account/models/LoginUserModel.dart';
import '../models/GenericDetailsResponseModel.dart';

class DetailsProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;

  LoginUserModel? get loginUserModel => SharedPrefs.getLoginUserData();

  DetailsProvider() {}

  static String? get getStatusMessage {
    return _statusMessage;
  }

  static get isLoggedIn {
    return SharedPrefs.getBool(Constants.IS_LOGGED_ID);
  }

  Future<GenericDetailsResponseModel?> fetchMovieDetails(String movieId) async {
    GenericDetailsResponseModel? genericDetailsResponseModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.MOVIE_DETAILS_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0,
          'movie_id': movieId,
        }),
      );

      if (response.status == 200) {
        genericDetailsResponseModel =
            GenericDetailsResponseModel.fromMoviesJson(response.data);
        genericDetailsResponseModel.isPurchased = response.user_plan_status;
        print("All Good");
        print(genericDetailsResponseModel.item?.movieDescription);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return genericDetailsResponseModel;
  }
}
