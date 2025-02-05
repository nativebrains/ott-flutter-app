import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/details/models/GenericDetailsResponseModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemPodcastModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';

import '../../mix/models/ItemMovieModel.dart';

class MediaItemDetails {
  int? id;
  String? title;
  String? image;
  String? poster;
  String? description;
  String? rating;
  String? releaseDate;
  String? duration;
  String? contentRating;
  String? category;
  String? views;
  String? language;
  String? trailer;
  bool? inWatchList;
  bool? upcoming;
  bool? downloadEnable;
  bool? isPremium;
  MediaContentType mediaContentType;
  String? mediaPlayUrl;
  String? shareLink;
  bool? isDownload;
  String? server1Url;
  String? server2Url;
  String? server3Url;

  MediaItemDetails({
    this.id,
    this.title,
    this.image,
    this.description,
    this.rating,
    this.releaseDate,
    this.duration,
    this.contentRating,
    this.views,
    this.language,
    this.trailer,
    this.inWatchList,
    this.upcoming,
    this.mediaPlayUrl,
    this.downloadEnable,
    this.isPremium,
    this.mediaContentType = MediaContentType.movies,
    this.poster,
    this.category,
    this.shareLink,
    this.isDownload,
    this.server1Url,
    this.server2Url,
    this.server3Url,
  });

  static MediaItemDetails getMediaItemDetails(
      GenericDetailsResponseModel responseModel) {
    if (responseModel.item is ItemMovieModel) {
      ItemMovieModel movie = responseModel.item as ItemMovieModel;
      return MediaItemDetails(
        id: movie.movieId,
        title: movie.movieName,
        image: movie.movieImage,
        description: movie.movieDescription,
        mediaPlayUrl: movie.movieUrl,
        rating: movie.movieRating,
        releaseDate: movie.movieDate,
        duration: movie.movieDuration,
        contentRating: movie.movieContentRating,
        views: movie.movieView,
        language: movie.movieLanguage,
        trailer: movie.movieTrailer,
        inWatchList: movie.inwatchList,
        upcoming: movie.upcoming,
        downloadEnable: movie.isDownload,
        isPremium: movie.isPremium,
        mediaContentType: MediaContentType.movies,
        poster: movie.moviePoster,
        shareLink: movie.movieShareLink,
        isDownload: movie.isDownload,
      );
    } else if (responseModel.item is ItemShowModel) {
      ItemShowModel tvShow = responseModel.item as ItemShowModel;
      return MediaItemDetails(
        id: tvShow.showId,
        title: tvShow.showName,
        image: tvShow.showImage,
        description: tvShow.showDescription,
        rating: tvShow.showRating,
        contentRating: tvShow.showContentRating,
        language: tvShow.showLanguage,
        upcoming: tvShow.upcoming,
        mediaContentType: MediaContentType.tvShows,
        poster: tvShow.showImage,
      );
    } else if (responseModel.item is ItemSportModel) {
      // Not handle for not data
      ItemSportModel sports = responseModel.item as ItemSportModel;
      return MediaItemDetails(
        id: sports.sportId,
        title: sports.sportTitle,
        image: sports.sportImage,
        description: sports.sportDescription,
        releaseDate: sports.sportDate,
        duration: sports.sportDuration,
        category: sports.sportCategory,
        views: sports.sportView,
        inWatchList: sports.inWatchlist,
        downloadEnable: sports.isDownload,
        isPremium: sports.isPremium,
        mediaContentType: MediaContentType.sports,
        mediaPlayUrl: sports.videoUrl,
        poster: sports.sportImage,
        shareLink: sports.sportShareLink,
        isDownload: sports.isDownload,
      );
    } else if (responseModel.item is ItemLiveTVModel) {
      ItemLiveTVModel liveTv = responseModel.item as ItemLiveTVModel;
      return MediaItemDetails(
        id: liveTv.tvId,
        title: liveTv.tvName,
        image: liveTv.tvImage,
        description: liveTv.description,
        views: liveTv.tvView,
        inWatchList: liveTv.inWatchlist,
        isPremium: liveTv.isPremium,
        mediaContentType: MediaContentType.liveTv,
        poster: liveTv.tvImage,
        shareLink: liveTv.shareUrl,
        server1Url: liveTv.tvUrl,
        server2Url: liveTv.tvUrl2,
        server3Url: liveTv.tvUrl3,
        mediaPlayUrl: liveTv.tvUrl,
      );
    } else if (responseModel.item is ItemPodcastModel) {
      ItemPodcastModel podcast = responseModel.item as ItemPodcastModel;
      return MediaItemDetails(
        id: podcast.audioId,
        title: podcast.audioTitle,
        image: podcast.audioImage,
        description: podcast.description,
        rating: podcast.contentRating,
        releaseDate: podcast.releaseDate,
        duration: podcast.audioDuration,
        contentRating: podcast.contentRating,
        views: podcast.views,
        language: podcast.languageName,
        inWatchList: podcast.inWatchlist,
        upcoming: podcast.upcoming,
        downloadEnable: podcast.downloadEnable,
        isPremium: podcast.isPremium,
        mediaContentType: MediaContentType.podcast,
        poster: podcast.audioPoster,
        shareLink: podcast.shareUrl,
        mediaPlayUrl: podcast.audioUrl,
      );
    } else {
      return MediaItemDetails();
    }
  }
}
