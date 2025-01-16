import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/loader_widget/loader_widget.dart';
import '../../common/enums/MediaContentType.dart';
import '../providers/DetailsProvider.dart';

enum VideoPlayerType {
  Youtube,
  Vimeo,
  Exo,
}

class VideoPlayerScreenArguments {
  final int? id;
  final MediaContentType mediaContentType;
  final VideoPlayerType videoPlayerType;
  final String? videoId;

  VideoPlayerScreenArguments({
    required this.id,
    required this.mediaContentType,
    required this.videoPlayerType,
    required this.videoId,
  });
}

class VideoPlayerScreen extends StatefulWidget {
  final VideoPlayerScreenArguments videoPlayerScreenArguments;
  const VideoPlayerScreen(
      {super.key, required this.videoPlayerScreenArguments});

  @override
  State<VideoPlayerScreen> createState() => _VideroplayerscreenState();
}

class _VideroplayerscreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _youtubeController;
  late DetailsProvider detailsProvider;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    print(widget.videoPlayerScreenArguments.videoPlayerType);
    print(widget.videoPlayerScreenArguments.videoId);
    startPlayer();
  }

  void startPlayer() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.videoPlayerScreenArguments.videoPlayerType ==
        VideoPlayerType.Youtube) {
      prepareYoutubeController();
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
              if (widget.videoPlayerScreenArguments.videoPlayerType ==
                  VideoPlayerType.Youtube)
                _getYoutubePlayer(),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void prepareYoutubeController() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoPlayerScreenArguments.videoId.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false, // Set to false to unmute the video
        loop: true, // Set to true to loop the video
        isLive: false, // Set to true for live videos
        forceHD: false, // Set to true to force HD quality
        disableDragSeek: false,
      ),
    );
  }

  _getYoutubePlayer() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.greenAccent,
        progressColors: const ProgressBarColors(
          playedColor: Colors.greenAccent,
          handleColor: Colors.greenAccent,
        ),
        bottomActions: [
          SizedBox(
            width: 12.sp,
          ),
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
          ),
          RemainingDuration(),
          FullScreenButton(
            controller: _youtubeController,
          ),
          SizedBox(
            width: 12.sp,
          ),
        ],
      ),
      builder: (context, player) {
        return Column(
          children: [
            Expanded(child: player), // This will take up the full height
          ],
        );
      },
    );
  }
}
