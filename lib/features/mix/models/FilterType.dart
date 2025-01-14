class FilterType {
  int? filterTypeSec;
  String? filterType;
  String? filterTypeName;
  String? filterTypeParameterName;

  static const int MOVIE = 1;
  static const int SHOW = 2;
  static const int TV = 3;
  static const int SPORT = 4;
  static const int PODCAST = 5;

  static const String TY_LANGUAGE = "1";
  static const String TY_GENRE = "2";
  static const String TY_ORDER_TYPE = "3";
  static const String TY_CATEGORY_SP = "4";
  static const String TY_CATEGORY_TV = "5";

  static const String LANGUAGE = "Language";
  static const String GENRE = "Genre";
  static const String ORDER_TYPE = "Order Type";
  static const String CATEGORY = "Category";

  static const String PR_LANGUAGE = "lang_id";
  static const String PR_GENRE = "genre_id";
  static const String PR_CATEGORY_SP = "cat_id";
  static const String PR_CATEGORY_TV = "cat_id";
  static const String PR_ORDER = "filter";

  FilterType({
    this.filterTypeSec,
    this.filterType,
    this.filterTypeName,
    this.filterTypeParameterName,
  });

  factory FilterType.fromJson(Map<String, dynamic> json) {
    return FilterType(
      filterTypeSec: json['filterTypeSec'],
      filterType: json['filterType'],
      filterTypeName: json['filterTypeName'],
      filterTypeParameterName: json['filterTypeParameterName'],
    );
  }

  String? getFilterType() => filterType;
  String? getFilterTypeName() => filterTypeName;
  int? getFilterTypeSec() => filterTypeSec;
  String? getFilterTypeParameterName() => filterTypeParameterName;

  static List<FilterType> listOfFilterType() {
    return [
      FilterType(
        filterTypeSec: MOVIE,
        filterType: TY_LANGUAGE,
        filterTypeName: LANGUAGE,
        filterTypeParameterName: PR_LANGUAGE,
      ),
      FilterType(
        filterTypeSec: MOVIE,
        filterType: TY_GENRE,
        filterTypeName: GENRE,
        filterTypeParameterName: PR_GENRE,
      ),
      FilterType(
        filterTypeSec: MOVIE,
        filterType: TY_ORDER_TYPE,
        filterTypeName: ORDER_TYPE,
        filterTypeParameterName: PR_ORDER,
      ),
      FilterType(
        filterTypeSec: SHOW,
        filterType: TY_LANGUAGE,
        filterTypeName: LANGUAGE,
        filterTypeParameterName: PR_LANGUAGE,
      ),
      FilterType(
        filterTypeSec: SHOW,
        filterType: TY_GENRE,
        filterTypeName: GENRE,
        filterTypeParameterName: PR_GENRE,
      ),
      FilterType(
        filterTypeSec: SHOW,
        filterType: TY_ORDER_TYPE,
        filterTypeName: ORDER_TYPE,
        filterTypeParameterName: PR_ORDER,
      ),
      FilterType(
        filterTypeSec: SPORT,
        filterType: TY_CATEGORY_SP,
        filterTypeName: CATEGORY,
        filterTypeParameterName: PR_CATEGORY_SP,
      ),
      FilterType(
        filterTypeSec: SPORT,
        filterType: TY_ORDER_TYPE,
        filterTypeName: ORDER_TYPE,
        filterTypeParameterName: PR_ORDER,
      ),
      FilterType(
        filterTypeSec: TV,
        filterType: TY_CATEGORY_TV,
        filterTypeName: CATEGORY,
        filterTypeParameterName: PR_CATEGORY_TV,
      ),
      FilterType(
        filterTypeSec: TV,
        filterType: TY_ORDER_TYPE,
        filterTypeName: ORDER_TYPE,
        filterTypeParameterName: PR_ORDER,
      ),
      FilterType(
        filterTypeSec: PODCAST,
        filterType: TY_LANGUAGE,
        filterTypeName: LANGUAGE,
        filterTypeParameterName: PR_LANGUAGE,
      ),
      FilterType(
        filterTypeSec: PODCAST,
        filterType: TY_GENRE,
        filterTypeName: GENRE,
        filterTypeParameterName: PR_GENRE,
      ),
      FilterType(
        filterTypeSec: PODCAST,
        filterType: TY_ORDER_TYPE,
        filterTypeName: ORDER_TYPE,
        filterTypeParameterName: PR_ORDER,
      ),
    ];
  }

  static List<FilterType> getFilterTypeListBySec(int secId) {
    return listOfFilterType()
        .where((filterType) => filterType.filterTypeSec == secId)
        .toList();
  }
}
