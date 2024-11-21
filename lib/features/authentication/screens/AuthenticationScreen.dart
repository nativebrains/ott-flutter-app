import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/core/loader_widget/loader_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/assets_images.dart';

class Authenticationscreen extends StatefulWidget {
  const Authenticationscreen({super.key});

  @override
  State<Authenticationscreen> createState() => _AuthenticationscreenState();
}

class _AuthenticationscreenState extends State<Authenticationscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // GIF background
          Image.asset(
            AssetImages.loginBg,
            fit: BoxFit.cover,
          ),
          SafeArea(
            minimum: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sign in to continue',
                      style: GoogleFonts.poppins(
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                      ),
                    ),
                    GradientText(
                      'Skip',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                      colors: [
                        Colors.orange,
                        Colors.pink,
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
