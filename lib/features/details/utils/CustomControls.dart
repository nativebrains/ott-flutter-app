import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomControls extends StatelessWidget {
  const CustomControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    return Stack(
      children: [
        // Use the default material controls
        MaterialControls(
          showPlayButton: !chewieController.isLive,
        ),

        // Add custom "LIVE" text
        if (chewieController.isLive)
          Positioned(
            bottom: 30,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red, // Background color for the "LIVE" badge
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "Live",
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
