import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';
import 'package:islamforever/features/dashboard/widgets/CustomVerticalCard.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';

class SeeAllScreenArguments {
  final String title;
  final bool isVertical;
  final String? id;
  final String? type;

  SeeAllScreenArguments({
    required this.title,
    required this.isVertical,
    required this.id,
    required this.type,
  });
}

class Seeallscreen extends StatefulWidget {
  final String title;
  final bool isVertical;
  const Seeallscreen(
      {super.key, required this.isVertical, required this.title});

  @override
  State<Seeallscreen> createState() => _SeeallscreenState();
}

class _SeeallscreenState extends State<Seeallscreen> {
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _items.add(
        Row(
          children: List.generate(
            widget.isVertical ? 3 : 2,
            (index) => Expanded(
              child: Container(
                  margin: EdgeInsets.all(6),
                  child: widget.isVertical
                      ? Customverticalcard(
                          isPremium: false,
                          url: Constants.imgVerticalList[Random()
                              .nextInt(Constants.imgVerticalList.length)])
                      : Customhorizontalcard(
                          isPremium: false,
                          showTitle: true,
                          url: Constants.imgHorizontalList[Random()
                              .nextInt(Constants.imgHorizontalList.length)])),
            ),
          ),
        ),
      );
    }
  }

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
              widget.title,
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
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 20.sp),
            sliver: SliverList(
              delegate: SliverChildListDelegate(_items),
            ),
          ),
        ],
      ),
    );
  }
}
