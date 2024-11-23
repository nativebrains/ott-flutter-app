import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';

class SeeAllScreenArguments {
  final String title;
  final bool isVertical;

  SeeAllScreenArguments({required this.title, required this.isVertical});
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
  @override
  Widget build(BuildContext context) {
    int itemsPerRow =
        widget.isVertical ? 3 : 2; // Determine items per row based on boolean

    return Scaffold(
      backgroundColor: ColorCode.blackColor,
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
            padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 20.sp),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Row(
                    children: List.generate(
                      itemsPerRow,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Center(
                            child: Text('Item $index'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
