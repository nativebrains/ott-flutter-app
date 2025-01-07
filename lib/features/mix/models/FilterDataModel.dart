import 'package:islamforever/features/mix/models/Filter.dart';
import 'package:islamforever/features/mix/models/FilterType.dart';

class FilterDataModel {
  List<LanguageModel> language;
  List<GenreModel> genre;
  List<SportsCategoryModel> sportsCategory;
  List<TvCategoryModel> tvCategory;

  FilterDataModel({
    required this.language,
    required this.genre,
    required this.sportsCategory,
    required this.tvCategory,
  });

  factory FilterDataModel.fromJson(Map<String, dynamic> json) {
    return FilterDataModel(
      language: (json['language'] as List)
          .map((e) => LanguageModel.fromJson(e))
          .toList(),
      genre:
          (json['genre'] as List).map((e) => GenreModel.fromJson(e)).toList(),
      sportsCategory: (json['sports_category'] as List)
          .map((e) => SportsCategoryModel.fromJson(e))
          .toList(),
      tvCategory: (json['tv_category'] as List)
          .map((e) => TvCategoryModel.fromJson(e))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'language': language.map((e) => e.toJson()).toList(),
      'genre': genre.map((e) => e.toJson()).toList(),
      'sportsCategory': sportsCategory.map((e) => e.toJson()).toList(),
      'tvCategory': tvCategory.map((e) => e.toJson()).toList(),
    };
  }

  List<Filter> getCombinedFilters() {
    List<Filter> combinedFilters = [];

    for (var language in language) {
      combinedFilters.add(Filter(
        filterId: language.languageId.toString(),
        filterName: language.languageName,
        filterType: FilterType.TY_LANGUAGE,
      ));
    }

    for (var genre in genre) {
      combinedFilters.add(Filter(
        filterId: genre.genreId.toString(),
        filterName: genre.genreName,
        filterType: FilterType.TY_GENRE,
      ));
    }

    for (var category in sportsCategory) {
      combinedFilters.add(Filter(
        filterId: category.categoryId.toString(),
        filterName: category.categoryName,
        filterType: FilterType.TY_CATEGORY_SP,
      ));
    }

    for (var category in tvCategory) {
      combinedFilters.add(Filter(
        filterId: category.categoryId.toString(),
        filterName: category.categoryName,
        filterType: FilterType.TY_CATEGORY_TV,
      ));
    }

    combinedFilters.addAll(listOfOrderType());

    return combinedFilters;
  }

  static List<Filter> listOfOrderType() {
    return [
      Filter(
        filterId: 'new',
        filterName: 'NEWEST',
        filterType: FilterType.TY_ORDER_TYPE,
        isSelected: true,
      ),
      Filter(
        filterId: 'old',
        filterName: 'OLDEST',
        filterType: FilterType.TY_ORDER_TYPE,
      ),
      Filter(
        filterId: 'alpha',
        filterName: 'A to Z',
        filterType: FilterType.TY_ORDER_TYPE,
      ),
      Filter(
        filterId: 'rand',
        filterName: 'RANDOM',
        filterType: FilterType.TY_ORDER_TYPE,
      ),
    ];
  }
}

class LanguageModel {
  int languageId;
  String languageName;

  LanguageModel({
    required this.languageId,
    required this.languageName,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      languageId: json['language_id'],
      languageName: json['language_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'language_id': languageId,
      'language_name': languageName,
    };
  }
}

class GenreModel {
  dynamic genreId;
  String genreName;

  GenreModel({
    required this.genreId,
    required this.genreName,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      genreId: json['genre_id'],
      genreName: json['genre_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'genre_id': genreId,
      'genre_name': genreName,
    };
  }
}

class SportsCategoryModel {
  int categoryId;
  String categoryName;

  SportsCategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory SportsCategoryModel.fromJson(Map<String, dynamic> json) {
    return SportsCategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}

class TvCategoryModel {
  int categoryId;
  String categoryName;

  TvCategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory TvCategoryModel.fromJson(Map<String, dynamic> json) {
    return TvCategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}
