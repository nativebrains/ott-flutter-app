class ItemSeasonModel {
  int? seasonId;
  String? seasonName;
  String? seasonTrailer;
  String? seasonPoster;

  ItemSeasonModel({
    this.seasonId,
    this.seasonName,
    this.seasonTrailer,
    this.seasonPoster,
  });

  factory ItemSeasonModel.fromJson(Map<String, dynamic> json) {
    return ItemSeasonModel(
      seasonId: json['season_id'],
      seasonName: json['season_name'],
      seasonTrailer: json['trailer_url'],
      seasonPoster: json['season_poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seasonId': seasonId,
      'seasonName': seasonName,
      'seasonTrailer': seasonTrailer,
      'seasonPoster': seasonPoster,
    };
  }
}
