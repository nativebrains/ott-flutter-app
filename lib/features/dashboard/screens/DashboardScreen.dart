import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamforever/features/dashboard/screens/AccountScreen.dart';
import 'package:islamforever/features/dashboard/screens/HomeScreen.dart';
import 'package:islamforever/features/dashboard/screens/MixScreen.dart';
import 'package:islamforever/features/dashboard/screens/SettingsScreen.dart';
import 'package:islamforever/features/dashboard/screens/WatchListScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;
  DateTime? lastBackPressed;
  String mixScreenTitle = "Mix";

  // List of screens for the bottom navigation
  final List<Widget> _screens = [
    Homescreen(),
    Watchlistscreen(),
    Mixscreen(),
    Accountscreen(),
    Settingsscreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handle search completion
  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteConstantName.searchScreen,
      );
      _clearSearch();
    }
  }

  // Clear search and reset to default AppBar
  void _clearSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (lastBackPressed == null ||
              now.difference(lastBackPressed!) > Duration(seconds: 2)) {
            lastBackPressed = now;
            Fluttertoast.showToast(
              msg: 'Please click BACK again to exit',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: ColorCode.shadowColor,
              textColor: Colors.white,
              fontSize: 15.sp,
            );

            return false; // Do not exit app
          }
          exit(0); // Exit app
        },
        child: Scaffold(
          backgroundColor: ColorCode.scaffoldBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              automaticallyImplyLeading: _isSearching,
              leading: _isSearching
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: _clearSearch,
                    )
                  : null,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: _isSearching
                  ? TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.done,
                      onSubmitted: _onSearchSubmitted,
                    )
                  : Text(
                      getAppBarTitle(_selectedIndex),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
              centerTitle: false,
              actions: _isSearching
                  ? [
                      IconButton(
                        iconSize: 34.sp,
                        icon: Icon(Icons.close_rounded, color: Colors.white),
                        onPressed: _clearSearch,
                      ),
                    ]
                  : [
                      if (_selectedIndex == 2)
                        IconButton(
                          iconSize: 34.sp,
                          icon: Image(
                            image: AssetImage('assets/images/ic_filter.png'),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                        ),
                      IconButton(
                        iconSize: 38.sp,
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                      ),
                    ],
            ),
          ),
          body: _screens[_selectedIndex],
          bottomNavigationBar: getBottomMenu(_selectedIndex),
        ));
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return mixScreenTitle;
      case 3:
        return 'Account';
      case 4:
        return 'Settings';
      default:
        return 'Dashboard';
    }
  }

  Widget getBottomMenu(int selectedIndex) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: ColorCode.bottomNavBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/ic_home.png'),
                  width: 28,
                  height: 28,
                  color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
                ),
                CustomText(
                  text: 'Home',
                  color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/ic_watchlist.png'),
                  width: 28,
                  height: 28,
                  color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
                ),
                CustomText(
                  text: 'Watchlist',
                  color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showNotificationsBottomSheet(context, () {
                setState(() {
                  _selectedIndex = 2;
                });
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(13.sp),
                child: const Image(
                  image: AssetImage('assets/images/ic_menu.png'),
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 28,
                  color: _selectedIndex == 3 ? Colors.pink : Colors.grey,
                ),
                CustomText(
                  text: 'Account',
                  color: _selectedIndex == 3 ? Colors.pink : Colors.grey,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 28,
                  color: _selectedIndex == 4 ? Colors.pink : Colors.grey,
                ),
                CustomText(
                  text: 'Settings',
                  color: _selectedIndex == 4 ? Colors.pink : Colors.grey,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showNotificationsBottomSheet(BuildContext context, VoidCallback onTap) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorCode.bottomNavBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 4.0, // Height of the line
                  width: context.screenWidth / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade600,
                        Colors.grey.shade600,
                      ], // Start and end colors of the gradient
                      begin: Alignment.centerLeft, // Start of the gradient
                      end: Alignment.centerRight, // End of the gradient
                    ),

                    borderRadius: BorderRadius.circular(12), // Corner radius
                  ),
                ),
              ),
              SizedBox(height: 12.sp),
              getCustomTile("assets/images/ic_movie.png", "Movies", () {
                mixScreenTitle = "Movies";
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_tv_show.png", "TV Shows", () {
                mixScreenTitle = "TV Shows";
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_sport.png", "Sports", () {
                mixScreenTitle = "Sports";
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_live_tv.png", "Live TV", () {
                mixScreenTitle = "Live TV";
                onTap();
                Navigator.of(context).pop();
              }),
              SizedBox(height: 6.sp),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.pink,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: Icon(
                      Icons.close_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.sp),
            ],
          ),
        );
      },
    );
  }

  Widget getCustomTile(String imageUrl, String title, VoidCallback ontap) {
    return ListTile(
      leading: Image.asset(
        imageUrl,
        width: 28,
        height: 28,
      ),
      title: CustomText(
        text: title,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
      onTap: ontap // Dismiss the sheet on tap
      ,
    );
  }
}
