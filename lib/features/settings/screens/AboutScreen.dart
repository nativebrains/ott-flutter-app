import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/assets_images.dart';
import 'package:islamforever/features/dashboard/screens/DashboardScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/custom/custom_text.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({super.key});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.blackColor,
      body: CustomScrollView(
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
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20.sp),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  customContainer(
                    Row(
                      children: [
                        Image.asset(
                          AssetImages.dawateIslamiWhiteLogo,
                          width: 50.sp,
                          height: 50.sp,
                        ),
                        SizedBox(width: 12.sp),
                        Expanded(
                          child: CustomText(
                            text: "Islam For Ever",
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
                    subtitle: '1.0.0',
                    icon: Icons.info_outline,
                  ),
                  SizedBox(height: 20.sp),
                  infoContainer(
                    title: 'Company',
                    subtitle: 'Paybag',
                    icon: Icons.person_rounded,
                  ),
                  SizedBox(height: 20.sp),
                  infoContainer(
                    title: 'Email',
                    subtitle: 'info@nativebrains.com',
                    icon: Icons.email_outlined,
                  ),
                  SizedBox(height: 20.sp),
                  infoContainer(
                    title: 'Website',
                    subtitle: 'www.nativebrains.com',
                    icon: Icons.language_outlined,
                  ),
                  SizedBox(height: 20.sp),
                  infoContainer(
                    title: 'Contact',
                    subtitle: '+92 340 2727512',
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
                        CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                          color: ColorCode.whiteColor,
                          maxLines: 100,
                          fontWeight: FontWeight.normal,
                        ),
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
