import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/utils/extensions_utils.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteConstantName.splashScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const SplashScreen(),
      //     settings: const RouteSettings(
      //       name: RouteConstantName.splashScreen,
      //     ),
      //   );

      default:
        return _errorRoute();
    }
  }

  static Route<String> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(30.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5, // Adjust elevation as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Ensure image corners are also rounded
                    child: Image.asset(
                      "AssetImages.sorryPageNotFound",
                      width: context.screenWidth,
                      height: 200.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30.sp),
                Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.sp),
                // CustomElevatedButton(
                //   label: "Go Back Home",
                //   onPressed: () {
                //     Navigator.pushReplacementNamed(
                //       context,
                //       "RouteConstantName.dashboardScreen",
                //     );
                //   },
                //   textColor: Colors.white,
                //   backgroundColor: ColorCode.mainColor,
                //   fontSize: 13.sp,
                //   fontWeight: FontWeight.bold,
                //   padding: EdgeInsets.all(20.0),
                //   elevation: 3.sp,
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
