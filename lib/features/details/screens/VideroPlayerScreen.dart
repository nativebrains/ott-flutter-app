import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/features/details/utils/CustomControls.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/extra/rounded_network_image.dart';
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
  final String? imageUrl;

  VideoPlayerScreenArguments({
    required this.id,
    required this.mediaContentType,
    required this.videoPlayerType,
    required this.videoId,
    this.streamUrl,
    this.imageUrl,
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
  WebViewController? _embedWebViewController;

  @override
  void initState() {
    super.initState();
    print("======");
    print(widget.videoPlayerScreenArguments.videoPlayerType);
    print(widget.videoPlayerScreenArguments.videoId);
    print(widget.videoPlayerScreenArguments.streamUrl);
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
    if (widget.videoPlayerScreenArguments.videoPlayerType ==
        VideoPlayerType.Embed) {
      await prepareEmbedController();
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
            Center(
              child: RoundedNetworkImage(
                imageUrl: widget.videoPlayerScreenArguments.imageUrl ?? "",
                fit: BoxFit.cover,
                width: double.infinity, // Set the width to infinity
                height: 200.sp,
              ),
            ),
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
            if (widget.videoPlayerScreenArguments.videoPlayerType ==
                VideoPlayerType.Embed)
              _getEmbededPlayer(),
            if (_isLoading) const LoaderWidget(),
            Positioned(
                top: 45, // Adjust the position as needed
                left: 25, // Adjust the position as needed
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent, // Button color
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back, // Button icon
                        size: 24, // Icon size
                        color: Colors.black, // Icon color
                      ),
                    ),
                  ),
                )),
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
    _embedWebViewController?.clearCache();
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
        hideThumbnail: true,
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
          PlaybackSpeedButton(),
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
    var _isLive = _videoPlayerController!.value.duration == Duration.zero ||
        _videoPlayerController!.value.duration.inMinutes <= 1;
    print("Duration " + _videoPlayerController!.value.duration.toString());
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      isLive: _isLive,
      showControls: true,
      customControls: const CustomControls(), // Use custom controls
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

  Future<void> prepareEmbedController() async {
    _embedWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorCode.bgColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      )
      ..loadHtmlString(getHtml());
  }

  String getHtml() {
    final streamUrl = widget.videoPlayerScreenArguments.streamUrl;

    // Check if the input is an iframe tag or a simple URL
    final isIframe = streamUrl!.trim().startsWith('<iframe');

    if (isIframe) {
      // Return the iframe as-is
      return """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
          body {
            margin: 0;
            padding: 0;
            background-color: #000;
          }
          iframe {
            width: 100%;
            height: 100%;
            border: none;
          }
        </style>
      </head>
      <body>
        $streamUrl
      </body>
    </html>
    """;
    } else {
      // Assume it's a plain URL and construct the iframe dynamically
      final autoplayUrl = streamUrl.contains('autoplay=')
          ? streamUrl
          : '$streamUrl${streamUrl.contains('?') ? '&' : '?'}autoplay=1&mute=1';

      return """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
          body {
            margin: 0;
            padding: 0;
            background-color: #000;
          }
          iframe {
            width: 100%;
            height: 100%;
            border: none;
          }
        </style>
      </head>
      <body>
        <iframe 
          src="$autoplayUrl" 
          frameborder="0" 
          allow="autoplay; fullscreen; encrypted-media; picture-in-picture"
          allowfullscreen>
        </iframe>
      </body>
    </html>
    """;
    }
  }

  _getEmbededPlayer() {
    if (_embedWebViewController != null) {
      return Center(
        child: WebViewWidget(
          controller: _embedWebViewController!,
        ),
      );
    } else {
      return Container();
    }
  }
}
