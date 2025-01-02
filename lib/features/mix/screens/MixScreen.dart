import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';
import '../../dashboard/widgets/CustomVerticalCard.dart';

class Mixscreen extends StatefulWidget {
  const Mixscreen({super.key});

  @override
  State<Mixscreen> createState() => _MixscreenState();
}

class _MixscreenState extends State<Mixscreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      var isMovieCase = DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.movies;

      List<dynamic> itemsList = []; // Initialize an empty list

      if (DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.movies) {
        itemsList = provider.itemsMixMoviesList;
      } else if (DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.tvShows) {
        itemsList = provider.itemsMixShowsList;
      } else if (DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.sports) {
        itemsList = provider.itemsMixSportList;
      } else if (DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.liveTv) {
        itemsList = provider.itemsMixLiveTvList;
      }

      return Scaffold(
        backgroundColor: ColorCode.bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                ),
                child: Column(
                  children: [
                    if (itemsList.isEmpty && !provider.isMixScreenLoading)
                      getEmpty()
                    else
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isMovieCase ? 3 : 2,
                        childAspectRatio: isMovieCase ? 0.65 : 1.4,
                        children: [
                          // Movies Section
                          if (DashboardProvider.selectedMixScreenContentType ==
                              MediaContentType.movies)
                            ...(itemsList as List<ItemMovieModel>).map((item) {
                              return Customverticalcard(
                                  isPremium: item.isPremium ?? false,
                                  url: item.movieImage ?? "");
                            }),

                          // Tv Shows Section
                          if (DashboardProvider.selectedMixScreenContentType ==
                              MediaContentType.tvShows)
                            ...(itemsList as List<ItemShowModel>).map((item) {
                              return Customhorizontalcard(
                                  isPremium: item.isPremium,
                                  showTitle: true,
                                  url: item.showImage ?? "");
                            }),
                          // Sports Section
                          if (DashboardProvider.selectedMixScreenContentType ==
                              MediaContentType.sports)
                            ...(itemsList as List<ItemSportModel>).map((item) {
                              return Customhorizontalcard(
                                  isPremium: item.isPremium,
                                  showTitle: true,
                                  url: item.sportImage ?? "");
                            }),

                          // Live Tv Section
                          if (DashboardProvider.selectedMixScreenContentType ==
                              MediaContentType.liveTv)
                            ...(itemsList as List<ItemLiveTVModel>).map((item) {
                              return Customhorizontalcard(
                                  isPremium: item.isPremium,
                                  showTitle: true,
                                  url: item.tvImage ?? "");
                            }),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (provider
                .isMixScreenLoading) // Show LoaderWidget if _isLoading is true
              const LoaderWidget(),
          ],
        ),
      );
    });
  }

  Widget getEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 250.sp),
          const Icon(
            Icons.search,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 12),
          Text(
            "No Items Found!",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
