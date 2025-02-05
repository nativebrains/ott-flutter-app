import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../features/details/models/ReviewModel.dart';

String camelCase(String input) {
  // Replace underscores with spaces
  String textWithSpaces = input.replaceAll('_', ' ');

  // Capitalize the first letter of each word except the first one
  List<String> words = textWithSpaces.split(' ');
  String result = words.map((word) {
    if (word.isNotEmpty) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    } else {
      return '';
    }
  }).join(' '); // Add a space here to join words with spaces

  return result;
}

String formatDate(DateTime date, String format) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

String formatHeaderDate(DateTime date) {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1));
  final tomorrow = today.add(const Duration(days: 1));

  if (DateTime(date.year, date.month, date.day) ==
      DateTime(today.year, today.month, today.day)) {
    return 'Today, ${formatDate(date, 'dd MMMM yyyy')}';
  } else if (DateTime(date.year, date.month, date.day) ==
      DateTime(yesterday.year, yesterday.month, yesterday.day)) {
    return 'Yesterday, ${formatDate(date, 'dd MMMM yyyy')}';
  } else if (DateTime(date.year, date.month, date.day) ==
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day)) {
    return 'Tomorrow, ${formatDate(date, 'dd MMMM yyyy')}';
  } else {
    return formatDate(date, 'dd MMMM yyyy');
  }
}

String formatNotificaiontHeaderDate(DateTime date) {
  final today = DateTime.now();
  final yesterday = today.subtract(const Duration(days: 1));
  final tomorrow = today.add(const Duration(days: 1));

  if (DateTime(date.year, date.month, date.day) ==
      DateTime(today.year, today.month, today.day)) {
    return 'Today';
  } else if (DateTime(date.year, date.month, date.day) ==
      DateTime(yesterday.year, yesterday.month, yesterday.day)) {
    return 'Yesterday';
  } else if (DateTime(date.year, date.month, date.day) ==
      DateTime(tomorrow.year, tomorrow.month, tomorrow.day)) {
    return 'Tomorrow';
  } else {
    return formatDate(date, 'dd MMMM yyyy');
  }
}

double toDouble(dynamic value) {
  if (value == null) {
    return 0.0; // or return null, depending on your requirements
  } else if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else if (value is String) {
    return double.parse(value);
  } else {
    throw ArgumentError(
        'Expected int, double, or String, but got ${value.runtimeType}');
  }
}

String formatMessageDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));

  if (dateTime.isAfter(today)) {
    return DateFormat.jm().format(dateTime); // AM/PM format for today
  } else if (dateTime.isAfter(yesterday)) {
    return 'Yesterday';
  } else {
    return DateFormat('dd/MM/yyyy')
        .format(dateTime); // Date format for other days
  }
}

void showImageDialog(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          ),
        ),
      );
    },
  );
}

String generateUniqueName(String prefix, String postFix) {
  // Generate a random number as a string
  String randomString = Random().nextInt(9999999).toString();

  // Get the current timestamp
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  // Concatenate the timestamp and random number to create a unique name
  return '${prefix}_${timestamp}_$randomString$postFix';
}

String formatTime(String time) {
  final dateTime = DateFormat('HH:mm').parse(time);
  return DateFormat('hh:mm a').format(dateTime);
}

String convertMinutesToHours(String minutes) {
  double totalMinutes = double.parse(minutes);
  int hours = totalMinutes ~/ 60;
  int remainingMinutes = (totalMinutes % 60).round();

  if (hours > 0 && remainingMinutes > 0) {
    return '${hours} hours ${remainingMinutes.toString().padLeft(2, '0')} minutes';
  } else if (hours > 0) {
    return '${hours} hours';
  } else {
    return '${remainingMinutes.toString().padLeft(2, '0')} minutes';
  }
}

bool isAndroid() {
  return Platform.isAndroid;
}

bool isIOS() {
  return Platform.isIOS;
}

double calculateAverageRating(List<ReviewModel>? reviewsList) {
  if (reviewsList == null || reviewsList.isEmpty) {
    return 0.0;
  }

  double totalRating = 0;
  for (ReviewModel review in reviewsList) {
    totalRating += review.rating ?? 0; // Add 0 if review.rating is null
  }

  return totalRating / reviewsList.length;
}

String formatReviewCount(List<ReviewModel>? reviewsList) {
  if (reviewsList == null || reviewsList.isEmpty) {
    return 'No Reviews';
  }

  int count = reviewsList.length;
  if (count < 1000) {
    return '$count Reviews';
  } else if (count < 1000000) {
    return '${(count / 1000).toStringAsFixed(1)}K Reviews';
  } else {
    return '${(count / 1000000).toStringAsFixed(1)}M Reviews';
  }
}

Future<void> goToRelativeAppStore(BuildContext context) async {
  try {
    // Get the package name of the app
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String packageName = packageInfo.packageName;

    // Construct URLs
    final String playStoreUrl =
        'https://play.google.com/store/apps/details?id=$packageName';
    final String playStoreAppUrl = 'market://details?id=$packageName';
    final String appStoreUrl =
        'https://apps.apple.com/app/id6740846066'; // Replace `YOUR_APP_ID` with your App Store ID

    if (Platform.isAndroid) {
      // Android-specific logic
      final Uri appUri = Uri.parse(playStoreAppUrl);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri);
      } else {
        final Uri webUri = Uri.parse(playStoreUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to open the Play Store.')),
          );
        }
      }
    } else if (Platform.isIOS) {
      // iOS-specific logic
      final Uri appUri = Uri.parse(appStoreUrl);
      if (await canLaunchUrl(appUri)) {
        await launchUrl(appUri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to open the App Store.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unsupported platform.')),
      );
    }
  } catch (e) {
    // Handle errors gracefully
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}

Future<bool> checkInternetConnection() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }
  return true;
}
