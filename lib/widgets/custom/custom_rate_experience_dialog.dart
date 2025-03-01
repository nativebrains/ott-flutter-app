import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/widgets/custom/custom_elevated_button.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';

import '../../../constants/error_message.dart';
import '../../constants/app_colors.dart';
import 'custom_text_field.dart';

class CustomRateExperienceDialog extends StatefulWidget {
  final Widget? logo; // Instead of ImageProvider, let's use Widget
  final String? message;
  final String? title;
  final String buttonText;
  final Function(int, String) onButtonPressed;

  CustomRateExperienceDialog({
    this.logo,
    this.title,
    this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  State<CustomRateExperienceDialog> createState() =>
      _CustomRateExperienceDialogState();
}

class _CustomRateExperienceDialogState
    extends State<CustomRateExperienceDialog> {
  int rating = 0;
  String review = " ";
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 20.sp,
                right: 12.sp), // Add some space for the close button

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
                    if (widget.logo != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: widget.logo, // Directly use the logo widget
                      ),
                    if (widget.logo == null)
                      SizedBox(
                        height: 12.sp,
                      ),
                    if (widget.title != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.sp),
                        child: CustomText(
                          text: widget.title!,
                          fontSize: 21.sp,
                          textAlign: TextAlign.center,
                          color: ColorCode.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (widget.message != null)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.sp),
                        child: CustomText(
                          text: widget.message.toString(),
                          fontSize: 14.sp,
                          textAlign: TextAlign.center,
                          color: ColorCode.greyTextColor,
                        ),
                      ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40.sp,
                      tapOnlyMode: true,
                      updateOnDrag: true,
                      ratingWidget: RatingWidget(
                        full: Icon(Icons.star_rounded,
                            color: Colors.yellow.shade600),
                        half: Icon(Icons.star_rounded,
                            color: Colors.yellow.shade600),
                        empty: Icon(Icons.star_rounded,
                            color: Colors.grey.shade400),
                      ),
                      onRatingUpdate: (newRating) {
                        rating = newRating.floor().toInt();
                      },
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.sp),
                      padding: EdgeInsets.symmetric(vertical: 2.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.grey.shade400),
                        color: Colors.white,
                      ),
                      child: CustomTextField(
                        hintText: 'Write a review',
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        fillColor: Colors.white,
                        textStyle:
                            TextStyle(color: Colors.black), // Add this line
                        onChanged: (value) {
                          review = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 8.sp),
                      child: CustomElevatedButton(
                        label: widget.buttonText,
                        onPressed: () {
                          if (rating <= 0.0) {
                            showCustomToast(
                              context,
                              "Star Rating is Missing",
                            );
                            return;
                          } else if (review.isEmpty ||
                              review == " " ||
                              review.trim() == "") {
                            showCustomToast(
                              context,
                              "Review is Missing",
                            );
                            return;
                          } else {
                            widget.onButtonPressed(rating, review);
                          }
                        },
                        textColor: Colors.white,
                        backgroundColor: ColorCode.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        padding: EdgeInsets.all(20.0),
                        elevation: 3.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
      ),
    );
  }
}
