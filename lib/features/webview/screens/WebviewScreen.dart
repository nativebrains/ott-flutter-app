import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/extras.dart';

enum WebviewType { PRIVACY }

class WebviewScreen extends StatefulWidget {
  final WebviewType webviewType;

  const WebviewScreen({super.key, required this.webviewType});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController controller;
  bool _isLoading = true; // State variable to track loading

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(getUrl()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.blackColor,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight + (isAndroid() ? 38.sp : 70.sp),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              color: ColorCode.mainColor,
            ),
          ),
      ]),
    );
  }

  String getTitle() {
    switch (widget.webviewType) {
      case WebviewType.PRIVACY:
        return "Privacy Policy";
      default:
        return "";
    }
  }

  String getUrl() {
    switch (widget.webviewType) {
      case WebviewType.PRIVACY:
        return "https://paybag-react.paybag.co/privacy-policy?app=1";
      default:
        return "";
    }
  }
}
