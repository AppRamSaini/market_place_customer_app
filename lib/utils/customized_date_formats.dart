import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place_customer/utils/app_assets.dart';

/// date format AM / PM
String formatDateAMPM(DateTime dateTime) {
  return DateFormat('dd MMMM yy').format(dateTime);
}

/// formated time Hindi time
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

///  simple date format with date + time with  Am pm
String formatDate(DateTime dateTime) {
  return DateFormat('dd MMMM yy h:mm a').format(dateTime);
}

///  simple date format with date + time with  Am pm  with String format
String formatDateFromString(String dateStr) {
  try {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMMM yy h:mm a').format(dateTime);
  } catch (e) {
    return '-';
  }
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
  if (diff.inHours < 24) {
    return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
  }
  if (diff.inDays < 7) {
    return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
  }

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

/// 24H converter
String convertTo24Hour(String time12h) {
  DateTime tempDate = DateFormat("hh:mm aaa").parse(time12h);
  String formattedDate = DateFormat('HH:mm').format(tempDate);
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

/// time format UTC to IST (in local time zone)
String formatToLocalDateTime(String utcTimeString) {
  try {
    final utcDate = DateTime.parse(utcTimeString);
    final localDate = utcDate.toLocal(); // convert UTC → local time
    return DateFormat('dd MMM yyyy, hh:mm a').format(localDate);
  } catch (e) {
    return "Invalid Date";
  }
}
