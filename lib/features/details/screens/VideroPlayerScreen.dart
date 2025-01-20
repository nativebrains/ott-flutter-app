import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/loader_widget/loader_widget.dart';
import '../../common/enums/MediaContentType.dart';
import '../providers/DetailsProvider.dart';

enum VideoPlayerType {
  Youtube,
  Vimeo,
  Exo,
  Embed,
}

class VideoPlayerScreenArguments {
  final int? id;
  final MediaContentType mediaContentType;
  final VideoPlayerType videoPlayerType;
  final String? videoId;
  final String? streamUrl;

  VideoPlayerScreenArguments({
    required this.id,
    required this.mediaContentType,
    required this.videoPlayerType,
    required this.videoId,
    this.streamUrl,
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
  late DetailsProvider detailsProvider;
  bool _isLoading = false;

  YoutubePlayerController? _youtubeController;
  InAppWebViewController? webViewController;
  VideoPlayerController? _videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    print("======");
    print(widget.videoPlayerScreenArguments.videoPlayerType);
    print(widget.videoPlayerScreenArguments.videoId);
    print("======");
    startPlayer();
  }

  void startPlayer() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.videoPlayerScreenArguments.videoPlayerType ==
        VideoPlayerType.Youtube) {
      await prepareYoutubeController();
    }
    if (widget.videoPlayerScreenArguments.videoPlayerType ==
        VideoPlayerType.Exo) {
      await prepareExoController();
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
            if (widget.videoPlayerScreenArguments.videoPlayerType ==
                VideoPlayerType.Vimeo)
              _getVimeoPlayer(),
            if (widget.videoPlayerScreenArguments.videoPlayerType ==
                VideoPlayerType.Exo)
              _getExoPlayer(),
            if (_isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    webViewController?.dispose();
    chewieController?.dispose();
    _videoPlayerController?.dispose();

    super.dispose();
  }

  _getVimeoPlayer() {
    return VimeoVideoPlayer(
      videoId: widget.videoPlayerScreenArguments.videoId.toString(),
      isAutoPlay: true,
      isLooping: true,
      isMuted: false,
      showControls: true,
      showTitle: true,
      onInAppWebViewCreated: (controller) {
        webViewController = controller;
      },
      onInAppWebViewLoadStart: (controller, url) {
        setState(() {
          _isLoading = true;
        });
      },
      onInAppWebViewLoadStop: (controller, url) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  Future<void> prepareYoutubeController() async {
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
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
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

  Future<void> prepareExoController() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoPlayerScreenArguments.streamUrl.toString()));
    await _videoPlayerController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  _getExoPlayer() {
    if (chewieController != null) {
      return Center(
        child: Chewie(controller: chewieController!),
      );
    } else {
      return Container();
    }
  }
}
