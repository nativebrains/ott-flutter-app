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
      itemSlider: json['slider'] != null
          ? List<ItemSliderModel>.from(
              json['slider'].map((x) => ItemSliderModel.fromJson(x)))
          : [],
      itemHome: _parseItemHome(json),
    );
  }

  static List<ItemHomeModel> _parseItemHome(Map<String, dynamic> json) {
    List<ItemHomeModel> itemHomeList = [];

    if (json['recently_watched'] != null &&
        json['recently_watched'].length > 0) {
      ItemHomeModel objItem = ItemHomeModel(
        homeId: "-1",
        homeTitle: "Recently Watched",
        homeType: "Recent",
        itemHomeContentModel: List<ItemHomeContentModel>.from(
          json['recently_watched'].map((x) => ItemHomeContentModel.fromJson(x)),
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
