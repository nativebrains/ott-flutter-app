import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
import 'package:islamforever/features/details/screens/VideroPlayerScreen.dart';
import 'package:islamforever/features/mix/models/ItemEpisodeModel.dart';
import 'package:islamforever/features/mix/models/ItemLiveTvModel.dart';
import 'package:islamforever/features/mix/models/ItemMovieModel.dart';
import 'package:islamforever/features/mix/models/ItemPodcastModel.dart';
import 'package:islamforever/features/mix/models/ItemSeasonModel.dart';
import 'package:islamforever/features/mix/models/ItemShowModel.dart';
import 'package:islamforever/features/mix/models/ItemSportModel.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:islamforever/utils/extras.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../utils/share_utils.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_rate_experience_dialog.dart';
import '../../../widgets/custom/custom_review_dialog.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/extra/rounded_network_image.dart';
import '../models/ReviewModel.dart';
import '../utils/PlayerUtils.dart';

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
  List<ReviewModel> reviewsList = [];
  bool _isLoading = false;
  bool _normalLoading = false;

  late AudioPlayer? _audioPlayer;
  bool _isPlaying = false;

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer!.positionStream,
          _audioPlayer!.bufferedPositionStream,
          _audioPlayer!.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

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
          if (genericDetailsResponseModel?.seasons!.isNotEmpty == true) {
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
      case MediaContentType.podcast:
        genericDetailsResponseModel = await detailsProvider
            .fetchPodCastDetails(widget.detailsScreenArguments.id);
        mediaItemDetails =
            MediaItemDetails.getMediaItemDetails(genericDetailsResponseModel!);
        await _initAudioPlayer();
        break;
    }

    reviewsList = await detailsProvider.fetchMediaReviewsDetails(
            mediaItemDetails?.id,
            mediaItemDetails?.mediaContentType.actualValue) ??
        [];

    setState(() {
      _normalLoading = false;
      _isLoading = false;
    });
  }

  Future<void> _initAudioPlayer() async {
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer?.setAudioSource(AudioSource.uri(
          Uri.parse(mediaItemDetails?.mediaPlayUrl.toString() ?? "")));
    } catch (e) {
      showCustomToast(context, "Audio not Supported..!");
    }
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.blackColor,
      body: SafeArea(
        top: false, // Remove the top padding
        child: Stack(
          children: [
            if (!_isLoading)
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getTopSection(),
                    getDescriptionSection(),
                    if (DetailsProvider.isLoggedIn) getAddReviewSection(),
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
                      MediaContentType.podcast
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
      height: 320.sp,
      child: Stack(
        children: [
          // Background image
          RoundedNetworkImage(
            imageUrl: mediaItemDetails?.image ?? mediaItemDetails?.poster ?? "",
            fit: BoxFit.fill,
            width: double.infinity, // Set the width to infinity
            height: double.infinity,
          ),

          // Gradient overlay
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 180.sp,
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
            top: 45,
            left: 25,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Add a background color
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 20.sp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),

          if (!_isPlaying)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Center(
                child: AvatarGlow(
                  child: InkWell(
                    onTap: () async {
                      if (widget.detailsScreenArguments.mediaContentType ==
                              MediaContentType.tvShows &&
                          itemEpisodeModel != null &&
                          itemEpisodeModel!.isNotEmpty) {
                        PlayerUtil.navigateToVideoPlayerScreen(
                          context,
                          itemEpisodeModel![0].episodeUrl ?? "",
                          itemEpisodeModel![0].episodeId,
                          MediaContentType.tvShows,
                          itemEpisodeModel![0].episodeImage ?? "",
                        );
                      } else if (widget
                              .detailsScreenArguments.mediaContentType ==
                          MediaContentType.podcast) {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                        await _audioPlayer?.play();
                      } else {
                        String streamUrl = mediaItemDetails?.mediaPlayUrl ?? "";
                        PlayerUtil.navigateToVideoPlayerScreen(
                          context,
                          streamUrl,
                          mediaItemDetails!.id,
                          mediaItemDetails!.mediaContentType,
                          mediaItemDetails?.image ??
                              mediaItemDetails?.poster ??
                              "",
                        );
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            ColorCode.greenStartColor,
                            ColorCode.greenEndColor
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

          if (_isPlaying)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Seek bar
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        final maxValue =
                            positionData?.duration.inMilliseconds.toDouble() ??
                                0;

                        return Slider(
                          min: 0,
                          max: maxValue,
                          value: (positionData?.position.inMilliseconds
                                      .toDouble() ??
                                  0)
                              .clamp(0, maxValue),
                          activeColor: Colors.greenAccent,
                          inactiveColor: Colors.white,
                          thumbColor: Colors.red,
                          onChanged: (value) {
                            _audioPlayer
                                ?.seek(Duration(milliseconds: value.round()));
                          },
                        );
                      },
                    ),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: formatDuration(
                                    positionData?.position ?? Duration.zero),
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              CustomButton(
                                icon: Icons.skip_previous,
                                onPressed: () async {
                                  final position = await _audioPlayer!.position;
                                  final newPosition =
                                      position - const Duration(seconds: 5);
                                  if (newPosition.inSeconds < 0) {
                                    await _audioPlayer!
                                        .seek(const Duration(seconds: 0));
                                  } else {
                                    await _audioPlayer!.seek(newPosition);
                                  }
                                },
                              ),
                              StreamBuilder<PlayerState>(
                                stream: _audioPlayer?.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final playing = playerState?.playing;
                                  final processingState =
                                      playerState?.processingState;

                                  if (processingState ==
                                      ProcessingState.completed) {
                                    return CustomButton(
                                      icon: Icons.replay,
                                      onPressed: () async {
                                        await _audioPlayer?.seek(Duration.zero);
                                        await _audioPlayer?.play();
                                      },
                                    );
                                  } else {
                                    return CustomButton(
                                      icon: playing ?? false
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      onPressed: () async {
                                        if (playing ?? false) {
                                          await _audioPlayer?.pause();
                                        } else {
                                          await _audioPlayer?.play();
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                              CustomButton(
                                icon: Icons.skip_next,
                                onPressed: () async {
                                  final position = await _audioPlayer!.position;
                                  final duration = await _audioPlayer!.duration;
                                  final newPosition =
                                      position + const Duration(seconds: 5);
                                  if (newPosition.inSeconds >
                                      duration!.inSeconds) {
                                    await _audioPlayer?.seek(duration);
                                  } else {
                                    await _audioPlayer?.seek(newPosition);
                                  }
                                },
                              ),
                              CustomText(
                                text: formatDuration(
                                    positionData?.duration ?? Duration.zero),
                                fontSize: 11,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget CustomButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.greenAccent, // Button color
        ),
        child: Center(
          child: Icon(
            icon, // Button icon
            size: 24, // Icon size
            color: Colors.black, // Icon color
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  Widget getDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTitleAndRatingReviews(),
        if (mediaItemDetails?.mediaContentType == MediaContentType.movies)
          SizedBox(
            height: 12.sp,
          ),
        // if (mediaItemDetails?.mediaContentType == MediaContentType.movies)
        //   Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 12.0),
        //     decoration: BoxDecoration(
        //       color: ColorCode.cardInfoHeader,
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //     child: GradientText(
        //       'IMDB ${mediaItemDetails?.rating ?? "0.0"}',
        //       style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
        //       colors: const [
        //         ColorCode.greenStartColor,
        //         ColorCode.greenEndColor
        //       ],
        //     ),
        //   ),
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
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       gradient: LinearGradient(
            //         colors: [
            //           ColorCode.greenStartColor,
            //           ColorCode.greenEndColor
            //         ],
            //       ),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.all(10.sp),
            //       child: Icon(
            //         Icons.cast,
            //         size: 24.sp,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(width: 28.sp),
          ],
        ),
        SizedBox(
          height: 12.sp,
        ),
        // No Need for Movies
        // if (mediaItemDetails?.mediaContentType == MediaContentType.liveTv)
        //   SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         SizedBox(width: 20.sp),
        //         if (mediaItemDetails?.server1Url != null &&
        //             mediaItemDetails?.server1Url != "")
        //           _buildServerItem(1),
        //         if (mediaItemDetails?.server2Url != null &&
        //             mediaItemDetails?.server2Url != "")
        //           _buildServerItem(2),
        //         if (mediaItemDetails?.server3Url != null &&
        //             mediaItemDetails?.server3Url != "")
        //           _buildServerItem(3)
        //       ],
        //     ),
        //   ),
        SizedBox(
          height: 12.sp,
        ),
        if (mediaItemDetails?.description != null &&
            mediaItemDetails?.description != "")
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: CustomText(
              text: parse(mediaItemDetails?.description.toString()).body!.text,
              color: Colors.grey.shade700,
              fontSize: 14.sp,
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
              color: Colors.greenAccent,
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
        String streamUrl = mediaItemDetails?.trailer ?? "";
        PlayerUtil.navigateToVideoPlayerScreen(
          context,
          streamUrl,
          mediaItemDetails!.id,
          mediaItemDetails!.mediaContentType,
          mediaItemDetails?.image ?? mediaItemDetails?.poster ?? "",
        );
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
        if (!DetailsProvider.isLoggedIn) return;
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
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: 'Server $index',
        fontSize: 14.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
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
                  colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Performer',
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
                  colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(width: 12.sp),
            CustomText(
              text: 'Team',
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
              colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
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
                child: Customhorizontalcard(
                  url: (items[index] as ItemMovieModel).moviePoster ?? "",
                  showTitle: false,
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
          if (mediaItemDetails?.mediaContentType == MediaContentType.podcast)
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Customverticalcard(
                  url: (items[index] as ItemPodcastModel).audioPoster ?? "",
                  isPremium:
                      (items[index] as ItemPodcastModel).isPremium ?? false,
                  id: (items[index] as ItemPodcastModel).audioId,
                  title: (items[index] as ItemPodcastModel).audioTitle,
                  mediaContentType:
                      (items[index] as ItemPodcastModel).mediaContentType,
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
                  colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
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
                                  ? [
                                      ColorCode.greenStartColor,
                                      ColorCode.greenEndColor
                                    ]
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
        ),
        if (genericDetailsResponseModel?.seasons != null &&
            genericDetailsResponseModel?.seasons!.isEmpty == true)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: CustomText(
                text: 'No Seasons Found!',
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
                  colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
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
                        shoulPlay: true,
                        shouldRedirect: false,
                        playUrl: itemEpisodeModel![index].episodeUrl ?? "",
                        showEpisodePlayIcon:
                            mediaItemDetails?.mediaContentType ==
                                MediaContentType.tvShows,
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
        if (itemEpisodeModel == null && !_episodesLoading)
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
              color: ColorCode.greenStartColor,
            )),
          )
      ],
    );
  }

  Widget getTitleAndRatingReviews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomText(
              text: mediaItemDetails?.title ?? "",
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                if (reviewsList.isNotEmpty)
                  _showReviewDialog(context, reviewsList);
                else
                  showCustomToast(context, "No reviews yet!");
              },
              child: RatingBar(
                initialRating:
                    roundToNearestHalf(calculateAverageRating(reviewsList)),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 22.sp,
                ignoreGestures: true,
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star_rounded, color: Colors.yellow.shade600),
                  half: Icon(Icons.star_half_rounded,
                      color: Colors.yellow.shade600),
                  empty: Icon(Icons.star_outline_rounded,
                      color: Colors.grey.shade400),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CustomText(
                text:
                    "${calculateAverageRating(reviewsList)} Stars | ${formatReviewCount(reviewsList)}",
                color: Colors.white,
                fontSize: 9.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showReviewDialog(BuildContext context, List<ReviewModel> reviewsList) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return CustomReviewDialog(reviewsList);
      },
    );
  }

  Widget getAddReviewSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 12.0, top: 12),
      child: SizedBox(
        width: 170.sp, // Set a specific width
        child: CustomElevatedButton(
          label: 'Add Review',
          onPressed: () {
            _showRateExpereinceDialog(context);
          },
          textColor: ColorCode.whiteColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          padding: EdgeInsets.all(8.sp),
          elevation: 3.sp,
          leadingIcon: Icon(
            Icons.chat,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
      ),
    );
  }

  void _showRateExpereinceDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return CustomRateExperienceDialog(
          title: "Write your review",
          buttonText: "Submit",
          onButtonPressed: (rating, review) {
            uploadUserReview(rating, review);
            Navigator.of(context).pop(); // For closing the dialog
          },
        );
      },
    );
  }

  void uploadUserReview(int rating, String review) async {
    final isSuccess = await detailsProvider.submitReviewRating(rating, review,
        mediaItemDetails?.id, mediaItemDetails?.mediaContentType.actualValue);

    if (DetailsProvider.getStatusMessage != null) {
      showCustomToast(
        context,
        DetailsProvider.getStatusMessage.toString(),
        backgroudnColor: isSuccess ? Colors.green : Colors.red,
        duration: Duration(seconds: 3),
        textColor: Colors.white,
      );
    }
  }
}
