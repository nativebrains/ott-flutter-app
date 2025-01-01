import 'package:islamforever/features/dashboard/models/ItemHomeContentModel.dart';
import 'package:islamforever/features/dashboard/models/ItemHomeModel.dart';
import 'package:islamforever/features/dashboard/models/ItemSliderModel.dart';

class HomeDataModel {
  final List<ItemSliderModel> itemSlider;
  final List<ItemHomeModel> itemHome;

  HomeDataModel({
    required this.itemSlider,
    required this.itemHome,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      // Slider Content
      itemSlider: json['slider'] != null
          ? List<ItemSliderModel>.from(
              json['slider'].map((x) => ItemSliderModel.fromJson(x)))
          : [],
      // Other Dynamic Content
      itemHome: _parseItemHome(json),
    );
  }

  static List<ItemHomeModel> _parseItemHome(Map<String, dynamic> json) {
    List<ItemHomeModel> itemHomeList = [];

    // Recently Watched Videos
    if (json['recently_watched'] != null &&
        json['recently_watched'].length > 0) {
      ItemHomeModel objItem = ItemHomeModel(
        homeId: "-1",
        homeTitle: "Recently Watched",
        homeType: "Recent",
        itemHomeContentModel: List<ItemHomeContentModel>.from(
          json['recently_watched']
              .map((x) => ItemHomeContentModel.fromRecentlyWatchedJson(x)),
        ),
      );
      itemHomeList.add(objItem);
    }

    // Upcoming Movies
    if (json['upcoming_movies'] != null && json['upcoming_movies'].length > 0) {
      ItemHomeModel objItem = ItemHomeModel(
        homeId: "-1",
        homeTitle: "Upcoming Movies",
        homeType: "Movie",
        itemHomeContentModel: List<ItemHomeContentModel>.from(
          json['upcoming_movies']
              .map((x) => ItemHomeContentModel.fromUpcomingMoviesJson(x)),
        ),
      );
      itemHomeList.add(objItem);
    }

    // Upcoming Series
    if (json['upcoming_series'] != null && json['upcoming_series'].length > 0) {
      ItemHomeModel objItem = ItemHomeModel(
        homeId: "-1",
        homeTitle: "Upcoming Series",
        homeType: "Shows",
        itemHomeContentModel: List<ItemHomeContentModel>.from(
          json['upcoming_series']
              .map((x) => ItemHomeContentModel.fromUpcomingSeriesJson(x)),
        ),
      );
      itemHomeList.add(objItem);
    }

    return itemHomeList;
  }

  Map<String, dynamic> toJson() {
    return {
      'slider': itemSlider,
    };
  }
}
