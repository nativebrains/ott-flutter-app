import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';

class ActorDetailsModel {
  String adImage;
  String adName;
  String adBirthPlace;
  String adBirthDate;
  String adBio;
  List<ItemMovieModel> movies;
  List<ItemShowModel> shows;

  ActorDetailsModel({
    required this.adImage,
    required this.adName,
    required this.adBirthPlace,
    required this.adBirthDate,
    required this.adBio,
    required this.movies,
    required this.shows,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) {
    return ActorDetailsModel(
      adImage: json['ad_image'],
      adName: json['ad_name'],
      adBirthPlace: json['ad_place_of_birth'],
      adBirthDate: json['ad_birthdate'],
      adBio: json['ad_bio'],
      movies: (json['movies'] as List)
          .map((movie) => ItemMovieModel.fromJson(movie))
          .toList(),
      shows: (json['shows'] as List)
          .map((show) => ItemShowModel.fromJson(show))
          .toList(),
    );
  }
}
