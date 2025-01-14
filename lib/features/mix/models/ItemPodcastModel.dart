import 'package:islamforever/features/details/models/ActorModel.dart';
import 'package:islamforever/features/mix/models/FilterDataModel.dart';

import '../../common/enums/MediaContentType.dart';

class ItemPodcastModel {
  int? audioId;
  String? contentRating;
  String? audioTitle;
  String? audioImage;
  String? audioPoster;
  String? audioAccess;
  String? description;
  String? audioDuration;
  String? releaseDate;
  String? audioType;
  String? audioUrl;
  String? downloadEnable;
  String? downloadUrl;
  int? langId;
  String? languageName;
  List<GenreModel>? genreList;
  String? audioQuality;
  String? shareUrl;
  String? views;
  List<ActorModel>? actorList;
  List<ActorModel>? directorList;
  bool? inWatchlist;
  String? upcoming;
  bool isPremium = false;
  List<dynamic>? relatedPodcast;
  final MediaContentType mediaContentType = MediaContentType.podcast;

  ItemPodcastModel({
    this.audioId,
    this.contentRating,
    this.audioTitle,
    this.audioImage,
    this.audioPoster,
    this.audioAccess,
    this.description,
    this.audioDuration,
    this.releaseDate,
    this.audioType,
    this.audioUrl,
    this.downloadEnable,
    this.downloadUrl,
    this.langId,
    this.languageName,
    this.genreList,
    this.audioQuality,
    this.shareUrl,
    this.views,
    this.actorList,
    this.directorList,
    this.inWatchlist,
    this.upcoming,
    this.relatedPodcast,
    this.isPremium = false,
  });

  factory ItemPodcastModel.fromJson(Map<String, dynamic> json) {
    return ItemPodcastModel(
      audioId: json['audio_id'],
      contentRating: json['content_rating'],
      audioTitle: json['audio_title'],
      audioImage: json['audio_image'],
      audioPoster: json['audio_poster'],
      audioAccess: json['audio_access'],
      isPremium: json['audio_access'] == "Paid",
      description: json['description'],
      audioDuration: json['audio_duration'],
      releaseDate: json['release_date'],
      audioType: json['audio_type'],
      audioUrl: json['audio_url'],
      downloadEnable: json['download_enable'],
      downloadUrl: json['download_url'],
      langId: json['lang_id'],
      languageName: json['language_name'],
      genreList: json['genre_list'] != null
          ? json['genre_list']
              .map<GenreModel>((json) => GenreModel.fromJson(json))
              .toList()
          : null,
      audioQuality: json['audio_quality'],
      shareUrl: json['share_url'],
      views: json['views'],
      actorList: json['actor_list'] != null
          ? json['actor_list']
              .map<ActorModel>((json) => ActorModel.fromJson(json))
              .toList()
          : null,
      directorList: json['director_list'] != null
          ? json['director_list']
              .map<ActorModel>((json) => ActorModel.fromJson(json))
              .toList()
          : null,
      inWatchlist: json['in_watchlist'],
      upcoming: json['upcoming'],
      relatedPodcast: json['related_podcast'],
    );
  }
}
