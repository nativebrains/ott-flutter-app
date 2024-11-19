
import 'dart:io';
import 'dart:math';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {

  static Future<String?> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        const androidId = AndroidId();
        return await androidId.getId();
      } else if (Platform.isIOS) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final ios = await deviceInfo.iosInfo;
        return ios.identifierForVendor;
      }
    } catch (e) {
      return "";
    }
  }

  static Future<String?> getDeviceType() async {
    try {
      if (Platform.isAndroid) {

        return "Android";
      } else if (Platform.isIOS) {

        return "iOS";
      }
    } catch (e) {
      return "";
    }
  }

  static Future<String> getDeviceToken() async {

    const sChar = 'AaBbCcDdEeFfGgHhIi254JjKk';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        sChar.length, (_) => sChar.codeUnitAt(random.nextInt(sChar.length))));
  }
}