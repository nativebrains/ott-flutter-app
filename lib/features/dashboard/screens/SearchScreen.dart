import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemPodcastModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';
import 'package:provider/provider.dart';

import '../../../core/loader_widget/loader_widget.dart';
import '../providers/DashboardProvider.dart';
import '../widgets/CustomHorizontalCard.dart';
import '../widgets/CustomVerticalCard.dart';

class Searchscreen extends StatefulWidget {
  final String searchQuery;
  const Searchscreen({super.key, required this.searchQuery});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  late DashboardProvider dashboardProvider;
  List<dynamic> searchResults = [];
  List<Widget> showsList = [];
  List<Widget> moviesList = [];
  List<Widget> sportsList = [];
  List<Widget> liveTvList = [];
  List<Widget> podcastList = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    fetchData(widget.searchQuery);
  }

  Future<void> fetchData(String query) async {
    setState(() {
      _isLoading = true;
    });

    searchResults = await dashboardProvider.searchQueryAll(query);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
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
                "Search",
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
          ];
        }, // SliverList for your content
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchResults.isEmpty && !_isLoading)
                    getNoItemsFound()
                  else
                    getItemsList(),
                ],
              ),
            ),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  Widget getNoItemsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.sp,
          ),
          Icon(
            Icons.search,
            size: 80.sp,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            'No items found',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget getShowsList(List<Widget> showsList) {
    if (showsList.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.sp),
          Text(
            "Shows",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: showsList,
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

  Widget getMoviesList(List<Widget> moviesList) {
    if (moviesList.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.sp),
          Text(
            "Movies",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: moviesList,
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

  Widget getSportsList(List<Widget> sportsList) {
    if (sportsList.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.sp),
          Text(
            "Browse",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sportsList,
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

  Widget getLiveTvList(List<Widget> liveTvList) {
    if (liveTvList.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.sp),
          Text(
            "Live TV",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: liveTvList,
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

  Widget getPodcastList(List<Widget> podcastList) {
    if (podcastList.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.sp),
          Text(
            "Podcast",
            style: GoogleFonts.poppins(
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.sp),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: podcastList,
            ),
          ),
          SizedBox(height: 12.sp),
        ],
      ),
    );
  }

  Widget getItemsList() {
    for (var item in searchResults) {
      if (item is ItemShowModel) {
        showsList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customhorizontalcard(
              isPremium: item.isPremium,
              showTitle: true,
              url: item.showImage ?? "",
              id: item.showId,
              title: item.showName,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      } else if (item is ItemMovieModel) {
        moviesList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customverticalcard(
              isPremium: item.isPremium ?? false,
              url: item.movieImage ?? "",
              id: item.movieId,
              title: item.movieName,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      } else if (item is ItemSportModel) {
        sportsList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customhorizontalcard(
              isPremium: item.isPremium,
              showTitle: true,
              url: item.sportImage ?? "",
              id: item.sportId,
              title: item.sportTitle,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      } else if (item is ItemLiveTVModel) {
        liveTvList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customhorizontalcard(
              isPremium: item.isPremium,
              showTitle: true,
              url: item.tvImage ?? "",
              id: item.tvId,
              title: item.tvName,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      } else if (item is ItemPodcastModel) {
        podcastList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customverticalcard(
              isPremium: item.isPremium ?? false,
              url: item.audioPoster ?? "",
              id: item.audioId,
              title: item.audioTitle,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getShowsList(showsList),
        getMoviesList(moviesList),
        getSportsList(sportsList),
        getLiveTvList(liveTvList),
        getPodcastList(podcastList),
      ],
    );
  }
}
