import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/dashboard/models/HomeDataModel.dart';
import 'package:islamforever/features/dashboard/models/ItemHomeContentModel.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCard.dart';
import 'package:islamforever/features/dashboard/widgets/CustomVerticalCard.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../providers/DashboardProvider.dart';

class SeeAllScreenArguments {
  final String title;
  final String id;
  final String type;

  SeeAllScreenArguments({
    required this.title,
    required this.id,
    required this.type,
  });
}

class Seeallscreen extends StatefulWidget {
  final SeeAllScreenArguments screenArguments;
  const Seeallscreen({
    super.key,
    required this.screenArguments,
  });

  @override
  State<Seeallscreen> createState() => _SeeallscreenState();
}

class _SeeallscreenState extends State<Seeallscreen> {
  late DashboardProvider dashboardProvider;
  List<Widget> _items = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _fetchData();
  }

  Future<void> _fetchData({bool refresh = false}) async {
    setState(() {
      _isLoading = true; // Indicate loading
      _items.clear(); // Clear the list
    });

    var data =
        await dashboardProvider.fetchSeeAllData(widget.screenArguments.id);
    displayData(data);

    setState(() {
      _isLoading = false; // Indicate loading
    });
  }

  void displayData(List<ItemHomeContentModel> itemsList) {
    var isMovieCase = widget.screenArguments.type == "Movie";
    List<Widget> updatedItems = [];
    int currentIndex = 0;

    while (currentIndex < itemsList.length) {
      int itemsPerRow = isMovieCase ? 3 : 2;

      // Determine the number of items in the current row
      int remainingItems = itemsList.length - currentIndex;
      int currentRowItems =
          remainingItems < itemsPerRow ? remainingItems : itemsPerRow;

      updatedItems.add(
        Row(
          mainAxisAlignment: currentRowItems == 1
              ? MainAxisAlignment.start // Align to start if only 1 item
              : MainAxisAlignment.spaceBetween, // Distribute items otherwise
          children: List.generate(
            itemsPerRow,
            (index) {
              if (currentIndex + index >= itemsList.length) {
                return const SizedBox.shrink();
              }
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: isMovieCase
                      ? Customverticalcard(
                          isPremium: itemsList[currentIndex + index].isPremium,
                          url: itemsList[currentIndex + index].videoImage ?? "")
                      : Customhorizontalcard(
                          isPremium: itemsList[currentIndex + index].isPremium,
                          showTitle: true,
                          url:
                              itemsList[currentIndex + index].videoImage ?? ""),
                ),
              );
            },
          ),
        ),
      );

      currentIndex += itemsPerRow;
    }

    setState(() {
      _items = updatedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.bgColor,
      body: Stack(
        children: [
          CustomScrollView(
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
                  widget.screenArguments.title,
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
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 20.sp),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _items[index],
                    childCount: _items.length,
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading) // Show LoaderWidget if _isLoading is true
            const LoaderWidget(),
        ],
      ),
    );
  }
}
