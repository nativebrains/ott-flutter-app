import 'package:intl/intl.dart';

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

extension DateFormatter on String {
  // Convert a date string to a specified format
  String toFormattedDate({required String outputFormat}) {
    try {
      // Parse the input date string (assumes ISO 8601 format)
      final DateTime parsedDate = DateTime.parse(this);

      // Define the desired output format
      final DateFormat dateFormat = DateFormat(outputFormat);

      // Return the formatted date
      return dateFormat.format(parsedDate);
    } catch (e) {
      // Handle invalid date parsing
      return 'Invalid Date';
    }
  }
}

String getValidImageUrl(String? avatarUrl, String fallbackUrl) {
  if (avatarUrl == null || avatarUrl.isEmpty) return fallbackUrl;

  // Trim leading and trailing whitespace
  avatarUrl = avatarUrl.trim();

  // Replace spaces with '%20' it works for web not for mobile
  avatarUrl = avatarUrl.replaceAll(' ', '');

  // Ensure the URL starts with 'http://' or 'https://'
  if (!avatarUrl.startsWith('http://') && !avatarUrl.startsWith('https://')) {
    avatarUrl = 'https://' + avatarUrl;
  }

  // List of common image extensions
  List<String> imageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.bmp',
    '.webp'
  ];

  // Check if the URL ends with an image extension (case insensitive)
  bool hasValidExtension = imageExtensions
      .any((ext) => avatarUrl!.toLowerCase().endsWith(ext.toLowerCase()));
  if (!hasValidExtension) {
    // Append a default extension if none is present
    avatarUrl += '.jpg'; // Use the most common extension you expect
  }

  return avatarUrl;
}

String getDollarSign(double value) {
  if (value >= 1.0 && value < 1.5) {
    return "\$";
  } else if (value >= 1.5 && value <= 2.5) {
    return "\$\$";
  } else if (value > 2.5) {
    return "\$\$\$";
  } else {
    return "";
  }
}

extension StringToLocalDateTime on String {
  DateTime toLocalDateTime() {
    // Parse the string to a UTC DateTime
    DateTime utcDateTime = DateTime.parse(this);
    // Convert the UTC DateTime to local DateTime
    return utcDateTime.toLocal();
  }
}
