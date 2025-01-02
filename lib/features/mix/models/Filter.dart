class Filter {
  String? filterId;
  String? filterName;
  String? filterType;
  bool isSelected = false;

  Filter({
    this.filterId,
    this.filterName,
    this.filterType,
    this.isSelected = false,
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      filterId: json['filterId'],
      filterName: json['filterName'],
      filterType: json['filterType'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filterId': filterId,
      'filterName': filterName,
      'filterType': filterType,
      'isSelected': isSelected,
    };
  }

  String? getFilterId() => filterId;
  String? getFilterName() => filterName;
  String? getFilterType() => filterType;
  bool isSelectedFilter() => isSelected;

  void setSelected(bool selected) {
    isSelected = selected;
  }
}
