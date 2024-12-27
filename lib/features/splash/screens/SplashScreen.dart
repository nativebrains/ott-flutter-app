import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/constants/app_colors.dart';

import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/assets_images.dart';
import '../../../constants/constants.dart';
import '../../../constants/routes_names.dart';
import '../../../core/services/shared_preference.dart';
import '../../../widgets/custom/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _navigateToJourney();
    super.initState();
  }

  _navigateToJourney() async {
    await Future.delayed(const Duration(seconds: 3), () {
      bool? isLoggedIn = SharedPrefs.getBool(Constants.IS_LOGGED_ID);
      bool? rememberMe = SharedPrefs.getBool(Constants.REMEMBER_ME);

      if ((isLoggedIn ?? false) && (rememberMe ?? false)) {
        // Move to dashboard
        Navigator.pushReplacementNamed(
          context,
          RouteConstantName.dashboardScreen,
        );
      } else {
        // Move to login screen
        Navigator.pushReplacementNamed(
          context,
          RouteConstantName.authenticationScreen,
        );
      }
    });
  }

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

          // Logo & Text overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.sp),
                child: Image.asset(
                  AssetImages.dawateIslamiWhiteLogo,
                  width: 160.sp,
                  height: 160.sp,
                ),
              ),
              SizedBox(height: 24.sp),
              GradientText(
                'Dawat-e-Islami',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 38.sp,
                ),
                colors: [
                  Colors.orange,
                  Colors.pink,
                ],
              ),
              CustomText(
                text: "Islam For Ever",
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}
