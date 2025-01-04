class ItemShowModel {
  int? showId;
  String? showName;
  String? showImage;
  String? showDescription;
  String? showLanguage;
  String? showRating;
  String? showContentRating;
  bool isPremium = false;

  ItemShowModel({
    this.showId,
    this.showName,
    this.showImage,
    this.showDescription,
    this.showLanguage,
    this.showRating,
    this.showContentRating,
    this.isPremium = false,
  });

  factory ItemShowModel.fromJson(Map<String, dynamic> json) {
    return ItemShowModel(
      showId: json['show_id'],
      showName: json['show_name'],
      showImage: json['show_poster'],
      showDescription: json['showDescription'],
      showLanguage: json['showLanguage'],
      showRating: json['showRating'],
      showContentRating: json['showContentRating'],
      isPremium: json['show_access'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'showName': showName,
      'showImage': showImage,
      'showDescription': showDescription,
      'showLanguage': showLanguage,
      'showRating': showRating,
      'showContentRating': showContentRating,
      'isPremium': isPremium,
    };
  }
}
