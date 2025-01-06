import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/core/loader_widget/loader_widget.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';
import 'package:islamforever/features/dashboard/widgets/CustomVerticalCard.dart';
import 'package:islamforever/features/details/models/ActorModel.dart';
import 'package:islamforever/features/details/models/GenericDetailsResponseModel.dart';
import 'package:islamforever/features/details/models/MediaItemDetails.dart';
import 'package:islamforever/features/details/providers/DetailsProvider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../widgets/custom/custom_text.dart';

class DetailsScreenArguments {
  final String id;
  final MediaContentType mediaContentType;
  final String? seasonId;
  final String? episodeId;
  final bool? episodeRedirect;

  DetailsScreenArguments(
      {required this.id,
      required this.mediaContentType,
      this.seasonId,
      this.episodeId,
      this.episodeRedirect});
}

class Detailsscreen extends StatefulWidget {
  final DetailsScreenArguments detailsScreenArguments;
  const Detailsscreen({super.key, required this.detailsScreenArguments});

  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  late DetailsProvider detailsProvider;
  int _selectedSeasonIndex = 0;
  late GenericDetailsResponseModel? genericDetailsResponseModel;
  late MediaItemDetails? mediaItemDetails;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    detailsProvider = Provider.of<DetailsProvider>(context, listen: false);
    print("Details Items ID = " + widget.detailsScreenArguments.id);
    print("Details Items Type = " +
        widget.detailsScreenArguments.mediaContentType.displayName);

