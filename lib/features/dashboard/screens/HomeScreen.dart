import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/dashboard/widgets/CustomBanner.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';

import '../widgets/CustomVerticalCard.dart';

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
            SizedBox(
              height: 16.sp,
            ),
            Custombanner(
              imgList: imgHorizontalList,
            ),
            SizedBox(
              height: 16.sp,
            ),
            Customverticalcard(
              imgList: imgVerticalList,
              isPremium: true,
            ),
            SizedBox(
              height: 16.sp,
            ),
            Customhorizontalcard(
              imgList: imgHorizontalList,
              isPremium: false,
            ),
          ],
        ),
      ),
    );
  }
}
