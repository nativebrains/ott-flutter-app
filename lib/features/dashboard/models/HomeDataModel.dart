import 'package:islamforever/features/dashboard/models/ItemSliderModel.dart';

class HomeDataModel {
  final List<ItemSliderModel> itemSlider;

  HomeDataModel({
    required this.itemSlider,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      itemSlider: json['slider'] != null
          ? List<ItemSliderModel>.from(
              json['slider'].map((x) => ItemSliderModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slider': itemSlider,
    };
  }
}
