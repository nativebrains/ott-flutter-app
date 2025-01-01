import 'package:islamforever/features/dashboard/models/ItemHomeContentModel.dart';

class ItemHomeModel {
  String? homeId;
  String? homeTitle;
  String? homeType;
  List<ItemHomeContentModel>? itemHomeContentModel;

  ItemHomeModel({
    this.homeId,
    this.homeTitle,
    this.homeType,
    this.itemHomeContentModel,
  });

  factory ItemHomeModel.fromJson(Map<String, dynamic> json) {
    return ItemHomeModel(
      homeId: json['home_id'],
      homeTitle: json['home_title'],
      homeType: json['home_type'],
      itemHomeContentModel: json['item_home_contents'] != null
          ? List<ItemHomeContentModel>.from(json['item_home_contents']
              .map((x) => ItemHomeContentModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home_id': homeId,
      'home_title': homeTitle,
      'home_type': homeType,
      'item_home_contents':
          itemHomeContentModel?.map((e) => e.toJson()).toList(),
    };
  }
}
