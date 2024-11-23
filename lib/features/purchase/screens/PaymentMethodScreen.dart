import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_rich_text.dart';
import '../../../widgets/custom/custom_text.dart';
import '../widgets/CouponDialog.dart';

class Paymentmethodscreen extends StatefulWidget {
  const Paymentmethodscreen({super.key});

  @override
  State<Paymentmethodscreen> createState() => _PaymentmethodscreenState();
}

class _PaymentmethodscreenState extends State<Paymentmethodscreen> {
  int _selectedPlan = 0; // Selected radio button index
  int _selectedPaymentOptions = -1; // Selected radio button index

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
                padding: const EdgeInsets.only(top: 12.0, right: 8),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildPlanOption(
                  index: 0,
                  price: "10.00",
                  duration: "USD / For 7 Day(s)",
                  planName: "Basic Plan",
                ),
              ),
              SizedBox(
                height: 20,
              ),

              getMemberShipCard(),
              SizedBox(height: 24.0),
              // Title
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CouponDialog(),
                  );
                },
                child: CustomText(
                  text: "I have coupon code",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.pink,
                ),
              ),

              SizedBox(height: 24.0),

              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.sp),
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
                      text: "Payment Options",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Container(
                  color: ColorCode.cardInfoBg,
                  margin: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Column(
                    children: [
                      Divider(
                        height: 1.sp,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      SizedBox(height: 16.0),
                      _buildPaymentOption(
                        index: 0,
                        name: "Stripe",
                      ),
                      SizedBox(height: 30.sp),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomElevatedButton(
                          label: 'PROCEED',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteConstantName.paymentScreen,
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
                text: "User Information",
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
                text: "You have selected :-",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                decoration: BoxDecoration(
                  color: ColorCode.cardInfoHighlight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CustomText(
                  text: "Basic Plan",
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Flexible(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10, // Space between widgets horizontally
                    runSpacing: 5,
                    children: [
                      CustomRichText(
                        leadingText: "You are logged in as ",
                        actionText: "awaismansha1998@gmail.com",
                        fontSize: 15.sp,
                        leadingTextColor: ColorCode.whiteColor,
                        actionTextColor: Colors.pink,
                        isActionUnderlined: true,
                        onActionTap: () {
                          // Handle action tap
                        },
                      ),
                      CustomRichText(
                        leadingText:
                            ". if you want to user a different account for this subscription,",
                        actionText: "Logout Now.",
                        fontSize: 15.sp,
                        leadingTextColor: ColorCode.whiteColor,
                        actionTextColor: Colors.pink,
                        isActionUnderlined: false,
                        onActionTap: () {
                          // Handle action tap
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomElevatedButton(
              label: 'Change Plan',
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: ColorCode.whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
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

  Widget _buildPaymentOption({
    required int index,
    required String name,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentOptions = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.sp),
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: _selectedPaymentOptions == index
              ? ColorCode.planSelect
              : ColorCode.planNormal,
          borderRadius: BorderRadius.circular(8.0),
          border: _selectedPaymentOptions == index
              ? Border.all(color: Colors.pink, width: 2.0)
              : null,
        ),
        child: Row(
          children: [
            // Radio Button
            Icon(
              _selectedPaymentOptions == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color:
                  _selectedPaymentOptions == index ? Colors.pink : Colors.white,
            ),
            SizedBox(width: 16.0),

            // Plan Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
