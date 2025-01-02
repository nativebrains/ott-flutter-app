class ItemSportModel {
  int? sportId;
  String? sportName;
  String? sportImage;
  String? sportDuration;
  String? sportDescription;
  String? sportDate;
  String? sportCategory;
  String? sportType;
  String? sportUrl;
  bool isPremium = false;
  bool isDownload = false;
  String? downloadUrl;
  String? quality480;
  String? quality720;
  String? quality1080;
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

  ItemSportModel({
    this.sportId,
    this.sportName,
    this.sportImage,
    this.sportDuration,
    this.sportDescription,
    this.sportDate,
    this.sportCategory,
    this.sportType,
    this.sportUrl,
    this.isPremium = false,
    this.isDownload = false,
    this.downloadUrl,
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
    this.sportShareLink,
    this.sportView,
  });

  factory ItemSportModel.fromJson(Map<String, dynamic> json) {
    return ItemSportModel(
      sportId: json['sport_id'],
      sportName: json['sport_title'],
      sportImage: json['sport_image'],
      sportDuration: json['sport_duration'],
      sportDescription: json['sport_description'],
      sportDate: json['sport_date'],
      sportCategory: json['sport_category'],
      sportType: json['sport_type'],
      sportUrl: json['sport_url'],
      isPremium: json['sport_access'] ?? false,
      isDownload: json['is_download'] ?? false,
      downloadUrl: json['download_url'],
      quality480: json['quality_480'],
      quality720: json['quality_720'],
      quality1080: json['quality_1080'],
      isSubTitle: json['is_sub_title'] ?? false,
      isQuality: json['is_quality'] ?? false,
      subTitleLanguage1: json['sub_title_language1'],
      subTitleUrl1: json['sub_title_url1'],
      subTitleLanguage2: json['sub_title_language2'],
      subTitleUrl2: json['sub_title_url2'],
      subTitleLanguage3: json['sub_title_language3'],
      subTitleUrl3: json['sub_title_url3'],
      sportShareLink: json['sport_share_link'],
      sportView: json['sport_view'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sportId': sportId,
      'sportName': sportName,
      'sportImage': sportImage,
      'sportDuration': sportDuration,
      'sportDescription': sportDescription,
      'sportDate': sportDate,
      'sportCategory': sportCategory,
      'sportType': sportType,
      'sportUrl': sportUrl,
      'isPremium': isPremium,
      'isDownload': isDownload,
      'downloadUrl': downloadUrl,
      'quality480': quality480,
      'quality720': quality720,
      'quality1080': quality1080,
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
    };
  }
}
