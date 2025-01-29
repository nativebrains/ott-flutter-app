import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart';
import 'package:islamforever/constants/assets_images.dart';
import 'package:islamforever/features/dashboard/screens/DashboardScreen.dart';
import 'package:islamforever/features/settings/models/AboutAppModel.dart';
import 'package:islamforever/features/settings/providers/SettingsProvider.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_text.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({super.key});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  late SettingsProvider settingsProvider;
  late AboutAppModel? aboutAppModel;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _fetchData();
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
                      colors: [
                        ColorCode.greenStartColor,
                        ColorCode.greenEndColor
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                title: Text(
                  "About",
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
                padding:
                    EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20.sp),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    _isLoading
                        ? []
                        : [
                            customContainer(
                              Row(
                                children: [
                                  Image.network(
                                    aboutAppModel?.appLogo ?? "",
                                    fit: BoxFit.cover,
                                    width: 50.sp,
                                    height: 50.sp,
                                  ),
                                  SizedBox(width: 12.sp),
                                  Expanded(
                                    child: CustomText(
                                      text: aboutAppModel?.appName ?? "",
                                      fontSize: 24.sp,
                                      textAlign: TextAlign.start,
                                      color: ColorCode.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.sp),
                            infoContainer(
                              title: 'Version',
                              subtitle: aboutAppModel?.appVersion ?? "",
                              icon: Icons.info_outline,
                            ),
                            SizedBox(height: 20.sp),
                            infoContainer(
                              title: 'Company',
                              subtitle: aboutAppModel?.appAuthor ?? "",
                              icon: Icons.person_rounded,
                            ),
                            SizedBox(height: 20.sp),
                            infoContainer(
                              title: 'Email',
                              subtitle: aboutAppModel?.appEmail ?? "",
                              icon: Icons.email_outlined,
                            ),
                            SizedBox(height: 20.sp),
                            infoContainer(
                              title: 'Website',
                              subtitle: aboutAppModel?.appWebsite ?? "",
                              icon: Icons.language_outlined,
                            ),
                            SizedBox(height: 20.sp),
                            infoContainer(
                              title: 'Contact',
                              subtitle: aboutAppModel?.appContact ?? "",
                              icon: Icons.call_outlined,
                            ),
                            SizedBox(height: 20.sp),
                            customContainer(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "About",
                                    fontSize: 20.sp,
                                    textAlign: TextAlign.start,
                                    color: ColorCode.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 12.sp),
                                  HtmlWidget(
                                    aboutAppModel?.appDescription ?? '',
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: ColorCode.whiteColor,
                                    ),
                                    onTapUrl: (url) async {
                                      Uri uri = Uri.parse(url);
                                      if (uri.scheme.isEmpty) {
                                        uri = Uri.parse('https://$url');
                                      }

                                      if (uri.scheme == 'mailto') {
                                        final Uri mailUri = Uri(
                                          scheme: 'mailto',
                                          path: uri.path,
                                          queryParameters: {
                                            'subject': 'Support Inquiry'
                                          }, // Optional
                                        );

                                        if (await canLaunchUrl(mailUri)) {
                                          await launchUrl(mailUri);
                                        } else {
                                          print("Could not launch $mailUri");
                                        }
                                      } else if (uri.scheme == 'tel') {
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        } else {
                                          print("Could not launch $uri");
                                        }
                                      } else {
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        } else {
                                          print("Could not launch $uri");
                                        }
                                      }
                                      return true;
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 50.sp),
                          ],
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading) const LoaderWidget(),
        ],
      ),
    );
  }

  Widget customContainer(Widget child) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget infoContainer({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return customContainer(
      Row(
        children: [
          Icon(
            icon,
            size: 40.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 50.sp,
            child: VerticalDivider(
              color: Colors.grey.withOpacity(0.5),
              thickness: 1.sp,
            ),
          ),
          SizedBox(width: 8.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 18.sp,
                  textAlign: TextAlign.start,
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: subtitle,
                  fontSize: 14.sp,
                  textAlign: TextAlign.start,
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
