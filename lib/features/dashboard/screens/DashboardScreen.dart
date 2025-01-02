import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamforever/features/account/screens/AccountScreen.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/features/dashboard/screens/HomeScreen.dart';
import 'package:islamforever/features/mix/screens/MixScreen.dart';
import 'package:islamforever/features/settings/screens/SettingsScreen.dart';
import 'package:islamforever/features/watchlist/screens/WatchListScreen.dart';
import 'package:islamforever/utils/extensions_utils.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/assets_images.dart';
import '../../../constants/routes_names.dart';
import '../../../core/loader_widget/loader_widget.dart';
import '../../../widgets/custom/custom_elevated_button.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../common/enums/MediaContentType.dart';
import '../models/HomeDataModel.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  late DashboardProvider dashboardProvider;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;
  DateTime? lastBackPressed;
  var _isLoading = false;

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
    _fetchData();
  }

  Future<void> _fetchData({bool refresh = false}) async {
    setState(() {
      _isLoading = true; // Indicate loading
    });

    await dashboardProvider.fetchDashboardData(refresh: refresh);

    setState(() {
      _isLoading = false; // Indicate loading
    });
  }

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
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
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
          return false; // Do not exit the app
        }
        exit(0); // Exit the app
      },
      child: Scaffold(
        backgroundColor: ColorCode.scaffoldBackgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: _isSearching,
                leading: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                          icon: const Icon(Icons.close_rounded,
                              color: Colors.white),
                          onPressed: _clearSearch,
                        ),
                      ]
                    : [
                        if (_selectedIndex == 2)
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
                        IconButton(
                          iconSize: 32.sp,
                          icon: const Icon(Icons.search, color: Colors.white),
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
          body: Stack(
            children: [
              RefreshIndicator(
                color: ColorCode.whiteColor,
                backgroundColor: Colors.orange,
                onRefresh: _refreshData,
                child: _screens[_selectedIndex],
              ),
              if (_isLoading) // Show LoaderWidget if _isLoading is true
                const LoaderWidget(),
            ],
          ),
        ),
        bottomNavigationBar: getBottomMenu(_selectedIndex),
      ),
    );
  }

  Future<void> _refreshData() async {
    switch (_selectedIndex) {
      case 0:
        await _fetchData(refresh: true);
        break;
      case 1:
        //await fetchWatchlistData(refresh: true);
        break;
      case 2:
        // await fetchMixData(refresh: true);
        break;
      case 3:
        // await fetchAccountData(refresh: true);
        break;
      case 4:
        // await fetchSettingsData(refresh: true);
        break;
    }
  }

  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
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
      height: 75,
      decoration: const BoxDecoration(
        color: ColorCode.bottomNavBg,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
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
                  image: const AssetImage('assets/images/ic_home.png'),
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
                  image: const AssetImage('assets/images/ic_watchlist.png'),
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
              showMixMenuBottomSheet(context, () {
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
              getCustomTile("assets/images/ic_movie.png", "Movies", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.movies);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_tv_show.png", "TV Shows", () {
                dashboardProvider
                    .setSelectedMixScreenContentType(MediaContentType.tvShows);
                onTap();
                Navigator.of(context).pop();
              }),
              getCustomTile("assets/images/ic_sport.png", "Sports", () {
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

  final List<String> categories = ['Language', 'Genre', 'Order Type'];
  final Map<String, List<String>> options = {
    'Language': ['Hindi', 'English', 'French', 'Malayalam', 'Arabic'],
    'Genre': ['Action', 'Comedy', 'Drama', 'Horror', 'Romance'],
    'Order Type': ['Pickup', 'Delivery', 'Dine-In'],
  };

// Current selected category
  String selectedCategory = 'Language';

// Selected radio button for "Order Type"
  String selectedOrderType = 'Pickup';

// Selected checkboxes for other categories
  Map<String, Set<String>> selectedOptions = {
    'Language': {},
    'Genre': {},
  };

  void showFilterBottomSheet(BuildContext context, VoidCallback onTap) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setBottomSheetState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4.0,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Row(
                      children: [
                        // Left menu for categories
                        SizedBox(
                          width: 130,
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  setBottomSheetState(() {
                                    selectedCategory = category;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 12),
                                  color: selectedCategory == category
                                      ? Colors.grey[800]
                                      : Colors.transparent,
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: selectedCategory == category
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        // Right side content area
                        Expanded(
                          child: ListView.builder(
                            itemCount: options[selectedCategory]!.length,
                            itemBuilder: (context, index) {
                              final item = options[selectedCategory]![index];
                              if (selectedCategory == 'Order Type') {
                                // Show radio buttons for Order Type
                                return _buildRadioItem(
                                  item,
                                  selectedOrderType,
                                  (value) {
                                    setBottomSheetState(() {
                                      selectedOrderType = value!;
                                    });
                                  },
                                );
                              } else {
                                // Show checkboxes for other categories
                                return _buildCheckboxItem(
                                  item,
                                  selectedOptions[selectedCategory] ?? {},
                                  (value) {
                                    setBottomSheetState(
                                      () {
                                        if (value) {
                                          selectedOptions[selectedCategory]!
                                              .add(item);
                                        } else {
                                          selectedOptions[selectedCategory]!
                                              .remove(item);
                                        }
                                      },
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        // Clear button (Outlined Button)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              // Clear selected options
                              setBottomSheetState(() {
                                selectedOptions = {
                                  'Language': {},
                                  'Genre': {},
                                };
                                selectedOrderType = 'Pickup';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              side: const BorderSide(
                                  color: Colors.white), // White border
                              foregroundColor: Colors.white, // White text
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: CustomText(
                              text: 'Clear Filters',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), // Space between the buttons

                        // Apply button (Filled Button)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform the apply action
                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet
                              onTap(); // Trigger the callback
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor:
                                  Colors.pink, // Filled button color
                              foregroundColor: Colors.white, // White text
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: CustomText(
                              text: 'Apply Filters',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCheckboxItem(
      String title, Set<String> selectedItems, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: selectedItems.contains(title),
          onChanged: (bool? value) {
            onChanged(value!);
          },
          activeColor: Colors.pink,
        ),
        CustomText(
          text: title,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildRadioItem(
      String title, String selectedValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: selectedValue,
          onChanged: onChanged,
          activeColor: Colors.pink,
        ),
        CustomText(
          text: title,
          color: Colors.white,
        ),
      ],
    );
  }
}
