import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/account/models/LoginUserModel.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/models/ItemHomeContentModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/watchlist/models/ItemWatchListModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../constants/constants.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../models/HomeDataModel.dart';

class DashboardProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;
  static MediaContentType? _selectedMixScreenContentType;
  HomeDataModel? dashboardData;
  List<ItemWatchListModel> itemsWatchListData = [];

  // Mix Screen Content
  bool _isMixScreenLoading = false;
  bool get isMixScreenLoading => _isMixScreenLoading;
  List<ItemMovieModel> itemsMixMoviesList = [];
  int mixMoviesPageIndex = 1;

  LoginUserModel? get loginUserModel => SharedPrefs.getLoginUserData();

  static get isLoggedIn {
    return SharedPrefs.getBool(Constants.IS_LOGGED_ID);
  }

  static get selectedMixScreenContentType {
    return _selectedMixScreenContentType;
  }

  static get selectedMixScreenContentTypeName {
    return _selectedMixScreenContentType?.displayName;
  }

  void setSelectedMixScreenContentType(MediaContentType contentType) {
    _selectedMixScreenContentType = contentType;
    fetchMixScreenData(reset: true);
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
        jsonEncode({'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0}),
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

  Future<List<ItemHomeContentModel>> fetchSeeAllData(String id) async {
    List<ItemHomeContentModel> itemsList = [];
    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_MORE_URL,
        jsonEncode({'id': id}),
      );

      if (response.status == 200) {
        if (response.data["home_sections"] != null) {
          List<dynamic> homeSecArray = response.data["home_sections"];
          for (int i = 0; i < homeSecArray.length; i++) {
            Map<String, dynamic> objJson = homeSecArray[i];
            List<dynamic> homeContentArray = objJson["home_content"];
            for (int j = 0; j < homeContentArray.length; j++) {
              Map<String, dynamic> objJsonSec = homeContentArray[j];
              ItemHomeContentModel itemHomeContent = ItemHomeContentModel(
                videoId: objJsonSec["video_id"],
                videoTitle: objJsonSec["video_title"].toString(),
                videoImage: objJsonSec["video_image"].toString(),
                videoType: objJsonSec["video_type"].toString(),
                homeType: objJsonSec["video_type"].toString(),
                isPremium: objJsonSec["video_access"] == "Paid",
              );
              itemsList.add(itemHomeContent);
            }
          }
        }
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }
    notifyListeners();
    return itemsList;
  }

  Future<List<ItemWatchListModel>> fetchMyWatchListData(
      {bool refresh = false}) async {
    if (!refresh) {
      final String? cachedDataString = await SharedPrefs.getCachedData(
          ApiEndpoints.MY_WATCHLIST_WATCHLIST_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final List<dynamic> data = jsonDecode(cachedDataString);
        itemsWatchListData =
            data.map((item) => ItemWatchListModel.fromJson(item)).toList();
        notifyListeners();
        return itemsWatchListData;
      }
    }

    try {
      final response = await apiService.post(
        ApiEndpoints.MY_WATCHLIST_WATCHLIST_URL,
        jsonEncode({'user_id': isLoggedIn ? (loginUserModel?.userId ?? 0) : 0}),
      );

      if (response.status == 200) {
        itemsWatchListData = (response.data as List)
            .map((item) => ItemWatchListModel.fromJson(item))
            .toList();

        // Cache the fresh data
        await SharedPrefs.cacheData(
            jsonEncode(response.data), ApiEndpoints.MY_WATCHLIST_WATCHLIST_URL);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchDashboardData";
    }
    notifyListeners();
    return itemsWatchListData;
  }

  void fetchMixScreenData({bool reset = false}) {
    switch (selectedMixScreenContentType) {
      case MediaContentType.movies:
        if (reset) itemsMixMoviesList = [];
        fetchMixMoviesData();
        break;
      case MediaContentType.tvShows:
        break;
      case MediaContentType.sports:
        break;
      case MediaContentType.liveTv:
        break;
    }
  }

  Future<List<ItemMovieModel>> fetchMixMoviesData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.MOVIE_FILTER_URL,
        jsonEncode({'lang_id': '', 'genre_id': '', 'filter': 'new'}),
        page: mixMoviesPageIndex,
      );

      if (response.status == 200) {
        for (var item in response.data) {
          ItemMovieModel objItem = ItemMovieModel(
            movieId: item['movie_id'],
            movieName: item['movie_title'],
            movieImage: item['movie_poster'],
            isPremium: item['movie_access'] == 'Paid',
          );
          itemsMixMoviesList.add(objItem);
        }
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchMixMoviesData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsMixMoviesList;
  }
}
