import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/assets_images.dart';
import 'package:islamforever/features/dashboard/widgets/CustomVerticalCard.dart';

class Customverticalcardlist extends StatefulWidget {
  final List<String> imgList;
  final bool isPremium;
  const Customverticalcardlist(
      {super.key, required this.imgList, required this.isPremium});

  @override
  State<Customverticalcardlist> createState() => _CustomverticalcardlistState();
}

class _CustomverticalcardlistState extends State<Customverticalcardlist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.imgList.asMap().entries.map((entry) {
            return Container(
                margin: entry.key == 0
                    ? const EdgeInsets.only(
                        left: 16.0, right: 5.0, top: 5.0, bottom: 5.0)
                    : const EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: Customverticalcard(
                  isPremium: widget.isPremium,
                  url: entry.value,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
