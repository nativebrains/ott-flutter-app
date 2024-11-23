import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../constants/assets_images.dart';

class Customhorizontalcardlist extends StatefulWidget {
  final List<String> imgList;
  final bool isPremium;
  final bool showTitle;
  const Customhorizontalcardlist(
      {super.key,
      required this.imgList,
      required this.isPremium,
      required this.showTitle});

  @override
  State<Customhorizontalcardlist> createState() =>
      _CustomhorizontalcardlistState();
}

class _CustomhorizontalcardlistState extends State<Customhorizontalcardlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.imgList.asMap().entries.map((entry) {
            return Container(
                width: 175.sp,
                margin: entry.key == 0
                    ? const EdgeInsets.only(
                        left: 16.0, right: 5.0, top: 5.0, bottom: 5.0)
                    : const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: Customhorizontalcard(
                  isPremium: widget.isPremium,
                  showTitle: widget.showTitle,
                  url: entry.value,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
