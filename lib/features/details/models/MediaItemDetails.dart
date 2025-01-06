import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/details/models/GenericDetailsResponseModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';

import '../../mix/models/ItemMovieModel.dart';

class MediaItemDetails {
  String? title;
  String? image;
  String? description;
  String? rating;
  String? releaseDate;
  String? duration;
  String? contentRating;
  String? views;
  String? language;
  String? trailer;
  bool? inWatchList;
  bool? upcoming;
  bool? downloadEnable;
  bool? isPremium;
  MediaContentType mediaContentType;

  MediaItemDetails({
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
  });

  static MediaItemDetails getMediaItemDetails(
      GenericDetailsResponseModel responseModel) {
    if (responseModel.item is ItemMovieModel) {
      ItemMovieModel movie = responseModel.item as ItemMovieModel;
      return MediaItemDetails(
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
      );
    } else if (responseModel.item is ItemShowModel) {
      ItemShowModel tvShow = responseModel.item as ItemShowModel;
      return MediaItemDetails(
        title: tvShow.showName,
        image: tvShow.showImage,
        description: tvShow.showDescription,
        rating: tvShow.showRating,
      );
    } else if (responseModel.item is ItemSportModel) {
      ItemSportModel sports = responseModel.item as ItemSportModel;
      return MediaItemDetails(
        title: sports.sportName,
        image: sports.sportImage,
        description: sports.sportDescription,
      );
    } else if (responseModel.item is ItemLiveTVModel) {
      ItemLiveTVModel liveTv = responseModel.item as ItemLiveTVModel;
      return MediaItemDetails(
        title: liveTv.tvName,
        image: liveTv.tvImage,
        description: liveTv.tvDescription,
      );
    } else {
      return MediaItemDetails();
    }
  }
}
