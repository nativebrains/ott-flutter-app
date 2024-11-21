import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/features/authentication/screens/AuthenticationScreen.dart';
import 'package:islamforever/features/dashboard/screens/DashboardScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../constants/assets_images.dart';
import '../constants/routes_names.dart';
import '../features/splash/screens/SplashScreen.dart';
import '../widgets/custom/custom_elevated_button.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstantName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(
            name: RouteConstantName.splashScreen,
          ),
        );
      case RouteConstantName.dashboardScreen:
        return MaterialPageRoute(
          builder: (context) => const Dashboardscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.dashboardScreen,
          ),
        );

      case RouteConstantName.authenticationScreen:
        return MaterialPageRoute(
          builder: (context) => const Authenticationscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.authenticationScreen,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<String> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: ColorCode.scaffoldBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(30.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AssetImages.dawateIslamiWhiteLogo,
                  width: context.screenWidth,
                  height: 200.sp,
                ),
                SizedBox(height: 30.sp),
                Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.sp),
                CustomElevatedButton(
                  label: "Go Back Home",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteConstantName.dashboardScreen,
                    );
                  },
                  textColor: Colors.white,
                  backgroundColor: ColorCode.mainColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  padding: EdgeInsets.all(20.0),
                  elevation: 3.sp,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
