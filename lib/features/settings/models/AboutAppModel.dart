import 'package:islamforever/constants/constants.dart';

class AboutAppModel {
  String? appName;
  bool? appUpdateHideShow;
  String? appUpdateVersionCode;
  String? appUpdateDescription;
  String? appUpdateLink;
  bool? appUpdateCancelOption;
  String? appLogo;
  String? appVersion;
  String? appAuthor;
  String? appEmail;
  String? appWebsite;
  String? appContact;
  String? appDescription;
  String? appHtmlPrivacy;
  String? appTerms;

  AboutAppModel({
    required this.appName,
    required this.appLogo,
    required this.appVersion,
    required this.appAuthor,
    required this.appEmail,
    required this.appWebsite,
    required this.appContact,
    required this.appDescription,
    required this.appHtmlPrivacy,
    required this.appTerms,
    this.appUpdateCancelOption,
    this.appUpdateDescription,
    this.appUpdateHideShow,
    this.appUpdateLink,
    this.appUpdateVersionCode,
  });

  factory AboutAppModel.fromJson(Map<String, dynamic> json) {
    return AboutAppModel(
      appName: json[Constants.APP_NAME],
      appLogo: json[Constants.APP_IMAGE],
      appVersion: json[Constants.APP_VERSION],
      appAuthor: json[Constants.APP_AUTHOR],
      appEmail: json[Constants.APP_EMAIL],
      appWebsite: json[Constants.APP_WEBSITE],
      appContact: json[Constants.APP_CONTACT],
      appDescription: json[Constants.APP_DESC],
      appHtmlPrivacy: json[Constants.APP_PRIVACY_POLICY],
      appTerms: json[Constants.APP_TERMS],
      appUpdateCancelOption: json["app_update_cancel_option"] == "true",
      appUpdateDescription: json['app_update_desc'],
      appUpdateHideShow: json['app_update_hide_show'] == "true",
      appUpdateVersionCode: json['app_update_version_code'],
      appUpdateLink: json['app_update_link'],
    );
  }
}
