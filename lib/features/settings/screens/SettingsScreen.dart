import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../webview/screens/WebviewScreen.dart';
import '../providers/NotificationPermissionHandler.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Settingsscreen extends StatefulWidget {
  const Settingsscreen({super.key});

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  late NotificationPermissionHandler _permissionHandler;

  @override
  void initState() {
    super.initState();
    _permissionHandler =
        Provider.of<NotificationPermissionHandler>(context, listen: false);
    _permissionHandler.checkInitialPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(
                height: 1.sp,
                color: Colors.grey.withOpacity(0.3),
              ),
              Consumer<NotificationPermissionHandler>(
                builder: (context, permissionHandler, child) {
                  return getItem(
                    "Enable Push Notification",
                    hasSwitch: true,
                    switchValue: permissionHandler.switchValue,
                    switchCallback: (newValue) {
                      permissionHandler.updateSwitchValue(newValue);
                    },
                  );
                },
              ),
              getItem("About", onItemClickCallback: () {
                Navigator.pushNamed(
                  context,
                  RouteConstantName.aboutScreen,
                );
              }),
              getItem("Privacy Policy", onItemClickCallback: () {
                Navigator.pushNamed(context, RouteConstantName.webviewScreen,
                    arguments:
                        const WebviewScreen(webviewType: WebviewType.PRIVACY));
              }),
              getItem("Rate App", onItemClickCallback: () async {
                await rateApp(context);
              }),
              getItem("Share App", onItemClickCallback: () async {
                await shareApp();
              }),
              getItem("More App", onItemClickCallback: () async {
                await openMoreApps();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openMoreApps() async {
    try {
      // Constructing the URL to redirect the user
      String moreAppsLink;

      if (Platform.isAndroid) {
        // Redirect to the developer's Google Play Store page
        // Replace with your developer page URL
        moreAppsLink = 'https://play.google.com/store/apps/developer?id=Paybag';
      } else if (Platform.isIOS) {
        // Redirect to the developer's App Store page
        // Replace with your developer page URL (App Store link)
        moreAppsLink = 'https://apps.apple.com/developer/Paybag';
      } else {
        // Default behavior, if it's not Android or iOS (e.g., web)
        moreAppsLink = 'https://play.google.com/store/apps/developer?id=Paybag';
      }

      // Launch the URL using url_launcher
      final Uri url = Uri.parse(moreAppsLink);

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        // If the URL cannot be launched, print an error or handle it accordingly
        print('Could not launch $moreAppsLink');
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error opening more apps page: $e');
    }
  }

  Future<void> shareApp() async {
    try {
      // Get the package name of the app
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String packageName = packageInfo.packageName;

      // Construct URLs for both platforms
      String shareMessage =
          "Hi,I would like to share Application which is used to play tv and movies free please download it from this link ";

      // For Android: Use the Google Play Store link
      final String playStoreLink =
          'https://play.google.com/store/apps/details?id=$packageName';

      // For iOS: Use the App Store link (replace 'YOUR_APP_ID' with your actual App Store ID)
      final String appStoreLink = 'https://apps.apple.com/app/idYOUR_APP_ID';

      // Platform-specific logic for sharing
      String shareContent;
      if (Platform.isAndroid) {
        shareContent = '$shareMessage$playStoreLink'; // For Android
      } else if (Platform.isIOS) {
        shareContent = '$shareMessage$appStoreLink'; // For iOS
      } else {
        shareContent =
            '$shareMessage$playStoreLink'; // Default to Android link for other platforms
      }

      // Share content using share_plus package
      await Share.share(shareContent);
    } catch (e) {
      // Handle any errors that might occur
      print('Error sharing the app: $e');
    }
  }

  Future<void> rateApp(BuildContext context) async {
    try {
      // Get the package name of the app
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String packageName = packageInfo.packageName;

      // Construct URLs
      final String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$packageName';
      final String playStoreAppUrl = 'market://details?id=$packageName';
      final String appStoreUrl =
          'https://apps.apple.com/app/idYOUR_APP_ID'; // Replace `YOUR_APP_ID` with your App Store ID

      if (Platform.isAndroid) {
        // Android-specific logic
        final Uri appUri = Uri.parse(playStoreAppUrl);
        if (await canLaunchUrl(appUri)) {
          await launchUrl(appUri);
        } else {
          final Uri webUri = Uri.parse(playStoreUrl);
          if (await canLaunchUrl(webUri)) {
            await launchUrl(webUri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Unable to open the Play Store.')),
            );
          }
        }
      } else if (Platform.isIOS) {
        // iOS-specific logic
        final Uri appUri = Uri.parse(appStoreUrl);
        if (await canLaunchUrl(appUri)) {
          await launchUrl(appUri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to open the App Store.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unsupported platform.')),
        );
      }
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Widget getItem(
    String title, {
    bool hasSwitch = false,
    bool switchValue = false,
    Function(bool)? switchCallback,
    VoidCallback? onItemClickCallback,
  }) {
    return InkWell(
      onTap: onItemClickCallback,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 6.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
                hasSwitch
                    ? Switch(
                        value: switchValue,
                        activeColor: Colors.pink,
                        onChanged: switchCallback,
                      )
                    : Container(
                        height: 54.sp,
                      ),
              ],
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
