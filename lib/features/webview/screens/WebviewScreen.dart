import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/extras.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../settings/models/AboutAppModel.dart';
import '../../settings/providers/SettingsProvider.dart';

enum WebviewType { PRIVACY, TERMS, CONTACT_SUPPORT, CHAT_SUPPORT }

class WebviewScreen extends StatefulWidget {
  final WebviewType webviewType;

  const WebviewScreen({super.key, required this.webviewType});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController controller;

  late SettingsProvider settingsProvider;
  late AboutAppModel? aboutAppModel;
  bool _isLoading = true; // State variable to track loading

  @override
  void initState() {
    super.initState();
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    if (widget.webviewType == WebviewType.PRIVACY ||
        widget.webviewType == WebviewType.TERMS) {
      _fetchData();
    } else {
      _setupWebView();
    }
  }

  void _setupWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(getUrl()));
  }

  Future<void> _fetchData({bool refresh = false}) async {
    setState(() {
      _isLoading = true; // Indicate loading
    });

    aboutAppModel = await settingsProvider.fetchAboutData();

    setState(() {
      _isLoading = false; // Indicate loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: Stack(
        children: [
          if (widget.webviewType == WebviewType.PRIVACY ||
              widget.webviewType == WebviewType.TERMS)
            loadNormalApiData()
          else
            loadWebViewData(),

          // Loading indicator
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                color: ColorCode.greenStartColor,
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
      case WebviewType.TERMS:
        return "Terms And Conditions";
      case WebviewType.CONTACT_SUPPORT:
        return "Contact Support";
      default:
        return "";
    }
  }

  String getUrl() {
    switch (widget.webviewType) {
      case WebviewType.CONTACT_SUPPORT:
        return "https://dawateislamiott.tawk.help/";
      case WebviewType.CHAT_SUPPORT:
        return "https://tawk.to/chat/673788e82480f5b4f59eb7c5/1icoetjku";
      default:
        return "";
    }
  }

  Widget loadNormalApiData() {
    return CustomScrollView(
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
                colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            getTitle(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
          floating: true,
          snap: true,
          expandedHeight: 55.0, // Set height for expanded AppBar
        ),
        // SliverList for your content
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20.sp),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              _isLoading
                  ? []
                  : [
                      CustomText(
                        text: parse((widget.webviewType == WebviewType.PRIVACY
                                    ? aboutAppModel?.appHtmlPrivacy.toString()
                                    : aboutAppModel?.appTerms.toString() ?? '')!
                                .split('<div')
                                .first)
                            .body!
                            .text,
                        fontSize: 14.sp,
                        textAlign: TextAlign.start,
                        color: ColorCode.whiteColor,
                        maxLines: 100,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loadWebViewData() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
