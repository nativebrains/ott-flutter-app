import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/error_message.dart';
import 'package:islamforever/features/purchase/models/ItemPlanModel.dart';
import 'package:islamforever/features/purchase/providers/PurchaseProvider.dart';
import 'package:islamforever/features/purchase/screens/PaymentScreen.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_dialog_notify.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_rich_text.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../account/providers/AccountProvider.dart';
import '../widgets/CouponDialog.dart';

class PaymentmethodScreenArguments {
  final ItemPlanModel itemPlanModel;

  PaymentmethodScreenArguments({
    required this.itemPlanModel,
  });
}

class Paymentmethodscreen extends StatefulWidget {
  final PaymentmethodScreenArguments paymentmethodScreenArguments;
  const Paymentmethodscreen({
    super.key,
    required this.paymentmethodScreenArguments,
  });

  @override
  State<Paymentmethodscreen> createState() => _PaymentmethodscreenState();
}

class _PaymentmethodscreenState extends State<Paymentmethodscreen> {
  late AccountProvider accountProvider;
  late PurchaseProvider purchaseProvider;

  bool _isloading = false;

  int _selectedPlan = 0; // Selected radio button index
  int _selectedPaymentOptions = -1; // Selected radio button index

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    purchaseProvider = Provider.of<PurchaseProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isloading = true;
      });
      await accountProvider.fetchProfileDetails();
      await purchaseProvider.fetchPaymentGateways();
      setState(() {
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    purchaseProvider = Provider.of<PurchaseProvider>(context);
    ItemPlanModel itemPlanModel =
        widget.paymentmethodScreenArguments.itemPlanModel;
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            if (!_isloading)
              SingleChildScrollView(
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
                        price: itemPlanModel.planPrice ?? "",
                        duration:
                            "${itemPlanModel.planCurrencyCode} / For ${itemPlanModel.planDuration}",
                        planName: itemPlanModel.planName ?? "",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    getMemberShipCard(itemPlanModel),
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
                        color: Colors.greenAccent,
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
                            ...List.generate(
                              purchaseProvider.paymentGatewaysList.length,
                              (index) => _buildPaymentOption(
                                index: index,
                                name: purchaseProvider
                                        .paymentGatewaysList[index]
                                        .gatewayName ??
                                    "",
                              ),
                            ),
                            SizedBox(height: 30.sp),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: CustomElevatedButton(
                                label: 'PROCEED',
                                onPressed: () {
                                  if (_selectedPaymentOptions == -1) {
                                    showCustomToast(
                                        context, "No Gateway Selected");
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      RouteConstantName.paymentScreen,
                                      arguments: PaymentScreenArguments(
                                        itemPaymentSetting: purchaseProvider
                                                .paymentGatewaysList[
                                            _selectedPaymentOptions],
                                        itemPlanModel: itemPlanModel,
                                      ),
                                    );
                                  }
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
            if (_isloading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  Widget getMemberShipCard(ItemPlanModel itemPlanModel) {
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
                text: "You have selected :- ",
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              Flexible(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                  decoration: BoxDecoration(
                    color: ColorCode.cardInfoHighlight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: CustomText(
                    text: itemPlanModel.planName ?? "",
                    color: ColorCode.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.sp,
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
                        actionText:
                            accountProvider.itemDashBoardModel?.userEmail ?? "",
                        fontSize: 15.sp,
                        leadingTextColor: ColorCode.whiteColor,
                        actionTextColor: Colors.greenAccent,
                        isActionUnderlined: false,
                        onActionTap: () {
                          // Handle action tap
                        },
                      ),
                      CustomRichText(
                        leadingText:
                            ". if you want to user a different account for this subscription, ",
                        actionText: "Logout Now.",
                        fontSize: 15.sp,
                        leadingTextColor: ColorCode.whiteColor,
                        actionTextColor: Colors.greenAccent,
                        isActionUnderlined: true,
                        onActionTap: () {
                          _showLogoutDialog(context, (isLogout) async {
                            if (isLogout) {
                              bool isSuccess = await accountProvider.logout();
                              if (isSuccess) {
                                showCustomToast(
                                    context, "Logout Successfully!");
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacementNamed(
                                    context, RouteConstantName.splashScreen);
                              }
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.sp,
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
                  ? Border.all(color: Colors.greenAccent, width: 2.0)
                  : null,
            ),
            child: Row(
              children: [
                // Radio Button
                Icon(
                  _selectedPlan == index
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: _selectedPlan == index
                      ? Colors.greenAccent
                      : Colors.white,
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
              ? Border.all(color: Colors.greenAccent, width: 2.0)
              : null,
        ),
        child: Row(
          children: [
            // Radio Button
            Icon(
              _selectedPaymentOptions == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: _selectedPaymentOptions == index
                  ? Colors.greenAccent
                  : Colors.white,
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
