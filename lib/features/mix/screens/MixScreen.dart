import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/constants.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../dashboard/widgets/CustomHorizontalCard.dart';
import '../../dashboard/widgets/CustomVerticalCard.dart';

class Mixscreen extends StatefulWidget {
  const Mixscreen({super.key});

  @override
  State<Mixscreen> createState() => _MixscreenState();
}

class _MixscreenState extends State<Mixscreen> {
  late DashboardProvider _dashboardProvider;

  List<int> _items = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      var isMovieCase = DashboardProvider.selectedMixScreenContentType ==
          MediaContentType.movies;
      return Scaffold(
        backgroundColor: ColorCode.bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                ),
                child: Column(
                  children: [
                    GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: isMovieCase ? 3 : 2,
                        childAspectRatio: isMovieCase ? 0.65 : 1.4,
                        children: [
                          // Movies Section
                          if (DashboardProvider.selectedMixScreenContentType ==
                              MediaContentType.movies)
                            ...provider.itemsMixMoviesList.map((item) {
                              return Customverticalcard(
                                  isPremium: item.isPremium ?? false,
                                  url: item.movieImage ?? "");
                            }).toList(),
                        ]),
                  ],
                ),
              ),
            ),
            if (provider
                .isMixScreenLoading) // Show LoaderWidget if _isLoading is true
              const LoaderWidget(),
          ],
        ),
      );
    });
  }
}
