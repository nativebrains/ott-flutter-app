class PlayerUtil {
  static bool isYoutubeUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    String pattern = r"^https?:\/\/(?:www\.)?(?:youtube\.com|youtu\.be)\/.+";
    return RegExp(pattern).hasMatch(url);
  }

  static bool isVimeoUrl(String? vimeoUrl) {
    if (vimeoUrl == null || vimeoUrl.isEmpty) return false;
    String pattern = r"^https?:\/\/(?:www\.|player\.)?vimeo\.com\/.*$";
    return RegExp(pattern, caseSensitive: false).hasMatch(vimeoUrl);
  }

  static String getVideoIdFromVimeoUrl(String? videoUrl) {
    if (videoUrl == null || videoUrl.trim().length <= 0) return "";
    Uri parsedUrl = Uri.parse(videoUrl);
    List<String> pathSegments = parsedUrl.pathSegments;
    return pathSegments.last;
  }

  static String getVideoIdFromYoutubeUrl(String? videoUrl) {
    if (videoUrl == null || videoUrl.trim().length <= 0) return "";
    String reg =
        r"^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*";
    RegExp pattern = RegExp(reg, caseSensitive: false);
    RegExpMatch? match = pattern.firstMatch(videoUrl);

    if (match != null) return match.group(7) ?? "";
    return "";
  }
}
