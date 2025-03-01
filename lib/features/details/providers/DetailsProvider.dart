import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/details/models/ActorDetailsModel.dart';
import 'package:islamforever/features/details/models/ReviewModel.dart';
import 'package:islamforever/features/mix/models/ItemEpisodeModel.dart';
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
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
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
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
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

  Future<GenericDetailsResponseModel?> fetchSportsDetails(String showId) async {
    GenericDetailsResponseModel? genericDetailsResponseModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.SPORT_DETAILS_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'sport_id': showId,
        }),
      );

      if (response.status == 200) {
        genericDetailsResponseModel =
            GenericDetailsResponseModel.fromSportsJson(response.data);
        genericDetailsResponseModel.isPurchased = response.user_plan_status;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return genericDetailsResponseModel;
  }

  Future<GenericDetailsResponseModel?> fetchLiveTvDetails(String tvId) async {
    GenericDetailsResponseModel? genericDetailsResponseModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.TV_DETAILS_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'tv_id': tvId,
        }),
      );

      if (response.status == 200) {
        genericDetailsResponseModel =
            GenericDetailsResponseModel.fromLiveTvJson(response.data);
        genericDetailsResponseModel.isPurchased = response.user_plan_status;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return genericDetailsResponseModel;
  }

  Future<GenericDetailsResponseModel?> fetchPodCastDetails(
      String audioId) async {
    GenericDetailsResponseModel? genericDetailsResponseModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.PODCAST_DETAILS_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'audio_id': audioId,
        }),
      );

      if (response.status == 200) {
        genericDetailsResponseModel =
            GenericDetailsResponseModel.fromPodcastJson(response.data);
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
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return actorDetailsModel;
  }

  Future<List<ItemEpisodeModel>?> fetchSeasonEpisodeDetails(int? id) async {
    List<ItemEpisodeModel>? itemEpisodeModel;
    try {
      final response = await apiService.post(
        ApiEndpoints.EPISODE_LIST_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'season_id': id,
        }),
      );

      if (response.status == 200) {
        itemEpisodeModel = (response.data as List)
            .map((e) => ItemEpisodeModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return itemEpisodeModel;
  }

  Future<bool> addOrRemoveWatchList(
      bool? inWatchList, int? id, String? shortDisplayName) async {
    bool isSuccess = false;
    try {
      final response = await apiService.post(
        (inWatchList ?? false)
            ? ApiEndpoints.REMOVE_FROM_WATCHLIST_URL
            : ApiEndpoints.ADD_TO_WATCHLIST_URL,
        jsonEncode({
          'post_id': id,
          'post_type': shortDisplayName,
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
        }),
      );

      if (response.status == 200) {
        final jsonData = response.data;
        _statusMessage = jsonData[0]['msg'];
        isSuccess = true;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return isSuccess;
  }

  Future<bool> submitReviewRating(
    int rating,
    String review,
    int? id,
    String? type,
  ) async {
    bool isSuccess = false;
    try {
      final response = await apiService.post(
        ApiEndpoints.CONTENT_ADD_REVIEW_URL,
        jsonEncode({
          'review': review,
          'rating': rating,
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'module_id': id,
          'type': type,
        }),
      );

      if (response.status == 200) {
        final jsonData = response.message;
        _statusMessage = jsonData;
        isSuccess = true;
      } else {
        _statusMessage = null;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = null;
    }

    notifyListeners();
    return isSuccess;
  }

  Future<List<ReviewModel>?> fetchMediaReviewsDetails(
      int? id, String? type) async {
    List<ReviewModel>? itemReviewsList;
    try {
      final response = await apiService.post(
        ApiEndpoints.CONTENT_GET_ALL_REVIEW_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
          'module_id': id,
          'type': type,
        }),
      );

      if (response.status == 200) {
        itemReviewsList = (response.reviews as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList();
        print(itemReviewsList.length);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }

    notifyListeners();
    return itemReviewsList;
  }
}
