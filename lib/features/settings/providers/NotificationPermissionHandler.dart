import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPermissionHandler with ChangeNotifier {
  bool _notificationPermissionAllowed = false;
  bool _switchValue = false;

  bool get notificationPermissionAllowed => _notificationPermissionAllowed;
  bool get switchValue => _switchValue;

  NotificationPermissionHandler() {
    _loadSwitchValue();
    checkInitialPermission();
  }

  /// Load the switch value from SharedPreferences
  Future<void> _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _switchValue = prefs.getBool('notification_toggle') ?? false;
    notifyListeners();
  }

  /// Save the switch value to SharedPreferences
  Future<void> _saveSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_toggle', value);
  }

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
    _saveSwitchValue(_switchValue);
  }

  /// Update Switch Value
  Future<void> updateSwitchValue(bool newValue) async {
    if (newValue) {
      // Check if permission is already granted
      final status = await Permission.notification.status;
      if (status.isGranted) {
        _notificationPermissionAllowed = true;
        _switchValue = true;
        Fluttertoast.showToast(
            msg: 'Notification permission is already granted.');
      } else {
        // Request permission
        final permissionStatus =
            await OneSignal.Notifications.requestPermission(true);

        if (permissionStatus) {
          _notificationPermissionAllowed = true;
          _switchValue = true;
          Fluttertoast.showToast(msg: 'Notification permission granted.');
        } else {
          _notificationPermissionAllowed = false;
          _switchValue = false;
          Fluttertoast.showToast(
              msg:
                  'Notification permission denied. Please enable it manually.');
          await openAppSettings(); // Open settings for manual enabling
        }
      }
    } else {
      // Disable Notification Toggle in the App
      _switchValue = false;
      Fluttertoast.showToast(
          msg:
              'You cannot disable notifications directly. Please disable them in app settings.');
      await openAppSettings(); // Guide the user to Settings
    }

    notifyListeners();
    _saveSwitchValue(_switchValue);
  }
}
