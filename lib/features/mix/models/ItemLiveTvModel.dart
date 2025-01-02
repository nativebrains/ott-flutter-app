class ItemLiveTVModel {
  int? tvId;
  String? tvName;
  String? tvImage;
  String? tvDescription;
  String? tvType;
  String? tvUrl;
  String? tvUrl2;
  String? tvUrl3;
  String? tvCategory;
  bool isPremium = false;
  String? tvView;
  String? tvShareLink;

  ItemLiveTVModel({
    this.tvId,
    this.tvName,
    this.tvImage,
    this.tvDescription,
    this.tvType,
    this.tvUrl,
    this.tvUrl2,
    this.tvUrl3,
    this.tvCategory,
    this.isPremium = false,
    this.tvView,
    this.tvShareLink,
  });

  factory ItemLiveTVModel.fromJson(Map<String, dynamic> json) {
    return ItemLiveTVModel(
      tvId: json['tv_id'],
      tvName: json['tv_title'],
      tvImage: json['tv_logo'],
      tvDescription: json['tv_description'],
      tvType: json['tv_type'],
      tvUrl: json['tv_url'],
      tvUrl2: json['tv_url2'],
      tvUrl3: json['tv_url3'],
      tvCategory: json['tv_category'],
      isPremium: json['tv_access'] ?? false,
      tvView: json['tv_view'],
      tvShareLink: json['tv_share_link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tvId': tvId,
      'tvName': tvName,
      'tvImage': tvImage,
      'tvDescription': tvDescription,
      'tvType': tvType,
      'tvUrl': tvUrl,
      'tvUrl2': tvUrl2,
      'tvUrl3': tvUrl3,
      'tvCategory': tvCategory,
      'isPremium': isPremium,
      'tvView': tvView,
      'tvShareLink': tvShareLink,
    };
  }
}
