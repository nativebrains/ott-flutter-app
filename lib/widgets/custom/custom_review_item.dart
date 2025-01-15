import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/ApiEndpoints.dart';
import 'package:islamforever/features/details/models/ReviewModel.dart';
import 'package:islamforever/widgets/custom/custom_text.dart';

import '../../constants/app_colors.dart';
import '../../utils/extras.dart';
import '../extra/rounded_network_image.dart';

class CustomReviewItem extends StatefulWidget {
  ReviewModel reviewRatingModel;
  CustomReviewItem({super.key, required this.reviewRatingModel});

  @override
  State<CustomReviewItem> createState() => _CustomReviewItemState();
}

class _CustomReviewItemState extends State<CustomReviewItem> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.reviewRatingModel.user?.userImage ?? "";
    if (!imageUrl.startsWith("https")) {
      imageUrl = ApiEndpoints.IMAGE_PATH + imageUrl;
    }

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RoundedNetworkImage(
                  imageUrl: imageUrl,
                  width: 57.sp,
                  height: 57.sp,
                  borderRadius: 50.sp,
                ),
              ),
              SizedBox(
                width: 12.sp,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.reviewRatingModel.user?.name ?? "",
                      fontSize: 18.sp,
                      textAlign: TextAlign.start,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12.sp,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: RatingBar(
                  initialRating:
                      widget.reviewRatingModel.rating?.toDouble() ?? 0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20.sp,
                  ignoreGestures: true,
                  ratingWidget: RatingWidget(
                    full:
                        Icon(Icons.star_rounded, color: Colors.yellow.shade600),
                    half:
                        Icon(Icons.star_rounded, color: Colors.yellow.shade600),
                    empty:
                        Icon(Icons.star_rounded, color: Colors.grey.shade400),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.sp,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              text: widget.reviewRatingModel.review ?? "",
              fontSize: 14.sp,
              textAlign: TextAlign.start,
              color: ColorCode.greyLightTextColor,
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 17.sp,
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(
                width: 12.sp,
              ),
              CustomText(
                text: formatDate(
                    DateTime.parse(
                      widget.reviewRatingModel.createdAt ?? "",
                    ),
                    "EEE, dd MMM yyyy hh:mm a"),
                fontSize: 10.sp,
                textAlign: TextAlign.start,
                color: ColorCode.greyLightTextColor,
              ),
            ],
          ),
          SizedBox(
            height: 12.sp,
          ),
        ],
      ),
    );
  }
}
