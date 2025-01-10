import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/features/purchase/models/ItemPlanModel.dart';
import 'package:islamforever/features/purchase/providers/PurchaseProvider.dart';
import 'package:islamforever/utils/extras.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_message.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../account/providers/AccountProvider.dart';

class Subscriptionplanscreen extends StatefulWidget {
  const Subscriptionplanscreen({super.key});

  @override
  State<Subscriptionplanscreen> createState() => _SubscriptionplanscreenState();
}

class _SubscriptionplanscreenState extends State<Subscriptionplanscreen> {
  late PurchaseProvider purchaseProvider;
  late AccountProvider accountProvider;
  int _selectedPlan = 0; // Selected radio button index

  @override
  void initState() {
    super.initState();
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    purchaseProvider = Provider.of<PurchaseProvider>(context, listen: false);
    if (PurchaseProvider.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        purchaseProvider.fetchPurchasePlans();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    purchaseProvider = Provider.of<PurchaseProvider>(context);
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [if (!purchaseProvider.isLoading) getPurchaseData()],
              ),
            ),
            if (purchaseProvider.isLoading) const LoaderWidget(),
          ],
        ),
      ),
    );
  }

  Widget getPurchaseData() {
    return Column(
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
                ...List.generate(purchaseProvider.plansList.length, (index) {
                  var item = purchaseProvider.plansList[index];
                  return _buildPlanOption(
                    index: index,
                    price: item.planPrice ?? "",
                    duration:
                        "${item.planCurrencyCode} / For ${item.planDuration}",
                    planName: item.planName ?? "",
                  );
                }),
                SizedBox(height: 30.sp),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomElevatedButton(
                    label: 'PROCEED',
                    onPressed: () {
                      checkPurchaseAndNavigate();
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
      ],
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

  void checkPurchaseAndNavigate() async {
    ItemPlanModel? itemPlanModel =
        purchaseProvider.plansList.elementAtOrNull(_selectedPlan);
    if (itemPlanModel != null) {
      // Item is free Purchase it now
      if (toDouble(itemPlanModel.planPrice) == 0.0) {
        bool isSuccess = await purchaseProvider.purchasePlan(
            itemPlanModel.planId, '-', "N/A", "", "");
        showCustomToast(context, PurchaseProvider.statusMessage,
            backgroudnColor: isSuccess ? Colors.green : Colors.red);
        if (isSuccess) {
          await accountProvider.fetchProfileDetails();
          Navigator.of(context).pop();
        }
      } else {
        Navigator.pushNamed(
          context,
          RouteConstantName.paymentMethodScreen,
        );
      }
    }
  }
}
