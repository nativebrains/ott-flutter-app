import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  static Future<XFile> checkAndCompressImage({
    required File imageFile,
    int quality = 50,
    CompressFormat format = CompressFormat.png,
  }) async {
    // Check if image is already less than 5 MB
    int originalSize = File(imageFile.path).lengthSync();
    if (originalSize <= 5 * 1024 * 1024) {
      return XFile(imageFile.path);
    }

    final String targetPath =
        p.join(Directory.systemTemp.path, 'temp.${format.name}');
    XFile? compressedImage;

    while (true) {
      compressedImage = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        targetPath,
        quality: quality,
        format: format,
      );

      if (compressedImage == null) {
        throw ("Failed to compress the image");
      }

      int compressedSize = File(compressedImage.path).lengthSync();
      if (compressedSize <= 5 * 1024 * 1024) {
        break;
      }

      // Decrease quality and try again
      quality -= 10;
      if (quality < 10) {
        break;
      }
    }

    return compressedImage;
  }
}

class PermissionUtil {
  static List<Permission> androidPermissions = <Permission>[
    Permission.storage,
    Permission.camera,
    Permission.notification,
    Permission.microphone,
  ];

  /// ios
  static List<Permission> iosPermissions = <Permission>[
    Permission.storage,
    Permission.camera,
    Permission.notification,
    Permission.microphone,
  ];

  static Future<Map<Permission, PermissionStatus>> requestAll() async {
    if (Platform.isIOS) {
      return await iosPermissions.request();
    }
    return await androidPermissions.request();
  }

  static Future<Map<Permission, PermissionStatus>> request(
      Permission permission) async {
    final List<Permission> permissions = <Permission>[permission];
    return await permissions.request();
  }

  static bool isDenied(Map<Permission, PermissionStatus> result) {
    var isDenied = false;
    result.forEach((key, value) {
      if (value == PermissionStatus.denied) {
        isDenied = true;
        return;
      }
    });
    return isDenied;
  }

  static Future<bool> checkGranted(Permission permission) async {
    PermissionStatus storageStatus = await permission.status;
    if (storageStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
