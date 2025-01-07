enum MediaContentType {
  movies,
  tvShows,
  sports,
  liveTv,
  ;

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
        return 'Movies';
    }
  }

  String get shortDisplayName {
    switch (this) {
      case MediaContentType.movies:
        return 'Movies';
      case MediaContentType.tvShows:
        return 'Shows'; // this is changed
      case MediaContentType.sports:
        return 'Sports';
      case MediaContentType.liveTv:
        return 'LiveTV';
      default:
        return 'Movies';
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
      default:
        return 1;
    }
  }

  static MediaContentType getMediaType(String type) {
    switch (type.toLowerCase()) {
      case 'movies':
        return MediaContentType.movies;
      case 'shows':
        return MediaContentType.tvShows;
      case 'livetv':
        return MediaContentType.liveTv;
      case 'sports':
        return MediaContentType.sports;
      default:
        return MediaContentType.movies;
    }
  }

  static MediaContentType getMediaTypeForSlider(String type) {
    switch (type.toLowerCase()) {
      case 'movies':
      case 'movie':
        return MediaContentType.movies;
      case 'shows':
        return MediaContentType.tvShows;
      case 'livetv':
        return MediaContentType.liveTv;
      case 'sports':
      case 'sport':
        return MediaContentType.sports;
      default:
        return MediaContentType.sports; // This is changed
    }
  }
}
