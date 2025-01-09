import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/account/providers/AccountProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_dialog_notify.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/extra/rounded_network_image.dart';

class Accountscreen extends StatefulWidget {
  const Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  late AccountProvider accountProvider;

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    if (AccountProvider.isLoggedIn) {
      accountProvider.fetchDashboardAccountDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max, // Add this line
              children: [
                if (!accountProvider.isLoading)
                  if (AccountProvider.isLoggedIn)
                    getLoggedInDashboard()
                  else
                    getLoggedOutDashbaord(),
              ],
            ),
          ),
          if (accountProvider.isLoading) const LoaderWidget(),
        ],
      ),
    );
  }

  Widget getLoggedOutDashbaord() {
    return Column(
      mainAxisSize: MainAxisSize.max, // Set the main axis size to min
      children: [
        SizedBox(
          height: 240.sp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomText(
            text: "You have to Login First to Access the Profile!",
            color: ColorCode.whiteColor,
            fontWeight: FontWeight.normal,
            fontSize: 18.sp,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomElevatedButton(
            label: 'Login',
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteConstantName.authenticationScreen,
              );
            },
            textColor: ColorCode.whiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            padding: EdgeInsets.all(20.0),
            elevation: 3.sp,
          ),
        ),
      ],
    );
  }

  Widget getLoggedInDashboard() {
    return Column(
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
                    RoundedNetworkImage(
                      imageUrl:
                          accountProvider.itemDashBoardModel?.userImage ?? "",
                      fit: BoxFit.cover,
                      width: 75.sp,
                      height: 75.sp,
                    ),
                    SizedBox(height: 8.sp),
                    CustomText(
                      text: accountProvider.itemDashBoardModel?.userName ?? "",
                      color: ColorCode.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                    SizedBox(height: 4.sp),
                    CustomText(
                      text: accountProvider.itemDashBoardModel?.userEmail ?? "",
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
                  text: accountProvider
                              .itemDashBoardModel?.currentPlan?.isEmpty ??
                          true
                      ? "N/A"
                      : accountProvider.itemDashBoardModel?.currentPlan ??
                          "N/A",
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
              text: accountProvider.itemDashBoardModel?.expiresOn?.isEmpty ??
                      true
                  ? "Subscription expires on N/A"
                  : ("Subscription expires on ${accountProvider.itemDashBoardModel!.expiresOn}"),
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
              ), () {
            Navigator.pushNamed(
                context, RouteConstantName.accountDashboardScreen);
          }),
          customContainer(
              CustomText(
                text: "Edit Profile",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.normal,
              ), () {
            Navigator.pushNamed(context, RouteConstantName.profileScreen);
          }),
          customContainer(
              CustomText(
                text: "Delete Account",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.normal,
              ), () {
            showDeleteAccountDialog(context);
          }),
          SizedBox(
            height: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomElevatedButton(
              label: 'Logout',
              onPressed: () {
                _showLogoutDialog(context, (isLogout) async {
                  if (isLogout) {
                    bool isSuccess = await accountProvider.logout();
                    if (isSuccess) {
                      showCustomToast(context, "Logout Successfully!");
                      Navigator.pushReplacementNamed(
                        context,
                        RouteConstantName.splashScreen,
                      );
                    }
                  }
                });
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

  void _showLogoutDialog(BuildContext context, Function(bool) callback) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (BuildContext context) {
        return CustomNotifyDialog(
          title: "Are you sure you want to Logout?",
          buttonText: "Confirm",
          onButtonPressed: () async {
            Navigator.of(context).pop(); // For closing the dialog
            callback(true);
          },
        );
      },
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.all(16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: CustomText(
                    text: "Delete Account",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            CustomText(
              text:
                  "All your data including your subscription will be erased and cannot be recovered. No refund will be made. Are you sure you want to delete your account",
              textAlign: TextAlign.justify,
              fontSize: 14.0,
              color: Colors.black54,
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: CustomText(
                    text: "Cancel",
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your delete account logic here
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: CustomText(
                    text: "Delete",
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
