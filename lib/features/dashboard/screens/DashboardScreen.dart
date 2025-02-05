import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamforever/features/account/providers/AccountProvider.dart';
import 'package:islamforever/features/account/screens/AccountScreen.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/features/dashboard/screens/HomeScreen.dart';
import 'package:islamforever/features/dashboard/widgets/CustomFilterBottomSheet.dart';
import 'package:islamforever/features/mix/screens/MixScreen.dart';
import 'package:islamforever/features/settings/screens/SettingsScreen.dart';
import 'package:islamforever/features/watchlist/screens/WatchListScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:islamforever/utils/extras.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../common/enums/MediaContentType.dart';
import '../../settings/models/AboutAppModel.dart';
import '../../settings/providers/SettingsProvider.dart';
import '../../webview/screens/WebviewScreen.dart';
import '../models/HomeDataModel.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  late DashboardProvider dashboardProvider;
  late AccountProvider accountProvider;
  late SettingsProvider settingsProvider;
  late AboutAppModel? aboutAppModel;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;
  DateTime? lastBackPressed;

  // List of screens for the bottom navigation
  final List<Widget> _screens = const [
    Homescreen(),
    Watchlistscreen(),
    Mixscreen(),
    Accountscreen(),
    Settingsscreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    fetchAboutAppDetails(refresh: true);
    dashboardProvider.fetchDashboardHomeData();
  }

  void fetchAboutAppDetails({bool refresh = false}) async {
    aboutAppModel = await settingsProvider.fetchAboutData(refresh: refresh);
    if (aboutAppModel?.appUpdateHideShow == true) {
      _showUpdateDialog(context);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      fetchAboutAppDetails(refresh: true);
    }
  }

  // Handle search completion
  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteConstantName.searchScreen,
        arguments: query,
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
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction == ScrollDirection.reverse ||
            notification.direction == ScrollDirection.forward) {
          _clearSearch();
          FocusScope.of(context).unfocus(); // Hide the keyboard
        }
        return true;
      },
      child: WillPopScope(
        onWillPop: () async {
          if (_selectedIndex != 0) {
            _onItemTapped(0);
            return false;
          } else {
            DateTime now = DateTime.now();
            if (lastBackPressed == null ||
                now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
              lastBackPressed = now;
              Fluttertoast.showToast(
                msg: 'Please click BACK again to exit',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: ColorCode.greenStartColor,
                textColor: Colors.white,
                fontSize: 15.sp,
              );
              return false; // Do not exit the app
            }
            exit(0); // Exit the app
          }
        },
        child: Scaffold(
          backgroundColor: ColorCode.scaffoldBackgroundColor,
          body: SafeArea(
            top: false,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: _isSearching,
                    pinned: true,
                    leading: _isSearching
                        ? IconButton(
                            iconSize: 32.sp,
                            icon: const Icon(Icons.close_rounded,
                                color: Colors.white),
                            onPressed: _clearSearch,
                          )
                        : null,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorCode.greenStartColor,
                            ColorCode.greenEndColor
                          ],
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
                            textInputAction: TextInputAction.search,
                            onSubmitted: _onSearchSubmitted,
                          )
                        : Text(
                            getAppBarTitle(_selectedIndex),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                    centerTitle: false,
                    actions: _isSearching
                        ? [
                            IconButton(
                              iconSize: 32.sp,
                              icon:
                                  const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                _onSearchSubmitted(_searchController.text);
                              },
                            ),
                          ]
                        : [
                            if (_selectedIndex == 2 &&
                                DashboardProvider
                                        .selectedMixScreenContentType !=
                                    MediaContentType.liveTv)
                              IconButton(
                                iconSize: 32.sp,
                                icon: Image(
                                  image: const AssetImage(
                                      'assets/images/ic_filter.png'),
                                  color: Colors.white,
                                  width: 32.sp,
                                  height: 32.sp,
                                ),
                                onPressed: () {
                                  showFilterBottomSheet(context, () {});
                                },
                              ),
                            if (_selectedIndex != 3 && _selectedIndex != 4)
                              IconButton(
                                iconSize: 32.sp,
                                icon: const Icon(Icons.search,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _isSearching = true;
                                  });
                                },
                              ),
                          ],
                    floating: true,
                    snap: true,
                  ),
                ];
              },
              body: RefreshIndicator(
                color: ColorCode.whiteColor,
                backgroundColor: Colors.greenAccent,
                onRefresh: _refreshData,
                child: _screens[_selectedIndex],
              ),
            ),
          ),
          bottomNavigationBar: getBottomMenu(_selectedIndex),
          floatingActionButton: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteConstantName.webviewScreen,
                    arguments: const WebviewScreen(
                        webviewType: WebviewType.CHAT_SUPPORT));
              },
              tooltip: 'Chat',
              backgroundColor:
                  Colors.transparent, // Set the background color to transparent
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.all(8.0), // Add a margin around the icon
                child: Icon(Icons.chat,
                    color: Colors.white), // Set the icon and its color
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() {
    Completer<void> completer = Completer<void>();
    fetchAboutAppDetails(refresh: true);
    switch (_selectedIndex) {
      case 0:
        dashboardProvider.fetchDashboardHomeData(refresh: true);
        fetchAboutAppDetails(refresh: true);
        break;
      case 1:
        dashboardProvider.fetchMyWatchListData(refresh: true);
        break;
      case 2:
        dashboardProvider.fetchMixScreenData(reset: true);
        break;
      case 3:
        accountProvider.fetchDashboardAccountDetails(refresh: true);
        break;
    }
    completer.complete();
    return completer.future;
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Watchlist';
      case 2:
        return DashboardProvider.selectedMixScreenContentTypeName;
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
      height: 80.sp,
      decoration: const BoxDecoration(
        color: ColorCode.bottomNavBg,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              _onItemTapped(0);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/ic_home.png'),
                  width: 28,
                  height: 28,
                  color: _selectedIndex == 0 ? Colors.greenAccent : Colors.grey,
                ),
                CustomText(
                  text: 'Home',
                  color: _selectedIndex == 0 ? Colors.greenAccent : Colors.grey,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _onItemTapped(1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/ic_watchlist.png'),
                  width: 28,
                  height: 28,
                  color: _selectedIndex == 1 ? Colors.greenAccent : Colors.grey,
                ),
                CustomText(
                  text: 'Watchlist',
                  color: _selectedIndex == 1 ? Colors.greenAccent : Colors.grey,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showMixMenuBottomSheet(context, () {
                _onItemTapped(2);
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [ColorCode.greenStartColor, ColorCode.greenEndColor],
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
              _onItemTapped(3);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 28,
                  color: _selectedIndex == 3 ? Colors.greenAccent : Colors.grey,
                ),
                CustomText(
                  text: 'Account',
                  color: _selectedIndex == 3 ? Colors.greenAccent : Colors.grey,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _onItemTapped(4);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 28,
                  color: _selectedIndex == 4 ? Colors.greenAccent : Colors.grey,
                ),
                CustomText(
                  text: 'Settings',
                  color: _selectedIndex == 4 ? Colors.greenAccent : Colors.grey,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMixMenuBottomSheet(BuildContext context, VoidCallback onTap) {
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
              getCustomTile("assets/images/ic_movie.png", "Webseries", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.movies);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_tv_show.png", "TV Programs", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.tvShows);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_sport.png", "Browse", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.sports);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_live_tv.png", "Live TV", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.liveTv);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_podcast.png", "Podcast", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.podcast);
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
                        ColorCode.greenStartColor,
                        ColorCode.greenEndColor
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.sp),
                    child: const Icon(
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
        color: Colors.white,
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

  void showFilterBottomSheet(BuildContext context, VoidCallback onTap) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Customfilterbottomsheet(
          onFilterSelected: (data) {
            print(data);
            dashboardProvider.setFilterDataAndRefresh(data);
            onTap();
          },
          filterTypeSec: DashboardProvider.selectedMixScreenContentType,
          filterData: dashboardProvider.getfilterData,
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorCode.whiteColor,
          title: CustomText(
            text: 'Update Available',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          content: CustomText(
            text: aboutAppModel?.appUpdateDescription.toString() ?? "",
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Update Now'),
                  onPressed: () async {
                    await goToRelativeAppStore(context);
                    Navigator.of(context).pop();
                  },
                ),
                if (aboutAppModel?.appUpdateCancelOption == true)
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
