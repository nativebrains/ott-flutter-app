import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/purchase/models/ItemPaymentSetting.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../models/ItemPlanModel.dart';

class PaymentScreenArguments {
  final ItemPaymentSetting itemPaymentSetting;
  final ItemPlanModel itemPlanModel;

  PaymentScreenArguments({
    required this.itemPaymentSetting,
    required this.itemPlanModel,
  });
}

class Paymentscreen extends StatefulWidget {
  final PaymentScreenArguments paymentScreenArguments;
  const Paymentscreen({
    super.key,
    required this.paymentScreenArguments,
  });

  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
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
              "Payment",
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
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20.sp),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 250.sp),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomElevatedButton(
                      label:
                          'Pay :${widget.paymentScreenArguments.itemPlanModel.planPrice} ${widget.paymentScreenArguments.itemPlanModel.planCurrencyCode} via ${widget.paymentScreenArguments.itemPaymentSetting.gatewayName}',
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                      textColor: ColorCode.whiteColor,
                      hideGradient: true,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      padding: EdgeInsets.all(12.0),
                      elevation: 3.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
