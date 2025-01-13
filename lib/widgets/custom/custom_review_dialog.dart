import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';

import '../../constants/app_colors.dart';

class CustomReviewDialog extends StatelessWidget {
  final List<String> reviewRatingList;

  CustomReviewDialog(
    this.reviewRatingList,
  );

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.sp),
                child: CustomText(
                  text: "Review",
                  fontSize: 21.sp,
                  textAlign: TextAlign.left,
                  color: ColorCode.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ..._buildReviewList(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildReviewList() {
    List<Widget> widgets = [];

    for (var i = 0; i < reviewRatingList.length; i++) {
      widgets.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
        child: Container(
          child: Text(reviewRatingList[i]),
        ),
      ));

      if (i < reviewRatingList.length - 1) {
        widgets.add(SizedBox(
          height: 6.sp,
        ));
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Divider(
            height: 2.sp,
            thickness: 1.5.sp,
          ),
        ));
        widgets.add(SizedBox(
          height: 6.sp,
        ));
      }
    }

    return widgets;
  }
}
