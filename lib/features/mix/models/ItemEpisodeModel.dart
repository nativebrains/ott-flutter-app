import '../../../constants/constants.dart';

class ItemEpisodeModel {
  int? episodeId;
  String? episodeName;
  String? episodeUrl;
  String? episodeType;
  String? episodeImage;
  bool? isPremium;
  bool? isDownload;
  String? downloadUrl;
  String? episodeDate;
  String? episodeDuration;
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
  String? episodeDescription;
  String? episodeShareLink;
  String? episodeView;
  bool? isWatchList;
  String? episodeRating;

  ItemEpisodeModel({
    this.episodeId,
    this.episodeName,
    this.episodeUrl,
    this.episodeType,
    this.episodeImage,
    this.isPremium = false,
    this.isDownload = false,
    this.downloadUrl,
    this.episodeDate,
    this.episodeDuration,
    this.quality480,
    this.quality720,
    this.quality1080,
    this.isSubTitle = false,
    this.isQuality = false,
    this.subTitleLanguage1,
    this.subTitleUrl1,
    this.subTitleLanguage2,
    this.subTitleUrl2,
    this.subTitleLanguage3,
    this.subTitleUrl3,
    this.episodeDescription,
    this.episodeShareLink,
    this.episodeView,
    this.isWatchList = false,
    this.episodeRating,
  });

  factory ItemEpisodeModel.fromJson(Map<String, dynamic> json) {
    return ItemEpisodeModel(
      episodeId: json[Constants.EPISODE_ID],
      episodeName: json[Constants.EPISODE_TITLE],
      episodeUrl: json[Constants.EPISODE_URL],
      episodeType: json[Constants.EPISODE_TYPE],
      episodeImage: json[Constants.EPISODE_IMAGE],
      isPremium: json[Constants.EPISODE_ACCESS] == 'Paid',
      isDownload: json[Constants.DOWNLOAD_ENABLE] == 'true',
      downloadUrl: json[Constants.DOWNLOAD_URL],
      episodeDate: json[Constants.EPISODE_DATE],
      episodeDuration: json[Constants.EPISODE_DURATION],
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
      episodeDescription: json[Constants.EPISODE_DESC],
      episodeShareLink: json[Constants.MOVIE_SHARE_LINK],
      episodeView: json[Constants.MOVIE_VIEW],
      isWatchList: json[Constants.USER_WATCHLIST_STATUS],
      episodeRating: json[Constants.IMDB_RATING],
    );
  }
}
