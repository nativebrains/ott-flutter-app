import '../../common/enums/MediaContentType.dart';

class ItemSliderModel {
  final String? sliderTitle;
  final String? sliderType;
  final int? sliderPostId;
  final String? sliderImage;
  final String? videoAccess;
  final String? langCatName;
  final bool isPremium;
  final MediaContentType mediaContentType;

  ItemSliderModel({
    this.sliderTitle,
    this.sliderType,
    this.sliderPostId,
    this.sliderImage,
    this.videoAccess,
    this.langCatName,
    this.isPremium = false,
    this.mediaContentType = MediaContentType.sports,
  });

  factory ItemSliderModel.fromJson(Map<String, dynamic> json) {
    return ItemSliderModel(
      sliderTitle: json['slider_title'] ?? '',
      sliderType: json['slider_type'] ?? '',
      sliderPostId: json['slider_post_id'] ?? '',
      sliderImage: json['slider_image'] ?? '',
      videoAccess: json['video_access'] ?? '',
      langCatName: json['lang_cat_name'] ?? '',
      isPremium: json['video_access'] == 'Paid',
      mediaContentType: MediaContentType.getMediaTypeForSlider(
          json['slider_type'] ?? 'sports'), //  default for Sliders
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slider_title': sliderTitle,
      'slider_type': sliderType,
      'slider_post_id': sliderPostId,
      'slider_image': sliderImage,
      'video_access': videoAccess,
      'lang_cat_name': langCatName,
      'isPremium': isPremium,
    };
  }
}
