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
