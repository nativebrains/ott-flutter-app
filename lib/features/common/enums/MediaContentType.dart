enum MediaContentType {
  movies,
  tvShows,
  sports,
  slider,
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
      case MediaContentType.slider:
        return 'Slider';
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
      case MediaContentType.liveTv:
        return 3;
      case MediaContentType.sports:
        return 4;
      case MediaContentType.slider:
        return 5;
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
      case 'livetv':
        return MediaContentType.liveTv;
      case 'slider':
        return MediaContentType.slider;
      case 'sports':
        return MediaContentType.sports;
      default:
        return null;
    }
  }
}
