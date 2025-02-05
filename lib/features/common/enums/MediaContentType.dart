enum MediaContentType {
  movies,
  tvShows,
  sports,
  podcast,
  liveTv;

  String get actualValue {
    switch (this) {
      case MediaContentType.movies:
        return 'movie';
      case MediaContentType.tvShows:
        return 'tv_show';
      case MediaContentType.sports:
        return 'sport';
      case MediaContentType.liveTv:
        return 'live_tv';
      case MediaContentType.podcast:
        return 'podcast';
      default:
        return 'movie';
    }
  }

  String get displayName {
    switch (this) {
      case MediaContentType.movies:
        return 'Webseries';
      case MediaContentType.tvShows:
        return 'TV Programs';
      case MediaContentType.sports:
        return 'Browse';
      case MediaContentType.liveTv:
        return 'Live TV';
      case MediaContentType.podcast:
        return 'Podcast';
      default:
        return 'Webseries';
    }
  }

  // Donot change as they used for backend storing watchlist
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
      case MediaContentType.podcast:
        return 'Podcast';
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
      case MediaContentType.podcast:
        return 5;
      default:
        return 1;
    }
  }

  static MediaContentType getMediaType(String type) {
    switch (type.toLowerCase()) {
      case 'movies':
      case 'movie':
        return MediaContentType.movies;
      case 'shows':
      case 'tv_show':
        return MediaContentType.tvShows;
      case 'livetv':
      case 'live_tv':
        return MediaContentType.liveTv;
      case 'sports':
      case 'sport':
        return MediaContentType.sports;
      case 'podcast':
        return MediaContentType.podcast;
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
      case 'podcast':
        return MediaContentType.podcast;
      default:
        return MediaContentType.sports; // This is changed
    }
  }
}
