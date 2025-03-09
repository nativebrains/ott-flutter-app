import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/assets_images.dart';
import '../../../constants/constants.dart';
import '../../../constants/routes_names.dart';
import '../../../core/services/shared_preference.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../account/providers/AccountProvider.dart';
import '../../settings/providers/SettingsProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SettingsProvider settingsProvider;
  late AccountProvider accountProvider;
  @override
  void initState() {
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    _navigateToJourney();
    super.initState();
  }

  _navigateToJourney() async {
    await settingsProvider.fetchAboutData(refresh: true);
    await Future.delayed(const Duration(seconds: 1), () {
      OneSignal.Notifications.requestPermission(true);

      bool? isLoggedIn = SharedPrefs.getBool(Constants.IS_LOGGED_ID);
      bool? rememberMe = SharedPrefs.getBool(Constants.REMEMBER_ME);

      if ((isLoggedIn ?? false) && (rememberMe ?? false)) {
        // Move to dashboard
        Navigator.pushReplacementNamed(
          context,
          RouteConstantName.dashboardScreen,
        );
      } else {
        accountProvider.logout();
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
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(AssetImages.loginBg),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),

          // Logo & Text overlay
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.sp),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20.sp), // Adjust the corner radius
                  child: Image.asset(
                    AssetImages.dawateIslamiWhiteLogo,
                    width: 160.sp,
                    height: 160.sp,
                  ),
                ),
              ),
              SizedBox(height: 24.sp),
              GradientText(
                'Islam Forever',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 38.sp,
                ),
                colors: [
                  ColorCode.greenStartColor,
                  ColorCode.greenStartColor,
                ],
              ),
              SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}
