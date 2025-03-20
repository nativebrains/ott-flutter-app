import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class NotificationPermissionHandler with ChangeNotifier {
  bool _notificationPermissionAllowed = false;
  bool _switchValue = false;

  bool get notificationPermissionAllowed => _notificationPermissionAllowed;
  bool get switchValue => _switchValue;

  NotificationPermissionHandler() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadSwitchValue();
    await checkInitialPermission();
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
    final oneSignalStatus = OneSignal.User.pushSubscription.optedIn ?? false;
    print('OneSignal Status: $oneSignalStatus');
    print('Permission Status: $status');

    if (status.isGranted && oneSignalStatus) {
      _notificationPermissionAllowed = true;
      _switchValue = true;
    } else if (status.isDenied ||
        status.isPermanentlyDenied ||
        oneSignalStatus == false) {
      _notificationPermissionAllowed = false;
      _switchValue = false;
    }

    await _saveSwitchValue(_switchValue);
    notifyListeners();
  }

  Future<void> updateSwitchValue(bool newValue) async {
    try {
      if (newValue) {
        final status = await Permission.notification.status;
        OneSignal.User.pushSubscription.optIn();
        if (status.isGranted) {
          _notificationPermissionAllowed = true;
          _switchValue = true;
          _showToast('Notification permission granted.');
        } else {
          if (Platform.isIOS && status.isPermanentlyDenied) {
            _notificationPermissionAllowed = false;
            _switchValue = false;
            _showToast('Please enable notifications manually in settings.');
            // Delay ensures UI updates before opening settings
            await Future.delayed(const Duration(milliseconds: 500));
            bool opened = await openAppSettings();
            if (!opened) _showToast('Failed to open settings.');
          } else {
            final permissionStatus = await Permission.notification.request();

            if (permissionStatus.isGranted) {
              _notificationPermissionAllowed = true;
              _switchValue = true;
              _showToast('Notification permission granted.');
            } else {
              _notificationPermissionAllowed = false;
              _switchValue = false;
              _showToast('Permission denied. Enable it manually in settings.');
              await Future.delayed(const Duration(milliseconds: 500));
              bool opened = await openAppSettings();
              if (!opened) _showToast('Failed to open settings.');
            }
          }
        }
      } else {
        _switchValue = false;
        // _showToast('To disable notifications, change the settings manually.');
        // // Delay ensures the UI updates before opening settings
        // await Future.delayed(Duration(milliseconds: 500));
        // bool opened = await openAppSettings();
        // if (!opened) _showToast('Failed to open settings.');
        await OneSignal.User.pushSubscription.optOut();
        _showToast('Notification permission disabled.');
      }

      notifyListeners();
      await _saveSwitchValue(_switchValue);
    } catch (e) {
      _showToast('An error occurred. Please try again.');
      debugPrint('Error updating switch value: $e');
    }
  }

  /// Helper method to show toast messages
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
