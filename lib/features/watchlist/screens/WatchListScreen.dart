import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';

class Watchlistscreen extends StatefulWidget {
  const Watchlistscreen({super.key});

  @override
  State<Watchlistscreen> createState() => _WatchlistscreenState();
}

class _WatchlistscreenState extends State<Watchlistscreen> {
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _items.add(
        Row(
          children: List.generate(
            2,
            (index) => Expanded(
              child: Container(
                  margin: EdgeInsets.all(6),
                  child: Customhorizontalcard(
                      isPremium: true,
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.sp),
            ..._items,
            SizedBox(height: 12.sp)
          ],
        ),
      ),
    );
  }
}
