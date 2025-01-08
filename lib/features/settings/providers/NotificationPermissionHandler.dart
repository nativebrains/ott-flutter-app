import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionHandler with ChangeNotifier {
  bool _notificationPermissionAllowed = false;
  bool _switchValue = false;

  bool get notificationPermissionAllowed => _notificationPermissionAllowed;
  bool get switchValue => _switchValue;

  /// Check Initial Permission
  Future<void> checkInitialPermission() async {
    final status = await Permission.notification.status;
    if (status.isGranted) {
      _notificationPermissionAllowed = true;
      _switchValue = true;
    } else {
      _notificationPermissionAllowed = false;
      _switchValue = false;
    }
    notifyListeners();
  }

  /// Request Permission
  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      final permissionStatus = await Permission.notification.request();
      if (permissionStatus.isGranted) {
        _notificationPermissionAllowed = true;
        _switchValue = true;
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: 'Notification permission denied. Please enable it manually.');
      }
    } else if (status.isGranted) {
      _notificationPermissionAllowed = true;
      _switchValue = true;
      notifyListeners();
    }
  }

  Future<void> updateSwitchValue(bool newValue) async {
    if (newValue) {
      // Request notification permission
      final status = await Permission.notification.request();
      if (status.isGranted) {
        _switchValue = true;
        Fluttertoast.showToast(msg: 'Notification permission granted.');
      } else {
        _switchValue = false;
        Fluttertoast.showToast(
            msg:
                'Notification permission denied. Please enable it manually in settings.');
        openAppSettings(); // Open settings for the user
      }
    } else {
      _switchValue = false;
      Fluttertoast.showToast(msg: 'Notifications disabled.');
    }
    notifyListeners();
  }
}
