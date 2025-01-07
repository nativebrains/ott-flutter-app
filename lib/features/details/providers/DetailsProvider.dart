import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/details/models/ActorDetailsModel.dart';
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
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return genericDetailsResponseModel;
  }

  Future<GenericDetailsResponseModel?> fetchShowsDetails(String showId) async {
    GenericDetailsResponseModel? genericDetailsResponseModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.SHOW_DETAILS_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0,
          'show_id': showId,
        }),
      );

      if (response.status == 200) {
        genericDetailsResponseModel =
            GenericDetailsResponseModel.fromShowsJson(response.data);
        genericDetailsResponseModel.isPurchased = response.user_plan_status;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return genericDetailsResponseModel;
  }

  Future<ActorDetailsModel?> fetchActorDetails(bool isActor, String id) async {
    ActorDetailsModel? actorDetailsModel;
    try {
      final response = await apiService.post(
        isActor
            ? ApiEndpoints.ACTOR_DETAILS_URL
            : ApiEndpoints.DIRECTOR_DETAILS_URL,
        jsonEncode({
          isActor ? 'a_id' : 'd_id': int.parse(id),
        }),
      );

      if (response.status == 200) {
        actorDetailsModel = ActorDetailsModel.fromJson(response.data);

        print("All Good");
        print(actorDetailsModel.adBirthDate);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return actorDetailsModel;
  }
}
