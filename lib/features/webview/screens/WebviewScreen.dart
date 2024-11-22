import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/extras.dart';
import '../../../widgets/custom/custom_text.dart';

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
      backgroundColor: ColorCode.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // SliverAppBar with snapping and floating behavior
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                title: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                centerTitle: false,
                floating: true,
                snap: true,
                expandedHeight: 55.0, // Height for the AppBar
              ),
              // Add some placeholder slivers for content if needed
              SliverToBoxAdapter(
                child: SizedBox(height: 8.sp), // Adjust spacing if necessary
              ),
            ],
          ),
          // WebView covering the remaining space
          Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top,
            ),
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          // Loading indicator
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: ColorCode.mainColor,
              ),
            ),
        ],
      ),
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
