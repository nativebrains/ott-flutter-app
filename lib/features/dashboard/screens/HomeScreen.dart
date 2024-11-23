import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/features/dashboard/screens/SeeAllScreen.dart';
import 'package:islamforever/features/dashboard/widgets/CustomBanner.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCardList.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/routes_names.dart';
import '../widgets/CustomVerticalCardList.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<String> imgHorizontalList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2YH597lrGKw7ZeirxtHWRT4U6JyfGV0a-Vg&s',
    'https://cinema.mu/wp-content/uploads/2019/07/banner-films.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQC6EzCemijWUzMhioIQ8B-S-vMTagfJmyF0g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREa6KX__FA_L5uuNWEuhs0KPZk0lJxexuHLw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7KQecaVoxTT2wf7t7q4IqHaOcKpbRIvjayw&s',
    'https://stat5.bollywoodhungama.in/wp-content/uploads/2024/09/Bhoot-Bangla-480x270.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRFtM4Gv6GaN52iSOzxvL3mf2pZmEatAGoCQ&s',
  ];

  final List<String> imgVerticalList = [
    'https://www.joblo.com/wp-content/uploads/2024/07/1992-poster-400x600.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRazzLX_Xcj76KU7uGiS6cxJQQKUImTGfeFyg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxwd1f6S-betigYGfCxIxTwNDDaItEPoWWtg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpbkHV65Vj1zcpF3Vw5rgW5Gj_rIPgOjeHBA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8ysBfs6-bUsNs2yZefD7RylRLMxgHpCLBgg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDqGsAChd5MZTe9GBmNwIZJt_paxkajYYv8Q&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj43xv6I8Q_ePizU8zKQDRPMURnKyA4qDmEQ&s',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.sp),
            Custombanner(imgList: imgHorizontalList),
            SizedBox(height: 16.sp),
            getHorizontalList("Recently watched"),
            SizedBox(height: 16.sp),
            getVerticalList("Upcoming Movies"),
            SizedBox(height: 16.sp),
            getHorizontalList("Upcoming shows", isPremium: true),
            SizedBox(height: 16.sp),
            getVerticalList("Latest Movies", isPremium: true, hasSeeAll: true),
            SizedBox(height: 16.sp),
            getHorizontalList("Latest shows", hasSeeAll: true),
            SizedBox(height: 16.sp),
            getHorizontalList("Best in Sports", isPremium: true),
            SizedBox(height: 16.sp),
            getHorizontalList("Live TV", hasSeeAll: true),
            SizedBox(height: 16.sp),
            getVerticalList("Popular Movies", hasSeeAll: true),
            SizedBox(height: 16.sp),
            getHorizontalList("Popular shows", hasSeeAll: true),
            SizedBox(height: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget getVerticalList(String title,
      {bool hasSeeAll = false, bool isPremium = false}) {
    // Shuffle the list
    imgVerticalList.shuffle();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (hasSeeAll)
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstantName.seeAllScreen,
                    arguments: SeeAllScreenArguments(
                      title: title,
                      isVertical: true,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GradientText(
                    'See All',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900),
                    colors: [
                      Colors.orange,
                      Colors.pink,
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 6.sp,
        ),
        Customverticalcardlist(
          imgList: imgVerticalList,
          isPremium: isPremium,
        ),
      ],
    );
  }

  Widget getHorizontalList(String title,
      {bool hasSeeAll = false,
      bool isPremium = false,
      bool showItemTitle = false}) {
    // Shuffle the list
    imgVerticalList.shuffle();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (hasSeeAll)
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstantName.seeAllScreen,
                    arguments: SeeAllScreenArguments(
                      title: title,
                      isVertical: false,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GradientText(
                    'See All',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900),
                    colors: [
                      Colors.orange,
                      Colors.pink,
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 6.sp,
        ),
        Customhorizontalcardlist(
          imgList: imgHorizontalList,
          isPremium: isPremium,
          showTitle: showItemTitle,
        ),
      ],
    );
  }
}
