import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/assets_images.dart';

class Customhorizontalcard extends StatefulWidget {
  final List<String> imgList;
  final bool isPremium;
  final bool showTitle;
  const Customhorizontalcard(
      {super.key,
      required this.imgList,
      required this.isPremium,
      required this.showTitle});

  @override
  State<Customhorizontalcard> createState() => _CustomhorizontalcardState();
}

class _CustomhorizontalcardState extends State<Customhorizontalcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.imgList.asMap().entries.map((entry) {
            return Container(
                width: 175.sp,
                margin: entry.key == 0
                    ? const EdgeInsets.only(
                        left: 16.0, right: 5.0, top: 5.0, bottom: 5.0)
                    : const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: [
                          Image.network(
                            entry.value,
                            fit: BoxFit.cover,
                            width: 175.sp,
                            height: 105.sp,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: widget
                                    .isPremium // Replace with your boolean variable
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
                    if (widget.showTitle)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: TextScroll(
                          'Movie Title will Display Here...',
                          velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      )
                  ],
                ));
          }).toList(),
        ),
      ),
    );
  }
}
