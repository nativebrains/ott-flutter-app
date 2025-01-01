import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/features/account/screens/AccountDashboardScreen.dart';
import 'package:islamforever/features/account/screens/ProfileScreen.dart';
import 'package:islamforever/features/authentication/screens/AuthenticationScreen.dart';
import 'package:islamforever/features/authentication/screens/ForgotPasswordScreen.dart';
import 'package:islamforever/features/authentication/screens/RegisterScreen.dart';
import 'package:islamforever/features/account/screens/AccountScreen.dart';
import 'package:islamforever/features/dashboard/screens/DashboardScreen.dart';
import 'package:islamforever/features/dashboard/screens/HomeScreen.dart';
import 'package:islamforever/features/dashboard/screens/SeeAllScreen.dart';
import 'package:islamforever/features/details/screens/DetailsScreen.dart';
import 'package:islamforever/features/mix/screens/MixScreen.dart';
import 'package:islamforever/features/dashboard/screens/SearchScreen.dart';
import 'package:islamforever/features/purchase/screens/PaymentMethodScreen.dart';
import 'package:islamforever/features/purchase/screens/PaymentScreen.dart';
import 'package:islamforever/features/purchase/screens/SubscriptionPlanScreen.dart';
import 'package:islamforever/features/settings/screens/AboutScreen.dart';
import 'package:islamforever/features/settings/screens/SettingsScreen.dart';
import 'package:islamforever/features/watchlist/screens/WatchListScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../constants/assets_images.dart';
import '../constants/routes_names.dart';
import '../features/splash/screens/SplashScreen.dart';
import '../features/webview/screens/WebviewScreen.dart';
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
      case RouteConstantName.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const Forgotpasswordscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.forgotPasswordScreen,
          ),
        );
      case RouteConstantName.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const Registerscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.registerScreen,
          ),
        );

      case RouteConstantName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const Homescreen(),
          settings: const RouteSettings(
            name: RouteConstantName.homeScreen,
          ),
        );
      case RouteConstantName.watchListScreen:
        return MaterialPageRoute(
          builder: (context) => const Watchlistscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.watchListScreen,
          ),
        );

      case RouteConstantName.mixScreen:
        return MaterialPageRoute(
          builder: (context) => const Mixscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.mixScreen,
          ),
        );

      case RouteConstantName.settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const Settingsscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.settingsScreen,
          ),
        );

      case RouteConstantName.accountScreen:
        return MaterialPageRoute(
          builder: (context) => const Accountscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.accountScreen,
          ),
        );

      case RouteConstantName.searchScreen:
        return MaterialPageRoute(
          builder: (context) => const Searchscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.searchScreen,
          ),
        );

      case RouteConstantName.aboutScreen:
        return MaterialPageRoute(
          builder: (context) => const Aboutscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.aboutScreen,
          ),
        );

      case RouteConstantName.webviewScreen:
        var args = settings.arguments as WebviewScreen;
        return MaterialPageRoute(
          builder: (context) => WebviewScreen(
            webviewType: args.webviewType,
          ),
          settings: const RouteSettings(
            name: RouteConstantName.webviewScreen,
          ),
        );
      case RouteConstantName.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const Profilescreen(),
          settings: const RouteSettings(
            name: RouteConstantName.profileScreen,
          ),
        );

      case RouteConstantName.accountDashboardScreen:
        return MaterialPageRoute(
          builder: (context) => const AccountDashboardScreen(),
          settings: const RouteSettings(
            name: RouteConstantName.accountDashboardScreen,
          ),
        );

      case RouteConstantName.subscriptionPlanScreen:
        return MaterialPageRoute(
          builder: (context) => const Subscriptionplanscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.subscriptionPlanScreen,
          ),
        );

      case RouteConstantName.paymentMethodScreen:
        return MaterialPageRoute(
          builder: (context) => const Paymentmethodscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.paymentMethodScreen,
          ),
        );

      case RouteConstantName.paymentScreen:
        return MaterialPageRoute(
          builder: (context) => const Paymentscreen(),
          settings: const RouteSettings(
            name: RouteConstantName.paymentScreen,
          ),
        );
      case RouteConstantName.seeAllScreen:
        final args = settings.arguments as SeeAllScreenArguments;
        return MaterialPageRoute(
          builder: (context) => Seeallscreen(
            title: args.title,
            isVertical: args.isVertical,
          ),
          settings: const RouteSettings(
            name: RouteConstantName.seeAllScreen,
          ),
        );
      case RouteConstantName.detailsScreen:
        final args = settings.arguments as DetailsScreenArguments;
        return MaterialPageRoute(
          builder: (context) => Detailsscreen(
            detailsScreenArguments: args,
          ),
          settings: const RouteSettings(
            name: RouteConstantName.detailsScreen,
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
