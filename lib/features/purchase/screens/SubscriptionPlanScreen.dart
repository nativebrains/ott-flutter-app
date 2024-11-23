import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';

import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';

class Subscriptionplanscreen extends StatefulWidget {
  const Subscriptionplanscreen({super.key});

  @override
  State<Subscriptionplanscreen> createState() => _SubscriptionplanscreenState();
}

class _SubscriptionplanscreenState extends State<Subscriptionplanscreen> {
  int _selectedPlan = 0; // Selected radio button index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Close Button (Top-Right Corner)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),

              // Title
              CustomText(
                text: "Subscription Plan",
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomText(
                  text:
                      "Full access to all free and premium content with download also. Choose a plan based on your usage. Below there are plan names, prices, and validity days. For exploring, select the free plan.",
                  fontSize: 14.0,
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.0),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorCode.cardInfoBg,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: CustomText(
                      text: "Select Your Subscription Plan",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1.sp,
                color: Colors.grey.withOpacity(0.3),
              ),
              Container(
                  color: ColorCode.cardInfoBg,
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      _buildPlanOption(
                        index: 0,
                        price: "10.00",
                        duration: "USD / For 7 Day(s)",
                        planName: "Basic Plan",
                      ),
                      _buildPlanOption(
                        index: 1,
                        price: "29.99",
                        duration: "USD / For 1 Month(s)",
                        planName: "Premium Plan",
                      ),
                      _buildPlanOption(
                        index: 2,
                        price: "99.00",
                        duration: "USD / For 6 Month(s)",
                        planName: "Platinum Plan",
                      ),
                      _buildPlanOption(
                        index: 3,
                        price: "149.00",
                        duration: "USD / For 1 Year(s)",
                        planName: "Diamond Plan",
                      ),
                      SizedBox(height: 30.sp),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomElevatedButton(
                          label: 'PROCEED',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteConstantName.paymentMethodScreen,
                            );
                          },
                          textColor: ColorCode.whiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          padding: EdgeInsets.all(16.0),
                          elevation: 3.sp,
                        ),
                      ),
                      SizedBox(height: 30.sp)
                    ],
                  )),

              // Radio Button Options
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanOption({
    required int index,
    required String price,
    required String duration,
    required String planName,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = index;
        });
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.sp),
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: _selectedPlan == index
                  ? ColorCode.planSelect
                  : ColorCode.planNormal,
              borderRadius: BorderRadius.circular(8.0),
              border: _selectedPlan == index
                  ? Border.all(color: Colors.pink, width: 2.0)
                  : null,
            ),
            child: Row(
              children: [
                // Radio Button
                Icon(
                  _selectedPlan == index
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _selectedPlan == index ? Colors.pink : Colors.white,
                ),
                SizedBox(width: 16.0),

                // Plan Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: price,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 12.sp,
                        ),
                        CustomText(
                          text: duration,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    CustomText(
                      text: planName,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/wave_bg.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
