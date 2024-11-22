import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Add this line
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/profile_bg.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 150.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 110.sp),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage:
                              AssetImage(AssetImages.dawateIslamiLogo),
                        ),
                        SizedBox(height: 8.sp),
                        CustomText(
                          text: "Test",
                          color: ColorCode.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                        SizedBox(height: 4.sp),
                        CustomText(
                          text: "test@mailinator.com",
                          color: ColorCode.greyColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.sp,
            ),
            getMemberShipCard(),
            SizedBox(
              height: 30.sp,
            ),
            getAccountCard(),
            SizedBox(
              height: 30.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget getMemberShipCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: Center(
              child: CustomText(
                text: "Member Ship",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            children: [
              SizedBox(
                width: 24.sp,
              ),
              CustomText(
                text: "Current Plan : ",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                decoration: BoxDecoration(
                  color: ColorCode.cardInfoHighlight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CustomText(
                  text: "N/A",
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
              )
            ],
          ),
          SizedBox(
            height: 8.sp,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: CustomText(
              text: "Subscription expires on N/A",
              color: ColorCode.whiteColor,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomElevatedButton(
              label: 'Upgrade Plan',
              onPressed: () {},
              textColor: ColorCode.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.all(12.0),
              elevation: 3.sp,
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget getAccountCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorCode.cardInfoBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.sp),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorCode.cardInfoHeader,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), // Rounded top-left corner
                topRight: Radius.circular(10), // Rounded top-right corner
              ),
            ),
            child: Center(
              child: CustomText(
                text: "Account",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ),
          Divider(
            height: 1.sp,
            color: Colors.grey.shade800,
          ),
          SizedBox(
            height: 16.sp,
          ),
          customContainer(
              CustomText(
                text: "Dashboard",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.normal,
              ),
              () {}),
          customContainer(
              CustomText(
                text: "Edit Profile",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.normal,
              ),
              () {}),
          customContainer(
              CustomText(
                text: "Delete Account",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.normal,
              ),
              () {}),
          SizedBox(
            height: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomElevatedButton(
              label: 'Logout',
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteConstantName.authenticationScreen,
                );
              },
              textColor: ColorCode.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              padding: EdgeInsets.all(12.0),
              elevation: 3.sp,
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget customContainer(Widget child, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 12.sp),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 6.sp),
        decoration: BoxDecoration(
          color: ColorCode.cardInfoHeader,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
