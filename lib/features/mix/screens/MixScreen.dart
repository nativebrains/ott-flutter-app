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

      List<dynamic> itemsList = _getItemsList(provider);

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
                      _buildGridView(itemsList, isMovieCase),
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

  List<dynamic> _getItemsList(DashboardProvider provider) {
    switch (DashboardProvider.selectedMixScreenContentType) {
      case MediaContentType.movies:
        return provider.itemsMixMoviesList;
      case MediaContentType.tvShows:
        return provider.itemsMixShowsList;
      case MediaContentType.sports:
        return provider.itemsMixSportList;
      case MediaContentType.liveTv:
        return provider.itemsMixLiveTvList;
      default:
        return [];
    }
  }

  Widget _buildGridView(List<dynamic> itemsList, bool isMovieCase) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMovieCase ? 3 : 2,
      childAspectRatio: isMovieCase ? 0.65 : 1.4,
      children: _mapItemsToWidgets(itemsList),
    );
  }

  List<Widget> _mapItemsToWidgets(List<dynamic> itemsList) {
    return itemsList.map((item) {
      if (item is ItemMovieModel) {
        return Customverticalcard(
          isPremium: item.isPremium ?? false,
          url: item.movieImage ?? "",
        );
      } else if (item is ItemShowModel) {
        return Customhorizontalcard(
          isPremium: item.isPremium,
          showTitle: true,
          url: item.showImage ?? "",
        );
      } else if (item is ItemSportModel) {
        return Customhorizontalcard(
          isPremium: item.isPremium,
          showTitle: true,
          url: item.sportImage ?? "",
        );
      } else if (item is ItemLiveTVModel) {
        return Customhorizontalcard(
          isPremium: item.isPremium,
          showTitle: true,
          url: item.tvImage ?? "",
        );
      } else {
        return Container();
      }
    }).toList();
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
