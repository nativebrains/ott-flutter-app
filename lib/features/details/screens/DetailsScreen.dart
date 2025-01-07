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
import 'package:islamforever/features/details/screens/ActorDetailsScreen.dart';
import 'package:islamforever/features/mix/models/ItemEpisodeModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemSeasonModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../utils/share_utils.dart';
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
  ItemSeasonModel? selectedSeasonModel;
  List<ItemEpisodeModel>? itemEpisodeModel;
  bool _episodesLoading = false;
  late GenericDetailsResponseModel? genericDetailsResponseModel;
  late MediaItemDetails? mediaItemDetails;
  bool _isLoading = false;
  bool _normalLoading = false;
  @override
  void initState() {
    super.initState();
    detailsProvider = Provider.of<DetailsProvider>(context, listen: false);
    print("Details Items ID = " + widget.detailsScreenArguments.id);
    print("Details Items Type = " +
        widget.detailsScreenArguments.mediaContentType.displayName);

    fetchDetailsData();
  }

  void fetchDetailsData({bool showNormalLoading = false}) async {
    setState(() {
      if (showNormalLoading) {
        _normalLoading = true;
      } else {
        _isLoading = true;
      }
    });
    switch (widget.detailsScreenArguments.mediaContentType) {
      case MediaContentType.movies:
        genericDetailsResponseModel = await detailsProvider
            .fetchMovieDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        break;
      case MediaContentType.tvShows:
        genericDetailsResponseModel = await detailsProvider
            .fetchShowsDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        if (genericDetailsResponseModel?.seasons != null) {
          if (genericDetailsResponseModel?.seasons?.isNotEmpty != null) {
            setState(() {
              _episodesLoading = true;
            });
            itemEpisodeModel = await detailsProvider.fetchSeasonEpisodeDetails(
                genericDetailsResponseModel!.seasons![0].seasonId);
            setState(() {
              _episodesLoading = false;
            });
          }
        }
        break;
      case MediaContentType.sports:
        genericDetailsResponseModel = await detailsProvider
            .fetchSportsDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        break;
      case MediaContentType.liveTv:
        genericDetailsResponseModel = await detailsProvider
            .fetchLiveTvDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        break;
    }
    setState(() {
      _normalLoading = false;
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
                    if (mediaItemDetails?.mediaContentType ==
                        MediaContentType.tvShows) ...[
                      SizedBox(height: 16.sp),
                      getSeasons(),
                      SizedBox(height: 24.sp),
                      getEpisodes(),
                    ],
                    if ([
                      MediaContentType.movies,
                      MediaContentType.tvShows,
                    ].contains(mediaItemDetails?.mediaContentType)) ...[
                      SizedBox(height: 24.sp),
                      getActors(),
                      SizedBox(height: 24.sp),
                      getDirectors(),
                    ],
                    SizedBox(height: 12.sp),
                    getRelatedItems(),
                    SizedBox(height: 30.sp),
                  ],
                ),
              ),
            if (_isLoading) const LoaderWidget(),
            if (_normalLoading) const LoaderWidget()
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
        if (mediaItemDetails?.mediaContentType == MediaContentType.movies)
          SizedBox(
            height: 12.sp,
          ),
        if (mediaItemDetails?.mediaContentType == MediaContentType.movies)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: GradientText(
              'IMDB ${mediaItemDetails?.rating ?? "0.0"}',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
              colors: const [
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
              if (mediaItemDetails?.releaseDate != null)
                buildDotItem(-1, mediaItemDetails?.releaseDate ?? ""),
              if (mediaItemDetails?.duration?.isNotEmpty ?? false)
                buildDotItem(0, mediaItemDetails?.duration ?? ""),
              if (mediaItemDetails?.category?.isNotEmpty ?? false)
                buildDotItem(1, mediaItemDetails?.category ?? ""),
              if (mediaItemDetails?.contentRating?.isNotEmpty ?? false)
                buildDotItem(1,
                    "Content Rating ${mediaItemDetails?.contentRating ?? "0.0"}"),
              if ((mediaItemDetails?.views?.isNotEmpty ?? false) &&
                  mediaItemDetails?.mediaContentType !=
                      MediaContentType.tvShows)
                buildDotItem(2, "Views ${mediaItemDetails?.views ?? ""}"),
              if (mediaItemDetails?.language?.isNotEmpty ?? false)
                buildDotItem(3, mediaItemDetails?.language ?? ""),
              if (genericDetailsResponseModel?.genres?.isNotEmpty ?? false)
                ...List.generate(
                    genericDetailsResponseModel!.genres!.length,
                    (index) => buildDotItem(index,
                        genericDetailsResponseModel!.genres![index].genreName)),
            ],
          ),
        ),
        if (mediaItemDetails?.mediaContentType != MediaContentType.tvShows)
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
                  ShareUtils.shareFacebook(
                    context,
                    mediaItemDetails?.title ?? "Title",
                    mediaItemDetails?.shareLink ?? "Link",
                  );
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter),
                color: Colors.blue,
                iconSize: 20.sp,
                onPressed: () {
                  // Handle Twitter button press
                  ShareUtils.shareTwitter(
                    context,
                    mediaItemDetails?.title ?? "Title",
                    mediaItemDetails?.shareLink ?? "Link",
                    "",
                    "",
                  );
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.whatsapp),
                color: Colors.green,
                iconSize: 20.sp,
                onPressed: () {
                  // Handle WhatsApp button press
                  ShareUtils.shareWhatsapp(
                    context,
                    mediaItemDetails?.title ?? "Title",
                    mediaItemDetails?.shareLink ?? "Link",
                  );
                },
              ),
            ],
          ),
        SizedBox(
          height: 6.sp,
        ),
        Row(
          children: [
            if (mediaItemDetails?.trailer != null &&
                mediaItemDetails?.trailer != "" &&
                mediaItemDetails?.mediaContentType != MediaContentType.sports &&
                mediaItemDetails?.mediaContentType !=
                    MediaContentType.liveTv) ...[
              SizedBox(width: 24.sp),
              getTrailerWidget(),
            ],
            if (mediaItemDetails?.mediaContentType !=
                MediaContentType.tvShows) ...[
              SizedBox(width: 24.sp),
              getAddToMyListWidget(),
            ],
            if (mediaItemDetails?.mediaContentType == MediaContentType.movies &&
                (mediaItemDetails?.isDownload ?? false) &&
                ((mediaItemDetails?.isPremium ?? false)
                    ? (genericDetailsResponseModel?.isPurchased ?? false)
                    : true)) ...[
              SizedBox(width: 24.sp),
              getDownloadBtnWidget(),
            ],
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
        if (mediaItemDetails?.mediaContentType == MediaContentType.liveTv)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20.sp),
                if (mediaItemDetails?.server1Url != null &&
                    mediaItemDetails?.server1Url != "")
                  _buildServerItem(1),
                if (mediaItemDetails?.server2Url != null &&
                    mediaItemDetails?.server2Url != "")
                  _buildServerItem(2),
                if (mediaItemDetails?.server3Url != null &&
                    mediaItemDetails?.server3Url != "")
                  _buildServerItem(3)
              ],
            ),
          ),
        if (mediaItemDetails?.description != null &&
            mediaItemDetails?.description != "")
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
      onTap: () async {
        setState(() {
          _normalLoading = true;
        });
        bool isSuccess = await detailsProvider.addOrRemoveWatchList(
          mediaItemDetails!.inWatchList,
          mediaItemDetails?.id,
          mediaItemDetails?.mediaContentType.shortDisplayName,
        );

        showCustomToast(context, DetailsProvider.getStatusMessage ?? "",
            backgroudnColor: isSuccess ? Colors.green : Colors.red);
        // Refresh
        if (isSuccess) fetchDetailsData(showNormalLoading: true);
        setState(() {
          _normalLoading = false;
        });
      },
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
    if (genericDetailsResponseModel?.actors?.isEmpty ?? true) {
      return Container();
    }
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
                    (index) => buildActorItem(index,
                        genericDetailsResponseModel!.actors![index], true)),
              SizedBox(width: 6.sp),
            ],
          ),
        )
      ],
    );
  }

  Widget getDirectors() {
    if (genericDetailsResponseModel?.directors?.isEmpty ?? true) {
      return Container();
    }
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
              text: 'Directors',
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
                    (index) => buildActorItem(index,
                        genericDetailsResponseModel!.directors![index], false)),
              SizedBox(width: 6.sp),
            ],
          ),
        )
      ],
    );
  }

  Widget buildActorItem(int index, ActorModel actor, bool isActor) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteConstantName.actorDetailsScreen,
          arguments: ActorDetailsScreenArguments(
            id: actor.actorId.toString(),
            mediaContentType: mediaItemDetails!.mediaContentType,
            title: actor.actorName.toString(),
            isActor: isActor,
          ),
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget getRelatedItems() {
    if (genericDetailsResponseModel?.itemRelated?.isEmpty ?? true) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
            'Related ${mediaItemDetails?.mediaContentType.displayName}'),
        SizedBox(height: 12.sp),
        _buildRelatedItems(genericDetailsResponseModel?.itemRelated),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Row(
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
          text: title,
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildRelatedItems(List<dynamic>? items) {
    if (items == null) return Container();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24.sp),
          if (mediaItemDetails?.mediaContentType == MediaContentType.tvShows)
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Customhorizontalcard(
                  isPremium: (items[index] as ItemShowModel).isPremium,
                  showTitle: false,
                  url: (items[index] as ItemShowModel).showImage ?? "",
                  title: (items[index] as ItemShowModel).showName,
                  id: (items[index] as ItemShowModel).showId,
                  mediaContentType: MediaContentType.tvShows,
                ),
              ),
            ),
          if (mediaItemDetails?.mediaContentType == MediaContentType.movies)
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Customverticalcard(
                  url: (items[index] as ItemMovieModel).moviePoster ?? "",
                  isPremium:
                      (items[index] as ItemMovieModel).isPremium ?? false,
                  id: (items[index] as ItemMovieModel).movieId,
                  title: (items[index] as ItemMovieModel).movieName,
                  mediaContentType:
                      (items[index] as ItemMovieModel).mediaContentType,
                ),
              ),
            ),
          if (mediaItemDetails?.mediaContentType == MediaContentType.liveTv)
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Customhorizontalcard(
                  url: (items[index] as ItemLiveTVModel).tvImage ?? "",
                  isPremium: (items[index] as ItemLiveTVModel).isPremium,
                  id: (items[index] as ItemLiveTVModel).tvId,
                  title: (items[index] as ItemLiveTVModel).tvName,
                  mediaContentType:
                      (items[index] as ItemLiveTVModel).mediaContentType,
                  showTitle: true,
                ),
              ),
            ),
          if (mediaItemDetails?.mediaContentType == MediaContentType.sports)
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Customhorizontalcard(
                  url: (items[index] as ItemSportModel).sportImage ?? "",
                  isPremium: (items[index] as ItemSportModel).isPremium,
                  id: (items[index] as ItemSportModel).sportId,
                  title: (items[index] as ItemSportModel).sportTitle,
                  mediaContentType:
                      (items[index] as ItemSportModel).mediaContentType,
                  showTitle: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget getSeasons() {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 24.sp),
              if (genericDetailsResponseModel?.seasons != null)
                ...List.generate(
                  genericDetailsResponseModel!.seasons!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _selectedSeasonIndex = index;
                          selectedSeasonModel =
                              genericDetailsResponseModel!.seasons![index];
                          _episodesLoading = true;
                        });
                        itemEpisodeModel =
                            await detailsProvider.fetchSeasonEpisodeDetails(
                                selectedSeasonModel!.seasonId);
                        setState(() {
                          _episodesLoading = false;
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
                                  : [
                                      ColorCode.cardInfoBg,
                                      ColorCode.cardInfoBg
                                    ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: CustomText(
                              text: genericDetailsResponseModel!
                                  .seasons![index].seasonName
                                  .toString())),
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
              if (itemEpisodeModel != null && !_episodesLoading)
                ...List.generate(
                  itemEpisodeModel!.length,
                  (index) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Customhorizontalcard(
                        isPremium: itemEpisodeModel![index].isPremium ?? false,
                        showTitle: true,
                        url: itemEpisodeModel![index].episodeImage ?? "",
                        title: itemEpisodeModel![index].episodeName,
                        id: itemEpisodeModel![index].episodeId,
                        mediaContentType: MediaContentType.tvShows,
                        shouldRedirect: false,
                      )),
                ),
            ],
          ),
        ),
        if (itemEpisodeModel != null &&
            itemEpisodeModel!.isEmpty &&
            !_episodesLoading)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: CustomText(
                text: 'No Episodes Found!',
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (_episodesLoading)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
                child: CircularProgressIndicator(
              color: ColorCode.themeOrangePinkStart,
            )),
          )
      ],
    );
  }
}
