import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';
import 'package:islamforever/features/mix/models/FilterDataModel.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_message.dart';
import '../../../widgets/custom/custom_text.dart';
import '../../authentication/providers/AuthenticationProvider.dart';
import '../../mix/models/Filter.dart';
import '../../mix/models/FilterType.dart';
import '../../mix/models/FilterUtil.dart';
import '../providers/DashboardProvider.dart';

class Customfilterbottomsheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilterSelected;
  final MediaContentType filterTypeSec;
  final Map<String, dynamic> filterData;
  const Customfilterbottomsheet({
    super.key,
    required this.onFilterSelected,
    required this.filterTypeSec,
    required this.filterData,
  });

  @override
  State<Customfilterbottomsheet> createState() =>
      _CustomfilterbottomsheetState();
}

class _CustomfilterbottomsheetState extends State<Customfilterbottomsheet> {
  late DashboardProvider dashboardProvider;
  List<Filter> filterList = [];
  List<FilterType> filterOptionsList = [];

  List<FilterType?> categories = [];
  final Map<String, List<Filter>> options = {};

  // Current selected category
  String selectedCategory = 'Order Type';
  // Selected radio button for "Order Type"
  String selectedOrderType = 'NEWEST';
  // Selected checkboxes for other categories
  Map<String, Set<Filter>> selectedOptions = {
    'Language': {},
    'Genre': {},
    'Category': {},
  };

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    // initialise all filters in the list
    filterList = dashboardProvider.filterDataModel?.getCombinedFilters() ?? [];
    filterOptionsList =
        FilterType.getFilterTypeListBySec(widget.filterTypeSec.filterType);

    initialiseData();
  }

  void initialiseData() {
    categories = filterOptionsList;

    for (var filter in filterList) {
      String key;
      switch (filter.filterType) {
        case FilterType.TY_LANGUAGE:
          key = 'Language';
          break;
        case FilterType.TY_GENRE:
          key = 'Genre';
          break;
        case FilterType.TY_CATEGORY_SP:
        case FilterType.TY_CATEGORY_TV:
          key = 'Category';
          break;
        default:
          key = 'Order Type';
      }

      if (!options.containsKey(key)) {
        options[key] = [filter];
      } else {
        options[key]!.add(filter);
      }
    }

    // Restore filter data
    restoreSelections();
  }

  void restoreSelections() {
    if (widget.filterData.isNotEmpty) {
      Map<String, dynamic> filterDataMap = widget.filterData;
      List<FilterType> listType =
          FilterType.getFilterTypeListBySec(widget.filterTypeSec.filterType);

      for (FilterType filterType in listType) {
        String parameterName = filterType.getFilterTypeParameterName() ?? '';
        if (filterDataMap.containsKey(parameterName)) {
          String ids = filterDataMap[parameterName];
          List<String> idList = ids.split(',');

          if (filterType.filterType == FilterType.TY_ORDER_TYPE) {
            selectedOrderType = FilterUtil.getFilterNameFromId(
                FilterDataModel.listOfOrderType(), idList.first)!;
          } else {
            String key;
            switch (filterType.filterType) {
              case FilterType.TY_LANGUAGE:
                key = 'Language';
                break;
              case FilterType.TY_GENRE:
                key = 'Genre';
                break;
              case FilterType.TY_CATEGORY_SP:
              case FilterType.TY_CATEGORY_TV:
                key = 'Category';
                break;
              default:
                key = 'Order Type';
            }
            for (String id in idList) {
              List<Filter> filters = options[key]!
                  .where((filter) => filter.filterId == id)
                  .toList();
              if (filters.isNotEmpty) {
                if (!selectedOptions.containsKey(key)) {
                  selectedOptions[key] = filters.toSet();
                } else {
                  selectedOptions[key]!.addAll(filters);
                }
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                selectedCategory =
                                    category.filterTypeName ?? "";
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 12),
                              color:
                                  selectedCategory == category!.filterTypeName
                                      ? Colors.grey[800]
                                      : Colors.transparent,
                              child: Text(
                                category.filterTypeName ?? "",
                                style: TextStyle(
                                  color: selectedCategory ==
                                          category.filterTypeName
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
                              item.filterName ?? "",
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
                              'Category': {},
                            };
                            selectedOrderType = 'NEWEST';
                          });
                          showCustomToast(context, "Filters Cleared! Apply Now",
                              backgroudnColor: Colors.green);
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
                          Map<String, dynamic> selectedData = getSelectedData();
                          print(selectedData);
                          widget.onFilterSelected(selectedData);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor:
                              Colors.greenAccent, // Filled button color
                          foregroundColor: Colors.white, // White text
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: CustomText(
                          text: 'Apply Filters',
                          color: Colors.black,
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
  }

  Widget _buildCheckboxItem(
      Filter title, Set<Filter> selectedItems, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: selectedItems.contains(title),
          onChanged: (bool? value) {
            onChanged(value!);
          },
          activeColor: Colors.greenAccent,
        ),
        Flexible(
          child: CustomText(
            text: title.filterName ?? "",
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4.sp,
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
          activeColor: Colors.greenAccent,
        ),
        Flexible(
          child: CustomText(
            text: title,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> getSelectedData() {
    List<Filter> selectedFilters = [];

    // Add selected order type

    Filter filter = Filter(
      filterId: FilterUtil.getFilterIdFromName(
          FilterDataModel.listOfOrderType(), selectedOrderType),
      filterName: selectedOrderType,
      filterType: FilterType.TY_ORDER_TYPE,
      isSelected: true,
    );
    selectedFilters.add(filter);

    // Add selected options for other categories
    selectedOptions.forEach((category, selectedItems) {
      for (var item in selectedItems) {
        item.isSelected = true;
        selectedFilters.add(item);
      }
    });

    String filterData = FilterUtil.listToJson(selectedFilters);
    Map<String, dynamic> data = {};
    FilterUtil.jsonForParameter(FilterUtil.jsonToSelectList(filterData), data,
        widget.filterTypeSec.filterType);

    return data;
  }
}
