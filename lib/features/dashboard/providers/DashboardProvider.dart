import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:islamforever/features/account/models/LoginUserModel.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/models/ItemHomeContentModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';
import 'package:islamforever/features/watchlist/models/ItemWatchListModel.dart';

import '../../../constants/ApiEndpoints.dart';
import '../../../constants/constants.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/services/shared_preference.dart';
import '../../mix/models/FilterDataModel.dart';
import '../../mix/models/ItemPodcastModel.dart';
import '../../mix/models/ItemShowModel.dart';
import '../models/HomeDataModel.dart';

class DashboardProvider extends ChangeNotifier {
  static ApiService apiService = ApiService();
  static String? _statusMessage;
  static MediaContentType? _selectedMixScreenContentType;
  
  HomeDataModel? dashboardData;
  FilterDataModel? filterDataModel;
  List<ItemWatchListModel> itemsWatchListData = [];

  bool _isHomeScreenLoading = false;
  bool get isHomeScreenLoading => _isHomeScreenLoading;

  bool _isWatchListScreenLoading = false;
  bool get isWatchListScreenLoading => _isWatchListScreenLoading;

  // Mix Screen Content
  Map<String, dynamic> _filterData = {};
  Map<String, dynamic> get getfilterData => _filterData;
  bool _isMixScreenLoading = false;
  bool get isMixScreenLoading => _isMixScreenLoading;
  List<ItemMovieModel> itemsMixMoviesList = [];
  int mixMoviesPageIndex = 1;
  List<ItemShowModel> itemsMixShowsList = [];
  int mixShowsPageIndex = 1;
  List<ItemSportModel> itemsMixSportList = [];
  int mixSportPageIndex = 1;
  List<ItemLiveTVModel> itemsMixLiveTvList = [];
  int mixLiveTvPageIndex = 1;
  List<ItemPodcastModel> itemsPodcastList = [];
  int podcastPageIndex = 1;

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
    _filterData = {};
    fetchMixScreenData(reset: true);
    notifyListeners();
  }

  void setFilterDataAndRefresh(Map<String, dynamic> filterData) {
    _filterData = filterData;
    fetchMixScreenData(reset: true);
    notifyListeners();
  }

  Future<HomeDataModel?> fetchDashboardHomeData({bool refresh = false}) async {
    // Fetch Bottom Filter Sheet Data
    fetchFilterData(refresh: refresh);

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

    _isHomeScreenLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndpoints.HOME_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
        }),
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

    _isHomeScreenLoading = false;
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
    _isWatchListScreenLoading = true;
    notifyListeners();

    try {
      final response = await apiService.post(
        ApiEndpoints.MY_WATCHLIST_WATCHLIST_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
        }),
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

    _isWatchListScreenLoading = false;
    notifyListeners();
    return itemsWatchListData;
  }

  void fetchMixScreenData({bool reset = false}) {
    switch (selectedMixScreenContentType) {
      case MediaContentType.movies:
        if (reset) {
          itemsMixMoviesList = [];
          mixMoviesPageIndex = 1;
        }
        fetchMixMoviesData();
        break;
      case MediaContentType.tvShows:
        if (reset) {
          itemsMixShowsList = [];
          mixShowsPageIndex = 1;
        }
        fetchMixTvShowsData();
        break;
      case MediaContentType.sports:
        if (reset) {
          itemsMixSportList = [];
          mixSportPageIndex = 1;
        }
        fetchMixSportsData();
        break;
      case MediaContentType.liveTv:
        if (reset) {
          itemsMixLiveTvList = [];
          mixLiveTvPageIndex = 1;
        }
        fetchMixLiveTvData();
      case MediaContentType.podcast:
        if (reset) {
          itemsPodcastList = [];
          podcastPageIndex = 1;
        }
        fetchPodcastData();
        break;
    }
  }

  Future<List<ItemMovieModel>> fetchMixMoviesData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.MOVIE_FILTER_URL,
        jsonEncode(
          {
            'lang_id': _filterData['lang_id'] ?? '',
            'genre_id': _filterData['genre_id'] ?? '',
            'filter': _filterData['filter'] ?? 'new',
          },
        ),
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
        _hasMoreMovies = response.load_more;
        mixMoviesPageIndex++;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchMixMoviesData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsMixMoviesList;
  }

  Future<List<ItemShowModel>> fetchMixTvShowsData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.SHOW_FILTER_URL,
        jsonEncode(
          {
            'lang_id': _filterData['lang_id'] ?? '',
            'genre_id': _filterData['genre_id'] ?? '',
            'filter': _filterData['filter'] ?? 'new',
          },
        ),
        page: mixShowsPageIndex,
      );

      if (response.status == 200) {
        for (var item in response.data) {
          ItemShowModel objItem = ItemShowModel(
            showId: item['show_id'],
            showName: item['show_title'],
            showImage: item['show_poster'],
            isPremium: item['show_access'] == 'Paid',
          );
          itemsMixShowsList.add(objItem);
        }
        _hasMoreShows = response.load_more;
        mixShowsPageIndex++;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchMixMoviesData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsMixShowsList;
  }

  Future<List<ItemSportModel>> fetchMixSportsData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.SPORT_FILTER_URL,
        jsonEncode(
          {
            'cat_id': _filterData['cat_id'] ?? '',
            'filter': _filterData['filter'] ?? 'new',
          },
        ),
        page: mixSportPageIndex,
      );

      if (response.status == 200) {
        for (var item in response.data) {
          ItemSportModel objItem = ItemSportModel(
            sportId: item['sport_id'],
            sportTitle: item['sport_title'],
            sportImage: item['sport_image'],
            isPremium: item['sport_access'] == 'Paid',
          );
          itemsMixSportList.add(objItem);
        }
        _hasMoreSports = response.load_more;
        mixSportPageIndex++;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchMixMoviesData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsMixSportList;
  }

  Future<List<ItemLiveTVModel>> fetchMixLiveTvData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.TV_FILTER_URL,
        jsonEncode(
          {
            'cat_id': _filterData['cat_id'] ?? '',
            'filter': _filterData['filter'] ?? 'new',
          },
        ),
        page: mixLiveTvPageIndex,
      );

      if (response.status == 200) {
        for (var item in response.data) {
          ItemLiveTVModel objItem = ItemLiveTVModel(
            tvId: item['tv_id'],
            tvName: item['tv_title'],
            tvImage: item['tv_logo'],
            isPremium: item['tv_access'] == 'Paid',
          );
          itemsMixLiveTvList.add(objItem);
        }
        _hasMoreLiveTv = response.load_more;
        mixLiveTvPageIndex++;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchMixLiveTvData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsMixLiveTvList;
  }

  Future<List<ItemPodcastModel>> fetchPodcastData() async {
    _isMixScreenLoading = true;
    notifyListeners();
    try {
      final response = await apiService.post(
        ApiEndpoints.PODCAST_FILTER_URL,
        jsonEncode(
          {
            'lang_id': _filterData['lang_id'] ?? '',
            'genre_id': _filterData['genre_id'] ?? '',
            'filter': _filterData['filter'] ?? 'new',
          },
        ),
        page: podcastPageIndex,
      );

      if (response.status == 200) {
        for (var item in response.data) {
          ItemPodcastModel objItem = ItemPodcastModel.fromJson(item);
          itemsPodcastList.add(objItem);
        }
        _hasMorePodcast = response.load_more;
        podcastPageIndex++;
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchPodcastData";
    }
    _isMixScreenLoading = false;
    notifyListeners();
    return itemsPodcastList;
  }

  bool _hasMoreMovies = true;
  bool _hasMoreShows = true;
  bool _hasMoreSports = true;
  bool _hasMoreLiveTv = true;
  bool _hasMorePodcast = true;

  bool hasMoreData() {
    switch (_selectedMixScreenContentType) {
      case MediaContentType.movies:
        return _hasMoreMovies;
      case MediaContentType.tvShows:
        return _hasMoreShows;
      case MediaContentType.sports:
        return _hasMoreSports;
      case MediaContentType.liveTv:
        return _hasMoreLiveTv;
      case MediaContentType.podcast:
        return _hasMorePodcast;
      default:
        return false;
    }
  }

  Future<void> fetchFilterData({bool refresh = false}) async {
    if (!refresh) {
      final String? cachedDataString =
          await SharedPrefs.getCachedData(ApiEndpoints.FILTER_LIST_URL);
      if (cachedDataString != null) {
        // Return cached data if available
        final Map<String, dynamic> data = json.decode(cachedDataString);
        filterDataModel = FilterDataModel.fromJson(data);
        notifyListeners();
        return;
      }
    }

    try {
      final response = await apiService.post(
        ApiEndpoints.FILTER_LIST_URL,
        jsonEncode({
          'user_id': isLoggedIn ? (loginUserModel?.userId ?? "") : "",
        }),
      );

      if (response.status == 200) {
        // Cache the fresh data
        await SharedPrefs.cacheData(
            json.encode(response.data), ApiEndpoints.FILTER_LIST_URL);
        final Map<String, dynamic> data =
            json.decode(json.encode(response.data));
        filterDataModel = FilterDataModel.fromJson(data);
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in fetchFilterData";
    }

    notifyListeners();
  }

  Future<List<dynamic>> searchQueryAll(String searchQuery) async {
    List<dynamic> resultList = [];
    try {
      final response = await apiService.post(
        ApiEndpoints.SEARCH_URL,
        jsonEncode({'search_text': searchQuery}),
      );

      if (response.status == 200) {
        final liveTVJson = response.data;
        final showArray = liveTVJson['shows'];
        final movieArray = liveTVJson['movies'];
        final sportArray = liveTVJson['sports'];
        final tvArray = liveTVJson['live_tv'];
        final podcastArray = liveTVJson['podcast'];

        resultList = [
          if (showArray != null)
            ...showArray.map((json) {
              return ItemShowModel(
                  showId: json['show_id'],
                  showName: json['show_title'],
                  showImage: json['show_poster'],
                  isPremium: json['show_access'] == 'Paid');
            }),
          if (movieArray != null)
            ...movieArray.map((json) {
              return ItemMovieModel(
                movieId: json['movie_id'],
                movieName: json['movie_title'],
                movieImage: json['movie_poster'],
                movieDuration: json['movie_duration'],
                isPremium: json['movie_access'] == 'Paid',
              );
            }),
          if (sportArray != null)
            ...sportArray.map((json) {
              return ItemSportModel(
                sportId: json['sport_id'],
                sportTitle: json['sport_title'],
                sportImage: json['sport_image'],
                isPremium: json['sport_access'] == 'Paid',
              );
            }),
          if (tvArray != null)
            ...tvArray.map((json) {
              return ItemLiveTVModel(
                tvId: json['tv_id'],
                tvName: json['tv_title'],
                tvImage: json['tv_image'],
                isPremium: json['tv_access'] == 'Paid',
              );
            }),
          if (podcastArray != null)
            ...podcastArray.map((json) {
              return ItemPodcastModel.fromJson(json);
            }),
        ];
      }
    } catch (e) {
      print("Error: $e");
      _statusMessage = "Server Error in searchQueryAll";
    }

    notifyListeners();
    return resultList;
  }
}
