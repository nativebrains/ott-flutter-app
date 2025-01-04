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

  int get filterType {
    switch (this) {
      case MediaContentType.movies:
        return 1;
      case MediaContentType.tvShows:
        return 2;
      case MediaContentType.sports:
        return 4;
      case MediaContentType.liveTv:
        return 3;
      default:
        return 0;
    }
  }

  static MediaContentType? getMediaType(String type) {
    switch (type.toLowerCase()) {
      case 'movies':
        return MediaContentType.movies;
      case 'shows':
        return MediaContentType.tvShows;
      case 'sports':
        return MediaContentType.sports;
      case 'livetv':
        return MediaContentType.liveTv;
      default:
        return null;
    }
  }
}
