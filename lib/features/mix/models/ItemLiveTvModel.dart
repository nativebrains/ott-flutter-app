import '../../common/enums/MediaContentType.dart';

class ItemLiveTVModel {
  int? tvId;
  String? tvName;
  String? tvImage;
  String? description;
  String? tvUrlType;
  String? tvUrl;
  String? tvUrl2;
  String? tvUrl3;
  int? tvCatId;
  String? categoryName;
  bool isPremium = false;
  String? tvView;
  String? shareUrl;
  bool? inWatchlist;
  final MediaContentType mediaContentType = MediaContentType.liveTv;

  ItemLiveTVModel({
    this.tvId,
    this.tvName,
    this.tvImage,
    this.description,
    this.tvUrlType,
    this.tvUrl,
    this.tvUrl2,
    this.tvUrl3,
    this.tvCatId,
    this.categoryName,
    this.isPremium = false,
    this.tvView,
    this.shareUrl,
    this.inWatchlist,
  });

  factory ItemLiveTVModel.fromJson(Map<String, dynamic> json) {
    return ItemLiveTVModel(
      tvId: json['tv_id'],
      tvName: json['tv_title'],
      tvImage: json['tv_logo'],
      description: json['description'],
      tvUrlType: json['tv_url_type'],
      tvUrl: json['tv_url'],
      tvUrl2: json['tv_url2'],
      tvUrl3: json['tv_url3'],
      tvCatId: json['tv_cat_id'],
      categoryName: json['category_name'],
      isPremium: json['tv_access'] == 'Paid',
      tvView: json['views'],
      shareUrl: json['share_url'],
      inWatchlist: json['in_watchlist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tvId': tvId,
      'tvName': tvName,
      'tvImage': tvImage,
      'description': description,
      'tvUrlType': tvUrlType,
      'tvUrl': tvUrl,
      'tvUrl2': tvUrl2,
      'tvUrl3': tvUrl3,
      'tvCatId': tvCatId,
      'categoryName': categoryName,
      'isPremium': isPremium,
      'tvView': tvView,
      'shareUrl': shareUrl,
      'inWatchlist': inWatchlist,
    };
  }
}
