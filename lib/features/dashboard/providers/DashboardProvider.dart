import 'package:flutter/material.dart';
import 'package:islamforever/features/common/enums/MediaContentType.dart';

class DashboardProvider extends ChangeNotifier {
  static MediaContentType? _selectedMixScreenContentType;

  static get selectedMixScreenContentType {
    return _selectedMixScreenContentType;
  }

  static get selectedMixScreenContentTypeName {
    return _selectedMixScreenContentType?.displayName;
  }

  void setSelectedMixScreenContentType(MediaContentType contentType) {
    _selectedMixScreenContentType = contentType;
    notifyListeners();
  }
}
