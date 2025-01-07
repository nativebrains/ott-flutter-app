import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareUtils {
  static void shareFacebook(
      BuildContext context, String text, String url) async {
    final facebookAppUrl = 'fb://facewebmodal/f?href=$url';
    final facebookWebUrl =
        'https://www.facebook.com/sharer/sharer.php?u=$url&t=$text';

    try {
      bool facebookAppFound = await canLaunch(facebookAppUrl);
      if (facebookAppFound) {
        await launch(facebookAppUrl);
      } else {
        await launch(facebookWebUrl);
      }
    } catch (e) {
      await launch(facebookWebUrl);
    }
  }

  static void shareTwitter(BuildContext context, String text, String url,
      String via, String hashtags) async {
    final tweetUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text.isEmpty ? ' ' : text)}&url=${Uri.encodeComponent(url)}${via.isEmpty ? '' : '&via=${Uri.encodeComponent(via)}'}${hashtags.isEmpty ? '' : '&hashtags=${Uri.encodeComponent(hashtags.replaceFirst('#', ''))}'}';

    try {
      bool twitterAppFound = await canLaunch('twitter://');
      if (twitterAppFound) {
        await launch(tweetUrl, forceSafariVC: false);
      } else {
        await launch(tweetUrl);
      }
    } catch (e) {
      await launch(tweetUrl);
    }
  }

  static void shareWhatsapp(
      BuildContext context, String text, String url) async {
    final whatsappUrl =
        'https://wa.me/?text=${Uri.encodeComponent('$text $url')}';

    try {
      bool whatsappAppFound = await canLaunch('whatsapp://');
      if (whatsappAppFound) {
        await launch(whatsappUrl);
      } else {
        await launch(whatsappUrl);
      }
    } catch (e) {
      await launch(whatsappUrl);
    }
  }

  static String urlEncode(String s) {
    return Uri.encodeComponent(s);
  }
}
