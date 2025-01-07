import '../../common/enums/MediaContentType.dart';

class ItemShowModel {
  int? showId;
  String? showName;
  String? showImage;
  String? showDescription;
  String? showLanguage;
  String? showRating;
  String? showContentRating;
  bool isPremium = false;
  bool? upcoming;

  final MediaContentType mediaContentType = MediaContentType.tvShows;

  ItemShowModel({
    this.showId,
    this.showName,
    this.showImage,
    this.showDescription,
    this.showLanguage,
    this.showRating,
    this.showContentRating,
    this.isPremium = false,
    this.upcoming = false,
  });

  factory ItemShowModel.fromJson(Map<String, dynamic> json) {
    return ItemShowModel(
      showId: json['show_id'],
      showName: json['show_name'],
      showImage: json['show_poster'],
      showDescription: json['show_info'],
      showLanguage: json['show_lang'],
      showRating: json['imdb_rating'],
      showContentRating: json['content_rating'],
      isPremium: json['series_access'] == "Paid",
      upcoming: json['upcoming'] == "true",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'showName': showName,
      'showImage': showImage,
      'showDescription': showDescription,
      'showLanguage': showLanguage,
      'showRating': showRating,
      'showContentRating': showContentRating,
      'isPremium': isPremium,
    };
  }
}
