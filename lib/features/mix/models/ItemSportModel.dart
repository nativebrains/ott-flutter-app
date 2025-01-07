import '../../common/enums/MediaContentType.dart';

class ItemSportModel {
  int? sportId;
  String? sportTitle;
  String? sportImage;
  String? sportDuration;
  String? sportDescription;
  String? sportDate;
  String? sportCategory;
  String? sportType;
  String? videoUrl;
  bool isPremium = false;
  bool isDownload = false;
  String? downloadUrl;
  String? videoUrl480;
  String? videoUrl720;
  String? videoUrl1080;
  bool isSubTitle = false;
  bool isQuality = false;
  String? subTitleLanguage1;
  String? subTitleUrl1;
  String? subTitleLanguage2;
  String? subTitleUrl2;
  String? subTitleLanguage3;
  String? subTitleUrl3;
  String? sportShareLink;
  String? sportView;
  bool? subtitleOnOff;
  bool? inWatchlist;
  final MediaContentType mediaContentType = MediaContentType.sports;

  ItemSportModel({
    this.sportId,
    this.sportTitle,
    this.sportImage,
    this.sportDuration,
    this.sportDescription,
    this.sportDate,
    this.sportCategory,
    this.sportType,
    this.videoUrl,
    this.isPremium = false,
    this.isDownload = false,
    this.downloadUrl,
    this.videoUrl480,
    this.videoUrl720,
    this.videoUrl1080,
    this.isSubTitle = false,
    this.isQuality = false,
    this.subTitleLanguage1,
    this.subTitleUrl1,
    this.subTitleLanguage2,
    this.subTitleUrl2,
    this.subTitleLanguage3,
    this.subTitleUrl3,
    this.sportShareLink,
    this.sportView,
    this.subtitleOnOff,
    this.inWatchlist,
  });

  factory ItemSportModel.fromJson(Map<String, dynamic> json) {
    return ItemSportModel(
      sportId: json['sport_id'],
      sportTitle: json['sport_title'],
      sportImage: json['sport_image'],
      sportDuration: json['sport_duration'],
      sportDescription: json['description'],
      sportDate: json['date'],
      sportCategory: json['category_name'],
      sportType: json['video_type'],
      videoUrl: json['video_url'],
      isPremium: json['sport_access'] == 'Paid',
      isDownload: json['download_enable'] == 'true',
      downloadUrl: json['download_url'],
      videoUrl480: json['video_url_480'],
      videoUrl720: json['video_url_720'],
      videoUrl1080: json['video_url_1080'],
      isSubTitle: json['subtitle_on_off'] == "true",
      isQuality: json['video_quality'] == "true",
      subTitleLanguage1: json['subtitle_language1'],
      subTitleUrl1: json['subtitle_url1'],
      subTitleLanguage2: json['subtitle_language2'],
      subTitleUrl2: json['subtitle_url2'],
      subTitleLanguage3: json['subtitle_language3'],
      subTitleUrl3: json['subtitle_url3'],
      sportShareLink: json['share_url'],
      sportView: json['views'],
      subtitleOnOff: json['subtitle_on_off'] == "true",
      inWatchlist: json['in_watchlist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sportId': sportId,
      'sportTitle': sportTitle,
      'sportImage': sportImage,
      'sportDuration': sportDuration,
      'sportDescription': sportDescription,
      'sportDate': sportDate,
      'sportCategory': sportCategory,
      'sportType': sportType,
      'videoUrl': videoUrl,
      'isPremium': isPremium,
      'isDownload': isDownload,
      'downloadUrl': downloadUrl,
      'videoUrl480': videoUrl480,
      'videoUrl720': videoUrl720,
      'videoUrl1080': videoUrl1080,
      'isSubTitle': isSubTitle,
      'isQuality': isQuality,
      'subTitleLanguage1': subTitleLanguage1,
      'subTitleUrl1': subTitleUrl1,
      'subTitleLanguage2': subTitleLanguage2,
      'subTitleUrl2': subTitleUrl2,
      'subTitleLanguage3': subTitleLanguage3,
      'subTitleUrl3': subTitleUrl3,
      'sportShareLink': sportShareLink,
      'sportView': sportView,
      'subtitleOnOff': subtitleOnOff,
      'inWatchlist': inWatchlist,
    };
  }
}
