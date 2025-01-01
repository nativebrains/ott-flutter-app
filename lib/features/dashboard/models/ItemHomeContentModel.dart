class ItemHomeContentModel {
  int? videoId;
  String? videoType;
  String? homeType;
  String? videoTitle;
  bool isPremium = false;
  String? videoImage;
  String? seasonId;
  String? episodeId;

  ItemHomeContentModel({
    this.videoId,
    this.videoType,
    this.homeType,
    this.videoTitle,
    this.isPremium = false,
    this.videoImage,
    this.seasonId,
    this.episodeId,
  });

  factory ItemHomeContentModel.fromJson(Map<String, dynamic> json) {
    return ItemHomeContentModel(
      videoId: json.containsKey('video_id') ? json['video_id'] : null,
      videoType: json.containsKey('video_type') ? json['video_type'] : null,
      seasonId: json.containsKey('season_id') ? json['season_id'] : null,
      episodeId: json.containsKey('episode_id') ? json['episode_id'] : null,
      videoImage: json.containsKey('video_thumb_image')
          ? json['video_thumb_image']
          : null,
      homeType: json.containsKey('home_type') ? json['home_type'] : "Recent",
      videoTitle: json.containsKey('video_title') ? json['video_title'] : null,
      isPremium:
          json.containsKey('is_premium') ? (json['is_premium'] as bool) : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'video_type': videoType,
      'home_type': homeType,
      'video_title': videoTitle,
      'is_premium': isPremium,
      'video_image': videoImage,
      'season_id': seasonId,
      'episode_id': episodeId,
    };
  }
}
