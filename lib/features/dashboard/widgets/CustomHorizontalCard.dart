import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/assets_images.dart';

class Customhorizontalcard extends StatelessWidget {
  final String url;
  final bool isPremium;
  final bool showTitle;
  const Customhorizontalcard(
      {super.key,
      required this.isPremium,
      required this.showTitle,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              Image.network(
                url,
                fit: BoxFit.cover,
                width: 175.sp,
                height: 95.sp,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: isPremium // Replace with your boolean variable
                    ? Container(
                        margin: EdgeInsets.all(6.sp),
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
                          padding: EdgeInsets.all(4.sp),
                          child: Image.asset(
                            AssetImages.icSubscribe,
                            width: 14,
                            height: 14,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        if (showTitle)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: TextScroll(
              'Movie Title will Display Here...',
              velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          )
      ],
    );
  }
}
