class ItemWatchListModel {
  int? watchListId;
  int? postId;
  String? postType;
  String? postTitle;
  String? postImage;
  int? seasonId;
  int? episodeId;

  ItemWatchListModel({
    this.watchListId,
    this.postId,
    this.postType,
    this.postTitle,
    this.postImage,
    this.seasonId,
    this.episodeId,
  });

  factory ItemWatchListModel.fromJson(Map<String, dynamic> json) {
    return ItemWatchListModel(
      watchListId: int.tryParse(json['id'].toString()),
      postId: int.tryParse(json['post_id'].toString()),
      postType: json['post_type'],
      postTitle: json['post_title'],
      postImage: json['post_image'],
      seasonId: json['season_id'] == ''
          ? null
          : int.tryParse(json['season_id'].toString()),
      episodeId: json['episode_id'] == ''
          ? null
          : int.tryParse(json['episode_id'].toString()),
    );
  }
}
