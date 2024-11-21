import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';

class NetWorkErrorWidget extends StatelessWidget {
  const NetWorkErrorWidget({
    Key? key,
    required this.error,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          "\n$error",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.pink,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onPressed,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorCode.mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Please try again",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
