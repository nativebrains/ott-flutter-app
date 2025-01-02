import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/watchlist/models/ItemWatchListModel.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../dashboard/providers/DashboardProvider.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';

class Watchlistscreen extends StatefulWidget {
  const Watchlistscreen({super.key});

  @override
  State<Watchlistscreen> createState() => _WatchlistscreenState();
}

class _WatchlistscreenState extends State<Watchlistscreen> {
  late DashboardProvider dashboardProvider;

  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _fetchData();

    // for (int i = 0; i < 10; i++) {
    //   _items.add(
    //     Row(
    //       children: List.generate(
    //         2,
    //         (index) => Expanded(
    //           child: Container(
    //               margin: EdgeInsets.all(6),
    //               child: Customhorizontalcard(
    //                   isPremium: true,
    //                   showTitle: true,
    //                   url: Constants.imgHorizontalList[Random()
    //                       .nextInt(Constants.imgHorizontalList.length)])),
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  Future<void> _fetchData({bool refresh = false}) async {
    setState(() {
      _isLoading = true; // Indicate loading
    });

    await dashboardProvider.fetchMyWatchListData(refresh: refresh);

    setState(() {
      _isLoading = false; // Indicate loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: ColorCode.bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: 12.sp, right: 12.sp, bottom: 12.sp),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    children: provider.itemsWatchListData.map((item) {
                      return Container(
                        margin:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 6),
                        child: Customhorizontalcard(
                          isPremium: true,
                          showTitle: true,
                          url: item.postImage ?? "",
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 12.sp)
                ],
              ),
            ),
            if (_isLoading) // Show LoaderWidget if _isLoading is true
              const LoaderWidget(),
          ],
        ),
      );
    });
  }
}
