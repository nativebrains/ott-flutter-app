import 'dart:convert';
import 'package:islamforever/features/mix/models/Filter.dart';
import 'package:islamforever/features/mix/models/FilterType.dart';

class FilterUtil {
  static List<Filter> jsonToList(String json) {
    return jsonDecode(json).map((e) => Filter.fromJson(e)).toList();
  }

  static String listToJson(List<Filter> list) {
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<Filter> jsonToSelectList(String json) {
    List<Filter> list = jsonToList(json);
    return list.where((filter) => filter.isSelected).toList();
  }

  static void jsonForParameter(
      List<Filter> filterSelectedList, Map<String, dynamic> jsObj, int secId) {
    List<FilterType> listType = FilterType.getFilterTypeListBySec(secId);
    for (FilterType filterType in listType) {
      jsObj[filterType.getFilterTypeParameterName() ?? ''] =
          getCommaSepIds(filterSelectedList, filterType.getFilterType() ?? '');
    }
  }

  static String getCommaSepIds(List<Filter> filterSelectedList, String type) {
    List<String> ids = filterSelectedList
        .where((filter) => filter.getFilterType() == type)
        .map((filter) => filter.getFilterId().toString())
        .toList();
    return ids.join(',');
  }
}
