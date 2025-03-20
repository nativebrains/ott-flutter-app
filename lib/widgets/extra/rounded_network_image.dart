import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

import '../../constants/assets_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RoundedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;
  final Color? iconColor;
  final bool showShimmerOnError;

  RoundedNetworkImage({
    required this.imageUrl,
    this.borderRadius = 6.0,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderColor,
    this.borderWidth = 0.0,
    this.iconColor,
    this.showShimmerOnError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: borderColor != null && borderWidth! > 0.0
            ? Border.all(color: borderColor!, width: borderWidth!)
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (iconColor == null)
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              width: width,
              height: height,
              errorWidget: (context, url, error) => _getErrorWidget(context),
              placeholder: (context, url) => _getPlaceholderWidget(context),
            ),
          if (iconColor != null)
            ColorFiltered(
              colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: fit,
                width: width,
                height: height,
              ),
            ),
        ],
      ),
    );
  }

  Widget _getErrorWidget(BuildContext context) {
    print('Failed to load image: ');
    return showShimmerOnError
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            period: Duration(milliseconds: 750),
            child: Container(
              width: width,
              height: height,
              color: Colors.grey[300],
            ),
          )
        : Opacity(
            opacity:
                0.5, // Adjust this value to change the transparency level (0.0 - 1.0)
            child: Image.asset(
              AssetImages.dawateIslamiLogo,
              width: width,
              height: height,
              fit: fit,
            ),
          );
  }

  Widget _getPlaceholderWidget(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      period: Duration(milliseconds: 750),
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[800],
      ),
    );
  }
}
