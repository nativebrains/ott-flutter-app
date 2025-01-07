import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/features/details/models/ActorDetailsModel.dart';
import 'package:islamforever/features/details/providers/DetailsProvider.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/extra/rounded_network_image.dart';
import '../../common/enums/MediaContentType.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';
import '../../dashboard/widgets/CustomVerticalCard.dart';

class ActorDetailsScreenArguments {
  final String id;
  final MediaContentType mediaContentType;
  final bool isActor;
  final String title;

  ActorDetailsScreenArguments({
    required this.id,
    required this.mediaContentType,
    required this.isActor,
    required this.title,
  });
}

class ActorDetailsScreen extends StatefulWidget {
  final ActorDetailsScreenArguments actorDetailsScreenArguments;
  const ActorDetailsScreen(
      {super.key, required this.actorDetailsScreenArguments});

  @override
  State<ActorDetailsScreen> createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  late DetailsProvider detailsProvider;
  late ActorDetailsModel? actorDetailsModel;

  List<Widget> showsList = [];
  List<Widget> moviesList = [];
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
    detailsProvider = Provider.of<DetailsProvider>(context, listen: false);
    fetchActorDetailsData();
  }

  Future<void> fetchActorDetailsData() async {
    setState(() {
      _isLoading = true;
    });

    actorDetailsModel = await detailsProvider.fetchActorDetails(
      widget.actorDetailsScreenArguments.isActor,
      widget.actorDetailsScreenArguments.id,
    );
    loadItemsList();
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
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: Text(
                widget.actorDetailsScreenArguments.title,
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
            if (!_isLoading && actorDetailsModel != null) DisplayActorDetails(),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  void loadItemsList() {
    for (var item in actorDetailsModel?.shows ?? []) {
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
      }
    }

    for (var item in actorDetailsModel?.movies ?? []) {
      if (item is ItemMovieModel) {
        moviesList.add(
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Customverticalcard(
              isPremium: item.isPremium ?? false,
              url: item.moviePoster ?? "",
              id: item.movieId,
              title: item.movieName,
              mediaContentType: item.mediaContentType,
            ),
          ),
        );
      }
    }
  }

  Widget DisplayActorDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.sp,
          ),
          getActorDetails(),
          if (actorDetailsModel!.movies.isNotEmpty) getMoviesList(moviesList),
          if (actorDetailsModel!.movies.isNotEmpty) SizedBox(height: 20.sp),
          if (actorDetailsModel!.shows.isNotEmpty) getShowsList(showsList),
          if (actorDetailsModel!.shows.isNotEmpty) SizedBox(height: 20.sp),
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

  Widget getActorDetails() {
    return Container(
      width: context.screenWidth,
      margin: EdgeInsets.all(20.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left image
          RoundedNetworkImage(
            imageUrl: actorDetailsModel?.adImage ?? "",
            fit: BoxFit.cover,
            width: 115.sp,
            height: 165.sp,
          ),
          SizedBox(
            width: 20.sp,
          ),
          // Rest space with column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  actorDetailsModel?.adName ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Place of Birth: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: actorDetailsModel?.adBirthPlace ?? "",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Birthday: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: actorDetailsModel?.adBirthDate ?? "",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Bio: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: actorDetailsModel?.adBio ?? "",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
