enum MediaContentType {
  movies,
  tvShows,
  sports,
  liveTv;

  String get displayName {
    switch (this) {
      case MediaContentType.movies:
        return 'Movies';
      case MediaContentType.tvShows:
        return 'TV Shows';
      case MediaContentType.sports:
        return 'Sports';
      case MediaContentType.liveTv:
        return 'Live TV';
      default:
        return '';
    }
  }
}
