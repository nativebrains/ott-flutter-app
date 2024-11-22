import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../webview/screens/WebviewScreen.dart';

class Settingsscreen extends StatefulWidget {
  const Settingsscreen({super.key});

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getItem("Enable Push Notification",
                  hasSwitch: true,
                  switchValue: _switchValue, switchCallback: (newValue) {
                setState(() {
                  _switchValue = newValue;
                });
              }),
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
              getItem("Rate App", onItemClickCallback: () {}),
              getItem("Share App", onItemClickCallback: () {}),
              getItem("More App", onItemClickCallback: () {}),
            ],
          ),
        ),
      ),
    );
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
