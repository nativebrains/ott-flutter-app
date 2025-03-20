import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/constants/constants.dart';
import 'package:islamforever/features/dashboard/models/ItemHomeModel.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/features/dashboard/screens/SeeAllScreen.dart';
import 'package:islamforever/features/dashboard/widgets/CustomBanner.dart';
import 'package:islamforever/features/dashboard/widgets/CustomHorizontalCardList.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../models/HomeDataModel.dart';
import '../widgets/CustomVerticalCardList.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    super.key,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: ColorCode.bgColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.sp),
                  Custombanner(
                    itemSliderList: provider.dashboardData?.itemSlider ?? [],
                  ),
                  SizedBox(height: 16.sp),
                  ...List.generate(
                    provider.dashboardData?.itemHome.length ?? 0,
                    (index) {
                      final item = provider.dashboardData!.itemHome[index];
                      if (item.homeType == 'Movie') {
                        return Column(
                          children: [
                            getVerticalList(item),
                            SizedBox(height: 16.sp),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            getHorizontalList(item),
                            SizedBox(height: 16.sp),
                          ],
                        );
                      }
                    },
                  ),
                  getNoDataWidget(provider),
                ],
              ),
            ),

            // Show LoaderWidget if _isLoading is true
            if (provider.isHomeScreenLoading) const LoaderWidget(),
          ],
        ),
      );
    });
  }

  Widget getVerticalList(ItemHomeModel itemHomeModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                itemHomeModel.homeTitle ?? "",
                style: GoogleFonts.poppins(
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (itemHomeModel.homeId != "-1")
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstantName.seeAllScreen,
                    arguments: SeeAllScreenArguments(
                      title: itemHomeModel.homeTitle ?? "",
                      id: itemHomeModel.homeId ?? "",
                      type: itemHomeModel.homeType ?? "",
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GradientText(
                    'See All',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900),
                    colors: [
                      ColorCode.greenStartColor,
                      ColorCode.greenEndColor
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 6.sp,
        ),
        Customverticalcardlist(
          itemHomeContentModel: itemHomeModel.itemHomeContentModel ?? [],
        ),
      ],
    );
  }

  Widget getHorizontalList(ItemHomeModel itemHomeModel,
      {bool hasSeeAll = false, bool showItemTitle = false}) {
    // Shuffle the list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                itemHomeModel.homeTitle ?? "",
                style: GoogleFonts.poppins(
                  color: ColorCode.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ),
            if (itemHomeModel.homeId != "-1")
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteConstantName.seeAllScreen,
                    arguments: SeeAllScreenArguments(
                      title: itemHomeModel.homeTitle ?? "",
                      id: itemHomeModel.homeId ?? "",
                      type: itemHomeModel.homeType ?? "",
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GradientText(
                    'See All',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900),
                    colors: [
                      ColorCode.greenStartColor,
                      ColorCode.greenEndColor
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 6.sp,
        ),
        Customhorizontalcardlist(
          itemHomeContentModelList: itemHomeModel.itemHomeContentModel ?? [],
        ),
      ],
    );
  }

  getNoDataWidget(DashboardProvider provider) {
    if (!provider.isHomeScreenLoading &&
        provider.dashboardData != null &&
        provider.dashboardData!.itemSlider.isEmpty &&
        provider.dashboardData!.itemHome.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Text(
              "No Items Found!\nSwipe down to Refresh",
              style: GoogleFonts.poppins(
                color: ColorCode.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
