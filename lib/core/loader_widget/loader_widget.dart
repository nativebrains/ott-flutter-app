import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constants/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  final bool isFullScreen; // Allow custom padding
  final bool hideBackground;

  const LoaderWidget(
      {Key? key, this.isFullScreen = true, this.hideBackground = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container with transparent black color
        if (!hideBackground)
          Container(
            color: Colors.black.withOpacity(0.6), // Adjust opacity as needed
            width: isFullScreen ? double.infinity : null,
            height: isFullScreen ? double.infinity : null,
          ),
        Center(
          child: LoadingAnimationWidget.hexagonDots(
            color: ColorCode.mainColor,
            size: 70.sp,
          ),
        )
      ],
    );
  }
}
