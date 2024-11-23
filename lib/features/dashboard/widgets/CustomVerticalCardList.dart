import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/constants/assets_images.dart';

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
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: [
                      Image.network(
                        entry.value,
                        fit: BoxFit.cover,
                        width: 115.sp,
                        height: 165.sp,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: widget
                                .isPremium // Replace with your boolean variable
                            ? Container(
                                margin: EdgeInsets.all(6.sp),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orange,
                                      Colors.pink,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.sp),
                                  child: Image.asset(
                                    AssetImages.icSubscribe,
                                    width: 14,
                                    height: 14,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ));
          }).toList(),
        ),
      ),
    );
  }
}
