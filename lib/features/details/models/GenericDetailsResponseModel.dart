import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/details/models/ActorModel.dart';
import 'package:islamforever/features/mix/models/FilterDataModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemPodcastModel.dart';
import 'package:islamforever/features/mix/models/ItemSeasonModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';

import '../../mix/models/ItemMovieModel.dart';

class GenericDetailsResponseModel {
  bool? isPurchased;
  dynamic item;
  List<dynamic>? itemRelated;
  List<ActorModel>? actors;
  List<ActorModel>? directors;
  List<GenreModel>? genres;
  List<ItemSeasonModel>? seasons;

  GenericDetailsResponseModel({
    this.isPurchased,
    this.item,
    this.itemRelated,
    this.actors,
    this.directors,
    this.genres,
    this.seasons,
  });

  factory GenericDetailsResponseModel.fromMoviesJson(
      Map<String, dynamic> json) {
    return GenericDetailsResponseModel(
      item: ItemMovieModel.fromJson(json),
      itemRelated: (json[Constants.RELATED_MOVIE_ARRAY_NAME] as List)
          .map((e) => ItemMovieModel.fromJson(e))
          .toList(),
      actors: (json[Constants.ACTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e))
          .toList(),
      directors: (json[Constants.DIRECTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e)) // This line was incomplete
          .toList(),
      genres: (json[Constants.GENRE_LIST] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
    );
  }

  factory GenericDetailsResponseModel.fromShowsJson(Map<String, dynamic> json) {
    return GenericDetailsResponseModel(
      item: ItemShowModel.fromJson(json),
      itemRelated: (json[Constants.RELATED_SHOW_ARRAY_NAME] as List)
          .map((e) => ItemShowModel.fromJson(e))
          .toList(),
      actors: (json[Constants.ACTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e))
          .toList(),
      directors: (json[Constants.DIRECTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e)) // This line was incomplete
          .toList(),
      genres: (json[Constants.GENRE_LIST] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
      seasons: (json[Constants.SEASON_ARRAY_NAME] as List)
          .map((e) => ItemSeasonModel.fromJson(e))
          .toList(),
    );
  }

  factory GenericDetailsResponseModel.fromSportsJson(
      Map<String, dynamic> json) {
    return GenericDetailsResponseModel(
      item: ItemSportModel.fromJson(json),
      itemRelated: (json[Constants.RELATED_SPORT_ARRAY_NAME] as List)
          .map((e) => ItemSportModel.fromJson(e))
          .toList(),
    );
  }

  factory GenericDetailsResponseModel.fromLiveTvJson(
      Map<String, dynamic> json) {
    return GenericDetailsResponseModel(
      item: ItemLiveTVModel.fromJson(json),
      itemRelated: (json[Constants.RELATED_TV_ARRAY_NAME] as List)
          .map((e) => ItemLiveTVModel.fromJson(e))
          .toList(),
    );
  }

  factory GenericDetailsResponseModel.fromPodcastJson(
      Map<String, dynamic> json) {
    return GenericDetailsResponseModel(
      item: ItemPodcastModel.fromJson(json),
      itemRelated: (json[Constants.RELATED_PODCAST_NAME] as List)
          .map((e) => ItemPodcastModel.fromJson(e))
          .toList(),
      actors: (json[Constants.ACTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e))
          .toList(),
      directors: (json[Constants.DIRECTOR_ARRAY] as List)
          .map((e) => ActorModel.fromJson(e)) // This line was incomplete
          .toList(),
      genres: (json[Constants.GENRE_LIST] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.USER_PLAN_STATUS: isPurchased,
      Constants.ARRAY_NAME: item?.toJson(),
      Constants.RELATED_MOVIE_ARRAY_NAME:
          itemRelated?.map((e) => e.toJson()).toList(),
      Constants.ACTOR_ARRAY: actors?.map((e) => e.toJson()).toList(),
      Constants.DIRECTOR_ARRAY: directors?.map((e) => e.toJson()).toList(),
      Constants.GENRE_LIST: genres?.map((e) => e.toJson()).toList(),
    };
  }
}
