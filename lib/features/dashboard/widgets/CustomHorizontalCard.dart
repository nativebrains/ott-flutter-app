import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/widgets/extra/rounded_network_image.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../common/enums/MediaContentType.dart';
import '../../details/screens/DetailsScreen.dart';

class Customhorizontalcard extends StatelessWidget {
  final int? id;
  final String url;
  final bool isPremium;
  final bool showTitle;
  final String? title;
  const Customhorizontalcard({
    super.key,
    required this.isPremium,
    required this.showTitle,
    required this.url,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteConstantName.detailsScreen,
          arguments: DetailsScreenArguments(
            title: showTitle ? "Sports or Live TV" : "Tv Shows",
            mediaContentType:
                showTitle ? MediaContentType.sports : MediaContentType.tvShows,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: [
                RoundedNetworkImage(
                  imageUrl: url,
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
            Container(
              width: 175.sp,
              padding: const EdgeInsets.only(top: 4.0),
              child: TextScroll(
                title ?? "",
                velocity: Velocity(pixelsPerSecond: Offset(30, 0)),
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            )
        ],
      ),
    );
  }
}
