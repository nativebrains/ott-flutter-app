import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'app_colors.dart';

SnackBar customSuccessSnackBar({required String msg, Duration? duration}) {
  return SnackBar(
    elevation: 8,
    duration: duration ?? const Duration(milliseconds: 4000),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.done,
            color: ColorCode.mainColor,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            msg,
            maxLines: 5,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: ColorCode.mainColor,
  );
}

SnackBar customErrorSnackBar({required String msg, Duration? duration}) {
  return SnackBar(
    elevation: 8,
    duration: duration ?? const Duration(milliseconds: 4000),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.error,
            color: Colors.pink,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          child: Text(
            msg,
            maxLines: 5,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.pink,
  );
}

void showCustomToast(BuildContext mcontext, String msg,
    {Color backgroudnColor = const Color(0xFFC33366),
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 5)}) {
  showToast(msg,
      context: mcontext,
      backgroundColor: backgroudnColor,
      textStyle: TextStyle(
        color: textColor,
      ),
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.slideToTopFade,
      position: StyledToastPosition(align: Alignment.topCenter, offset: 20.w),
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: duration,
      //Animation duration   animDuration * 2 <= duration
      animDuration: Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn);
}
