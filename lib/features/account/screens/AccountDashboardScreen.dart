import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';

class AccountDashboardScreen extends StatefulWidget {
  const AccountDashboardScreen({super.key});

  @override
  State<AccountDashboardScreen> createState() => _AccountDashboardScreenState();
}

class _AccountDashboardScreenState extends State<AccountDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.blackColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with snapping and floating behavior
          SliverAppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Text(
              "Dashbaord",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
            floating: true,
            snap: true,
            expandedHeight: 55.0, // Set height for expanded AppBar
          ),
          // SliverList for your content
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.sp,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 20.sp,
                  ),
                  getUserProfileCard(),
                  SizedBox(
                    height: 20.sp,
                  ),
                  getMemberShipCard(),
                  SizedBox(
                    height: 20.sp,
                  ),
                  getLastInvoiceCard(),
                  SizedBox(
                    height: 50.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLastInvoiceCard() {
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
                text: "Last Invoice",
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
          Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/images/wave_bg.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 16.sp,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Date : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
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
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Plan : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
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
                  Row(
                    children: [
                      SizedBox(
                        width: 24.sp,
                      ),
                      CustomText(
                        text: "Amount : ",
                        color: ColorCode.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.sp, vertical: 6.sp),
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
                  SizedBox(
                    height: 16.sp,
                  ),
                ],
              )
            ],
          ),
        ],
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
                text: "My Subscription",
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
          Stack(children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/wave_bg.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 6.sp),
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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteConstantName.subscriptionPlanScreen,
                      );
                    },
                    textColor: ColorCode.whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    padding: EdgeInsets.all(12.0),
                    borderRadius: 50,
                    elevation: 3.sp,
                    width: 160.sp,
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }

  Widget getUserProfileCard() {
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
                text: "User Profile",
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
          Stack(children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/wave_bg.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 16.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 24.sp),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.pink, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage(AssetImages.dawateIslamiLogo),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Awais Mansha",
                              color: ColorCode.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                            TextScroll(
                              'awaismansha1998@gmail.com',
                              velocity:
                                  Velocity(pixelsPerSecond: Offset(30, 0)),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    CustomElevatedButton(
                      label: 'Edit',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteConstantName.profileScreen,
                        );
                      },
                      textColor: ColorCode.whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      padding: EdgeInsets.all(8.0),
                      elevation: 3.sp,
                      borderRadius: 50,
                      width: 60,
                    ),
                    SizedBox(width: 24.sp),
                  ],
                ),
                SizedBox(
                  height: 16.sp,
                ),
              ],
            ),
          ]),
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
