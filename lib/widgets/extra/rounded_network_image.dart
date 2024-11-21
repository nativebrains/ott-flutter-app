import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

import '../../constants/assets_images.dart';

class RoundedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color? borderColor; // Optional border color
  final double? borderWidth; // Optional border width
  final Color? iconColor; // Optional icon color
  bool showShimmerOnError = false;

  RoundedNetworkImage(
      {required this.imageUrl,
      this.borderRadius = 20.0,
      this.fit = BoxFit.cover,
      this.width,
      this.height,
      this.borderColor,
      this.borderWidth = 0.0, // Default to no border
      this.iconColor, // Default to null
      this.showShimmerOnError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // Apply the border only if borderColor is not null and borderWidth is greater than 0
        border: (borderColor != null && borderWidth! > 0.0)
            ? Border.all(color: borderColor!, width: borderWidth!)
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      clipBehavior:
          Clip.hardEdge, // Ensures the image (child) respects the borderRadius
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (iconColor == null)
            Image.network(
              imageUrl,
              fit: fit,
              width: width,
              height: height,
              errorBuilder: (context, error, stackTrace) {
                print('Failed to load image: $error | ImageUrl ');
                return showShimmerOnError
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: Duration(
                            milliseconds: 750), // Set the duration for one loop
                        child: Container(
                          width: width,
                          height: height,
                          color: Colors.grey[300],
                        ),
                      )
                    : RoundedNetworkImage(
                        imageUrl: AssetImages.dawateIslamiLogo,
                        width: 80.sp,
                        height: 80.sp,
                        borderRadius: 50.sp,
                      );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null)
                  return child; // Return the image if it's loaded.

                // Return shimmer effect during image loading
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  period: Duration(
                      milliseconds: 750), // Set the duration for one loop
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.grey[300],
                  ),
                );
              },
            ),
          if (iconColor != null)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColor!,
                BlendMode.srcIn,
              ),
              child: Image.network(
                imageUrl,
                fit: fit,
                width: width,
                height: height,
              ),
            ),
        ],
      ),
    );
  }
}
