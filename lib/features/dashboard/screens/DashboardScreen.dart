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
  int _selectedIndex = 0;
  DateTime? lastBackPressed;

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
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  iconSize: 34.sp,
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          body: _screens[_selectedIndex],
          bottomNavigationBar: getBottomMenu(_selectedIndex),
        ));
  }

  Widget getBottomMenu(int selectedIndex) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: ColorCode.primaryDarkColor,
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
              setState(() {
                _selectedIndex = 2;
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
}