    fetchDetailsData();
  }

  void fetchDetailsData() async {
    setState(() {
      _isLoading = true;
    });
    switch (widget.detailsScreenArguments.mediaContentType) {
      case MediaContentType.movies:
        genericDetailsResponseModel = await detailsProvider
            .fetchMovieDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        break;
      case MediaContentType.tvShows:
        break;
      case MediaContentType.sports:
        break;
      case MediaContentType.liveTv:
        break;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            if (!_isLoading)
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTopSection(),
                    SizedBox(height: 8.sp),
                    getDescriptionSection(),
                    SizedBox(height: 8.sp),
                    Divider(height: 1.sp, color: Colors.grey.withOpacity(0.3)),
                    if (mediaItemDetails?.mediaContentType !=
                        MediaContentType.movies)
                      SizedBox(height: 16.sp),
                    if (mediaItemDetails?.mediaContentType !=
                        MediaContentType.movies)
                      getSeasons(),
                    if (mediaItemDetails?.mediaContentType !=
                        MediaContentType.movies)
                      SizedBox(height: 24.sp),
                    if (mediaItemDetails?.mediaContentType !=
                        MediaContentType.movies)
                      getEpisodes(),
                    SizedBox(height: 24.sp),
                    getActors(),
                    SizedBox(height: 24.sp),
                    getDirectors(),
                    SizedBox(height: 24.sp),
                    getRelatedMovies(),
                    SizedBox(height: 30.sp),
                  ],
                ),
              ),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  Widget getTopSection() {
    return SizedBox(
      height: 240.sp,
      child: Stack(
        children: [
          // Background image
          Image.network(
            mediaItemDetails?.image ?? "",
            fit: BoxFit.cover,
            width: double.infinity, // Set the width to infinity
            height: 235.sp,
          ),

          // Gradient overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 150.sp,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Back icon
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          // Play button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: AvatarGlow(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.pink,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.sp),
                      child: Icon(
                        Icons.play_arrow,
                        size: 45.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: CustomText(
            text: mediaItemDetails?.title ?? "",
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: ColorCode.cardInfoHeader,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: GradientText(
            'IMDB ${mediaItemDetails?.rating ?? "0.0"}',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
            colors: [
              Colors.orange,
              Colors.pink,
            ],
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomText(
                    text: mediaItemDetails?.releaseDate ?? "",
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              if (mediaItemDetails?.duration != null ||
                  mediaItemDetails?.duration != "null")
                buildDotItem(0, mediaItemDetails?.duration ?? "0"),
              if (mediaItemDetails?.contentRating != null ||
                  mediaItemDetails?.contentRating != "null")
                buildDotItem(1,
                    "Content Rating ${mediaItemDetails?.contentRating ?? ""}"),
              if (mediaItemDetails?.views != null ||
                  mediaItemDetails?.views != "null")
                buildDotItem(2, "Views ${mediaItemDetails?.views ?? ""}"),
              if (mediaItemDetails?.language != null ||
                  mediaItemDetails?.language != "null")
                buildDotItem(3, mediaItemDetails?.language ?? ""),
              if (genericDetailsResponseModel?.genres != null)
                ...List.generate(
                    genericDetailsResponseModel!.genres!.length,
                    (index) => buildDotItem(index,
                        genericDetailsResponseModel!.genres![index].genreName)),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(width: 16),
            CustomText(
              text: 'Share :',
              fontSize: 14.sp,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.facebook),
              iconSize: 20.sp,
              color: Colors.blue,
              onPressed: () {
                // Handle Facebook button press
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.twitter),
              color: Colors.blue,
              iconSize: 20.sp,
              onPressed: () {
                // Handle Twitter button press
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.whatsapp),
              color: Colors.green,
              iconSize: 20.sp,
              onPressed: () {
                // Handle WhatsApp button press
              },
            ),
          ],
        ),
        SizedBox(
          height: 6.sp,
        ),
        Row(
          children: [
            if (mediaItemDetails?.trailer != null ||
                mediaItemDetails?.trailer != "null")
              SizedBox(width: 24.sp),
            if (mediaItemDetails?.trailer != null ||
                mediaItemDetails?.trailer != "null")
              getTrailerWidget(),
            SizedBox(width: 24.sp),
            getAddToMyListWidget(),
            SizedBox(width: 24.sp),
            getDownloadBtnWidget(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.pink,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Icon(
                    Icons.cast,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 28.sp),
          ],
        ),
        SizedBox(
          height: 12.sp,
        ),
        // No Need for Movies
        if (mediaItemDetails?.mediaContentType != MediaContentType.movies)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20.sp),
                ...List.generate(5, (index) => _buildServerItem(index)),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: CustomText(
            text: parse(mediaItemDetails?.description.toString()).body!.text,
            color: Colors.grey.shade700,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
            maxLines: 500,
          ),
        ),
      ],
    );
  }

  Widget buildDotItem(int index, String text) {
    if (text.isEmpty) return Container();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          CustomText(
            text: text,
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getTrailerWidget() {
    return InkWell(
      onTap: () {
        // TODO: link to trailer
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(6.sp),
            child: Icon(
              Icons.play_arrow,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: 'Trailer',
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getDownloadBtnWidget() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(6.sp),
            child: Icon(
              Icons.download,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: 'Download',
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getAddToMyListWidget() {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(6.sp),
            child: Icon(
              (mediaItemDetails!.inWatchList ?? false)
                  ? Icons.remove
                  : Icons.add,
              size: 32.sp,
              color: Colors.white,
            ),
          ),
          CustomText(
            text: 'My List',
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildServerItem(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.only(right: 12.sp),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: 'Server $index',
        fontSize: 14.sp,
        color: Colors.white,
      ),
    );
  }

  Widget getActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Actors',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 6.sp),
              if (genericDetailsResponseModel?.actors != null)
                ...List.generate(
                    genericDetailsResponseModel!.actors!.length,
                    (index) => buildActorItem(
                        index, genericDetailsResponseModel!.actors![index])),
              SizedBox(width: 6.sp),
            ],
          ),
        )
      ],
    );
  }

  Widget getDirectors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Director',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 6.sp),
              if (genericDetailsResponseModel?.actors != null)
                ...List.generate(
                    genericDetailsResponseModel!.directors!.length,
                    (index) => buildActorItem(
                        index, genericDetailsResponseModel!.directors![index])),
              SizedBox(width: 6.sp),
            ],
          ),
        )
      ],
    );
  }

  Widget buildActorItem(int index, ActorModel actor) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.sp,
            backgroundImage: NetworkImage(actor.actorImage ?? ""),
          ),
          SizedBox(height: 10),
          Container(
            width: 70.sp,
            child: TextScroll(
              actor.actorName ?? "",
              velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRelatedMovies() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Related Movies',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Customverticalcard(
                    url:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT978tsS4711GcHRnrEiIp48seju5Q18IBvgw&s",
                    isPremium: false,
                    id: null,
                    title: null,
                    mediaContentType: MediaContentType.movies,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getSeasons() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Seasons',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSeasonIndex = index;
                      });
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: _selectedSeasonIndex == index
                                ? [Colors.orange, Colors.pink]
                                : [ColorCode.cardInfoBg, ColorCode.cardInfoBg],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: CustomText(text: "Season $index")),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getEpisodes() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24.sp),
            Container(
              width: 2,
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Episodes',
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        SizedBox(height: 12.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 24.sp),
              ...List.generate(
                10,
                (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Customhorizontalcard(
                      isPremium: true,
                      showTitle: true,
                      url:
                          "https://anniehaydesign.weebly.com/uploads/9/5/4/6/95469676/landscape-poster-3_orig.jpg",
                      title: null,
                      id: null,
                      mediaContentType: MediaContentType.getMediaType(""),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
