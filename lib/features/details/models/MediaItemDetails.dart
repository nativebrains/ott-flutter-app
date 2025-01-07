import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/details/models/GenericDetailsResponseModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
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
  String? shareLink;

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
    this.downloadEnable,
    this.isPremium,
    this.mediaContentType = MediaContentType.movies,
    this.poster,
    this.category,
    this.shareLink,
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
        poster: sports.sportImage,
        shareLink: sports.sportShareLink,
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
      );
    } else {
      return MediaItemDetails();
    }
  }
}
