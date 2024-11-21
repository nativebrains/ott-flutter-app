import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  @override
  Widget build(BuildContext context) {
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
  }
}
