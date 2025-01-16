import 'package:flutter/material.dart';
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
  late YoutubePlayerController _controller;
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
        VideoPlayerType.Youtube)
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoPlayerScreenArguments.videoId.toString(),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false, // Set to false to unmute the video
          loop: true, // Set to true to loop the video
          isLive: false, // Set to true for live videos
          forceHD: false, // Set to true to force HD quality
        ),
      );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (!_isLoading)
              if (widget.videoPlayerScreenArguments.videoPlayerType ==
                  VideoPlayerType.Youtube)
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                    // _controller.addListener(listener);
                  },
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                    ),
                    RemainingDuration(),
                    FullScreenButton(
                      controller: _controller,
                    ),
                  ],
                ),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }
}
