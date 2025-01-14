import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../../widgets/custom/custom_text_field.dart';

class CouponDialog extends StatelessWidget {
  final TextEditingController _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: ColorCode.tabBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomText(
                text: "Coupon Code",
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 16.0),

          // Description
          Text(
            "Enter your coupon code",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),

          // Text Field
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 6.sp),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: ColorCode.inputBgColor),
              color: ColorCode.inputBgColor,
            ),
            child: CustomTextField(
              controller: _couponController,
              hintText: 'Coupon code...',
              hintTextColor: Colors.white,
              initialValue: "", // Set the initial value
              keyboardType: TextInputType.text,
              fillColor: ColorCode.inputBgColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              onChanged: (value) {
                print(value); // Handle the text change
              },
            ),
          ),
          SizedBox(height: 24.0),

          // Buttons (Cancel and Submit)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              CustomElevatedButton(
                label: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: ColorCode.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                padding: EdgeInsets.all(8.0),
                elevation: 3.sp,
                width: 100,
              ),

              CustomElevatedButton(
                label: 'Submit',
                onPressed: () {
                  final couponCode = _couponController.text.trim();
                  if (couponCode.isNotEmpty) {
                    // Handle coupon submission
                    print("Coupon Code: $couponCode");
                  } else {
                    // Show error or feedback
                    print("No coupon code entered.");
                  }
                  Navigator.of(context).pop();
                },
                textColor: ColorCode.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                padding: EdgeInsets.all(8.0),
                elevation: 3.sp,
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 24.sp,
          ),
        ],
      ),
    );
  }
}
