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
  int genreId;
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
