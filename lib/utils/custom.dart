import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:market_place_customer/main.dart';
import 'package:market_place_customer/utils/app_assets.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_styles.dart';

/// custom divider
Widget customDivider() => Divider(
    thickness: 0.5, color: AppColors.themeColor.withOpacity(0.5), height: 0.5);

/// snack bar message
void snackBar(BuildContext context, String title,
    [Color color = AppColors.green]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      // behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Text(title, style: AppStyle.normal_12(AppColors.whiteColor))));
}

/// easy loading bar
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom // Important!
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.whiteColor
    ..backgroundColor = AppColors.themeColor
    ..indicatorColor = AppColors.whiteColor
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

/// date format
String formatDateAMPM(DateTime dateTime) {
  return DateFormat('dd MMMM yy').format(dateTime);
}

String formatTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inDays == 0 && now.day == time.day) {
    // Same day, show time with AM/PM
    return DateFormat('hh:mm a').format(time); // 03:45 PM
  } else if (difference.inDays == 1 ||
      (difference.inDays == 0 && now.day != time.day)) {
    // Yesterday (difference.inDays might be 0 if time is yesterday but less than 24h)
    return "Yesterday";
  } else {
    // Older, show as DD/MM
    return DateFormat('dd/MM').format(time);
  }
}

/// date format
String formatDate(DateTime dateTime) {
  return DateFormat('dd MMMM yy h:mm a').format(dateTime);
}

String formatDateFromString(String dateStr) {
  try {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yy h:mm a').format(dateTime);
  } catch (e) {
    return '-';
  }
}

/// firsts latter's capital
String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1);
}

/// manage this data /// time ago format

String timeAgoFromUtc(String input) {
  // Step 1: Parse your custom format "20-06-2025 13:23"
  final parts = input.split(' ');
  if (parts.length != 2) return "Invalid date";

  final dateParts = parts[0].split('-');
  final timeParts = parts[1].split(':');

  if (dateParts.length != 3 || timeParts.length != 2) return "Invalid date";

  final day = int.tryParse(dateParts[0]);
  final month = int.tryParse(dateParts[1]);
  final year = int.tryParse(dateParts[2]);

  final hour = int.tryParse(timeParts[0]);
  final minute = int.tryParse(timeParts[1]);

  if ([day, month, year, hour, minute].contains(null)) return "Invalid date";

  final dateTime = DateTime(year!, month!, day!, hour!, minute!).toLocal();
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inSeconds < 60) return "Just now";
  if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
  if (diff.inHours < 24)
    return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
  if (diff.inDays < 7)
    return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";

  return "${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}";
}

String _getMonthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[month - 1];
}

Widget noDataWidget() => Image.asset(Assets.noData);

/// global padding data

EdgeInsetsGeometry globalBottomPadding(BuildContext context) =>
    EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom);



/// 24H converter
String convertTo24Hour(String time12h) {
  DateTime tempDate = DateFormat("hh:mm aaa").parse(time12h);
  String formattedDate = DateFormat('HH:mm').format(tempDate);
  print('formattedDate = $formattedDate');
  return formattedDate;
}

/// 12H converter
String convertTo12Hour(String? time24) {
  if (time24 == null || time24.isEmpty) return "";
  try {
    final time = DateFormat("HH:mm").parse(time24);
    return DateFormat("hh:mm a").format(time);
  } catch (e) {
    return time24;

  }
}

//
// /// time format management
// String formatTimeManagement(OpeningHour hour, {bool isOpen = true}) {
//   if (hour.active == false) {
//     return "Closed";
//   }
//
//   final value = isOpen ? hour.open : hour.close;
//
//   if (value == null || value.isEmpty) {
//     return "00:00";
//   }
//   try {
//     final time = DateFormat("HH:mm a").parse(value);
//     return DateFormat("hh:mm a").format(time); // 12h format
//   } catch (e) {
//     return value;
//   }
// }




TimeOfDay timeOfDayFromString(String timeStr) {
  final format = DateFormat("hh:mm a");
  final date = format.parse(timeStr);
  return TimeOfDay(hour: date.hour, minute: date.minute);
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat("hh:mm a").format(dt);
}




String extractAreaCity(String address) {
  try {
    List<String> parts = address.split(',');
    if (parts.length >= 3) {
      String area = parts[1].trim();  // "Bani Park"
      String city = parts[2].split('-')[0].trim(); // "Jaipur"
      return "$area, $city";
    }
    return address; // fallback
  } catch (e) {
    return address; // error fallback
  }
}
