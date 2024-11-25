import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';
import '../../dashboard/widgets/CustomVerticalCard.dart';

class Mixscreen extends StatefulWidget {
  const Mixscreen({super.key});

  @override
  State<Mixscreen> createState() => _MixscreenState();
}

class _MixscreenState extends State<Mixscreen> {
  late DashboardProvider _dashboardProvider;

  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    refreshItemsList();
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _dashboardProvider.addListener(refreshItemsList);
  }

  @override
  void dispose() {
    _dashboardProvider.removeListener(refreshItemsList);
    super.dispose();
  }

  void refreshItemsList() {
    _items.clear(); // Clear the list
    for (int i = 0; i < 10; i++) {
      _items.add(
        Row(
          children: List.generate(
            DashboardProvider.selectedMixScreenContentType ==
                    MediaContentType.movies
                ? 3
                : 2,
            (index) => Expanded(
              child: Container(
                  margin: EdgeInsets.all(6),
                  child: DashboardProvider.selectedMixScreenContentType ==
                          MediaContentType.movies
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 20.sp),
          child: Column(
            children: [..._items],
          ),
        ),
      ),
    );
  }
}
