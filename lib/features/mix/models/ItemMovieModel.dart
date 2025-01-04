import '../../common/enums/MediaContentType.dart';

class ItemMovieModel {
  int? movieId;
  String? movieName;
  String? movieImage;
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
  final MediaContentType mediaContentType = MediaContentType.movies;

  ItemMovieModel({
    this.movieId,
    this.movieName,
    this.movieImage,
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
  });

  factory ItemMovieModel.fromJson(Map<String, dynamic> json) {
    return ItemMovieModel(
      movieId: json['movie_id'],
      movieName: json['movie_name'],
      movieImage: json['movie_image'],
      movieDuration: json['movie_duration'],
      movieDescription: json['movie_description'],
      movieDate: json['movie_date'],
      movieLanguage: json['movie_language'],
      movieType: json['movie_type'],
      movieUrl: json['movie_url'],
      isPremium: json['is_premium'],
      isDownload: json['is_download'],
      downloadUrl: json['download_url'],
      movieRating: json['movie_rating'],
      quality480: json['quality_480'],
      quality720: json['quality_720'],
      quality1080: json['quality_1080'],
      isSubTitle: json['is_sub_title'],
      isQuality: json['is_quality'],
      subTitleLanguage1: json['sub_title_language1'],
      subTitleUrl1: json['sub_title_url1'],
      subTitleLanguage2: json['sub_title_language2'],
      subTitleUrl2: json['sub_title_url2'],
      subTitleLanguage3: json['sub_title_language3'],
      subTitleUrl3: json['sub_title_url3'],
      movieTrailer: json['movie_trailer'],
      movieShareLink: json['movie_share_link'],
      movieContentRating: json['movie_content_rating'],
      movieView: json['movie_view'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieId,
      'movie_name': movieName,
      'movie_image': movieImage,
      'movie_duration': movieDuration,
      'movie_description': movieDescription,
      'movie_date': movieDate,
      'movie_language': movieLanguage,
      'movie_type': movieType,
      'movie_url': movieUrl,
      'is_premium': isPremium,
      'is_download': isDownload,
      'download_url': downloadUrl,
      'movie_rating': movieRating,
      'quality_480': quality480,
      'quality_720': quality720,
      'quality_1080': quality1080,
      'is_sub_title': isSubTitle,
      'is_quality': isQuality,
      'sub_title_language1': subTitleLanguage1,
      'sub_title_url1': subTitleUrl1,
      'sub_title_language2': subTitleLanguage2,
      'sub_title_url2': subTitleUrl2,
      'sub_title_language3': subTitleLanguage3,
      'sub_title_url3': subTitleUrl3,
      'movie_trailer': movieTrailer,
      'movie_share_link': movieShareLink,
      'movie_content_rating': movieContentRating,
      'movie_view': movieView,
    };
  }
}
