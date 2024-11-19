extension LateInitializationChecker on Object {
  bool isInitialized<T>() {
    try {
      T value = this as T;
      return value != null;
    } catch (e) {
      return false;
    }
  }
}

extension StringExtension on String {
  bool get isBlank {
    return trim().isEmpty;
  }

  bool get isNotBlank {
    return !isBlank;
  }
}

extension EmailValidation on String {
  bool isValidEmail() {
    // Regular expression pattern for validating email addresses
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the string matches the email pattern
    return emailRegex.hasMatch(this);
  }
}

String nullToEmptyString(dynamic value) {
  return value?.toString() ?? ''; // If null, return empty string
}

extension UniqueList<T> on List<T> {
  List<T> uniqueBy<V>(V Function(T) keySelector) {
    var uniqueMap = <V, T>{};
    for (var item in this) {
      uniqueMap[keySelector(item)] = item;
    }
    return uniqueMap.values.toList();
  }
}
