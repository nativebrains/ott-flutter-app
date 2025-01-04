import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
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

    updatedItems.add(
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: isMovieCase ? 3 : 2,
        childAspectRatio: isMovieCase ? 0.65 : 1.4,
        children: itemsList.map((item) {
          if (isMovieCase) {
            return Container(
              margin: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              child: Customverticalcard(
                isPremium: item.isPremium,
                url: item.videoImage ?? "",
                id: item.videoId,
                title: item.videoTitle,
                mediaContentType:
                    MediaContentType.getMediaType(item.videoType.toString()),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              child: Customhorizontalcard(
                isPremium: item.isPremium,
                showTitle: true,
                url: item.videoImage ?? "",
                id: item.videoId,
                title: item.videoTitle,
              ),
            );
          }
        }).toList(),
      ),
    );

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
                    EdgeInsets.only(left: 12.sp, right: 12.sp, bottom: 12.sp),
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
