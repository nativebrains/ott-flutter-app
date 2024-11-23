import 'dart:math';

import 'package:flutter/material.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';
import '../../dashboard/widgets/CustomVerticalCard.dart';

class Mixscreen extends StatefulWidget {
  const Mixscreen({super.key});

  @override
  State<Mixscreen> createState() => _MixscreenState();
}

class _MixscreenState extends State<Mixscreen> {
  List<Widget> _items = [];
  bool isVertical = false;

  @override
  void initState() {
    super.initState();
    refreshItemsList();
  }

  void refreshItemsList() {
    for (int i = 0; i < 10; i++) {
      _items.add(
        Row(
          children: List.generate(
            isVertical ? 3 : 2,
            (index) => Expanded(
              child: Container(
                  margin: EdgeInsets.all(6),
                  child: isVertical
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
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          DashboardProvider.selectedMixScreenContentTypeName,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
