import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/widgets/custom/custom_elevated_button.dart';

import '../../constants/app_colors.dart';
import 'custom_text.dart'; // Import if you're using flutter_svg

class CustomNotifyDialog extends StatelessWidget {
  final Widget? logo; // Instead of ImageProvider, let's use Widget
  final String? message;
  final String? title;
  final String buttonText;
  final bool showCancelButton;
  final VoidCallback onButtonPressed;

  CustomNotifyDialog({
    this.logo,
    this.title,
    this.message,
    this.showCancelButton = true,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 20.sp, right: 12.sp), // Add some space for the close button

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (logo != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: logo, // Directly use the logo widget
                    ),
                  if (logo == null)
                    SizedBox(
                      height: 12.sp,
                    ),
                  if (title != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14.sp),
                      child: CustomText(
                        text: title!,
                        fontSize: 21.sp,
                        textAlign: TextAlign.center,
                        color: ColorCode.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (message != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.sp),
                      child: CustomText(
                        text: message.toString(),
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                        color: ColorCode.greyTextColor,
                        fontWeight:
                            title == null ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  if (message != null)
                    SizedBox(
                      height: 20.sp,
                    ),
                  if (message == null)
                    SizedBox(
                      height: 12.sp,
                    ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                    child: CustomElevatedButton(
                      label: buttonText,
                      onPressed: onButtonPressed,
                      textColor: Colors.white,
                      backgroundColor: ColorCode.mainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.all(16.sp),
                      elevation: 3.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showCancelButton)
          Positioned(
            right: 0, // Half outside
            top: 2, // Half outside
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40.sp,
                height: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(25.sp), // Half of width and height
                  boxShadow: [
                    // Optional: Add a shadow for better elevation effect
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
