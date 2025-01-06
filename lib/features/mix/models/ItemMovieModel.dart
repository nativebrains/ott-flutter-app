import '../../../constants/constants.dart';
import '../../common/enums/MediaContentType.dart';

class ItemMovieModel {
  int? movieId;
  String? movieName;
  String? movieImage;
  String? moviePoster;
  String? movieDuration;
  String? movieDescription;
  String? movieDate;
  String? movieLanguage;
  String? movieType;
  String? movieUrl;
  bool? isPremium;
  bool? isDownload;
  String? downloadUrl;
  String? movieRating;
  String? quality480;
  String? quality720;
  String? quality1080;
  bool? isSubTitle;
  bool? isQuality;
  String? subTitleLanguage1;
  String? subTitleUrl1;
  String? subTitleLanguage2;
  String? subTitleUrl2;
  String? subTitleLanguage3;
  String? subTitleUrl3;
  String? movieTrailer;
  String? movieShareLink;
  String? movieContentRating;
  String? movieView;
  bool? inwatchList;
  bool? upcoming;
  final MediaContentType mediaContentType = MediaContentType.movies;

  ItemMovieModel({
    this.movieId,
    this.movieName,
    this.movieImage,
    this.moviePoster,
    this.movieDuration,
    this.movieDescription,
    this.movieDate,
    this.movieLanguage,
    this.movieType,
    this.movieUrl,
    this.isPremium,
    this.isDownload,
    this.downloadUrl,
    this.movieRating,
    this.quality480,
    this.quality720,
    this.quality1080,
    this.isSubTitle,
    this.isQuality,
    this.subTitleLanguage1,
    this.subTitleUrl1,
    this.subTitleLanguage2,
    this.subTitleUrl2,
    this.subTitleLanguage3,
    this.subTitleUrl3,
    this.movieTrailer,
    this.movieShareLink,
    this.movieContentRating,
    this.movieView,
    this.inwatchList = false,
    this.upcoming = false,
  });

  factory ItemMovieModel.fromJson(Map<String, dynamic> json) {
    return ItemMovieModel(
      movieId: json[Constants.MOVIE_ID],
      movieName: json[Constants.MOVIE_TITLE],
      movieImage: json[Constants.MOVIE_IMAGE],
      moviePoster: json[Constants.MOVIE_POSTER],
      movieDuration: json[Constants.MOVIE_DURATION],
      movieDescription: json[Constants.MOVIE_DESC],
      movieDate: json[Constants.MOVIE_DATE],
      movieLanguage: json[Constants.MOVIE_LANGUAGE],
      movieType: json[Constants.MOVIE_TYPE],
      movieUrl: json[Constants.MOVIE_URL],
      isPremium: json[Constants.MOVIE_ACCESS] == "Paid",
      isDownload: json[Constants.DOWNLOAD_ENABLE] == 'true',
      downloadUrl: json[Constants.DOWNLOAD_URL],
      movieRating: json[Constants.IMDB_RATING],
      quality480: json[Constants.QUALITY_480],
      quality720: json[Constants.QUALITY_720],
      quality1080: json[Constants.QUALITY_1080],
      isSubTitle: json[Constants.IS_SUBTITLE] == 'true',
      isQuality: json[Constants.IS_QUALITY] == 'true',
      subTitleLanguage1: json[Constants.SUBTITLE_LANGUAGE_1],
      subTitleUrl1: json[Constants.SUBTITLE_URL_1],
      subTitleLanguage2: json[Constants.SUBTITLE_LANGUAGE_2],
      subTitleUrl2: json[Constants.SUBTITLE_URL_2],
      subTitleLanguage3: json[Constants.SUBTITLE_LANGUAGE_3],
      subTitleUrl3: json[Constants.SUBTITLE_URL_3],
      movieTrailer: json[Constants.MOVIE_TRAILER_URL],
      movieShareLink: json[Constants.MOVIE_SHARE_LINK],
      movieContentRating: json[Constants.MOVIE_CONTENT_RATING],
      movieView: json[Constants.MOVIE_VIEW],
      inwatchList: json[Constants.USER_WATCHLIST_STATUS],
      upcoming: json[Constants.UPCOMING_STATUS] == "true",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Constants.MOVIE_ID: movieId,
      Constants.MOVIE_TITLE: movieName,
      Constants.MOVIE_IMAGE: movieImage,
      Constants.MOVIE_DURATION: movieDuration,
      Constants.MOVIE_DESC: movieDescription,
      Constants.MOVIE_DATE: movieDate,
      Constants.MOVIE_LANGUAGE: movieLanguage,
      Constants.MOVIE_TYPE: movieType,
      Constants.MOVIE_URL: movieUrl,
      Constants.DOWNLOAD_ENABLE: isDownload,
      Constants.DOWNLOAD_URL: downloadUrl,
      Constants.IMDB_RATING: movieRating,
      Constants.QUALITY_480: quality480,
      Constants.QUALITY_720: quality720,
      Constants.QUALITY_1080: quality1080,
      Constants.IS_SUBTITLE: isSubTitle,
      Constants.IS_QUALITY: isQuality,
      Constants.SUBTITLE_LANGUAGE_1: subTitleLanguage1,
      Constants.SUBTITLE_URL_1: subTitleUrl1,
      Constants.SUBTITLE_LANGUAGE_2: subTitleLanguage2,
      Constants.SUBTITLE_URL_2: subTitleUrl2,
      Constants.SUBTITLE_LANGUAGE_3: subTitleLanguage3,
      Constants.SUBTITLE_URL_3: subTitleUrl3,
      Constants.MOVIE_TRAILER_URL: movieTrailer,
      Constants.MOVIE_SHARE_LINK: movieShareLink,
      Constants.MOVIE_CONTENT_RATING: movieContentRating,
      Constants.MOVIE_VIEW: movieView,
    };
  }
}
