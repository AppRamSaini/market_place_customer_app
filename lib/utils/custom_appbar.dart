import 'package:flutter/material.dart';
import 'package:market_place_customer/main.dart';
import 'package:market_place_customer/utils/app_styles.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/exports.dart';

AppBar customAppbar(
        {BuildContext? context, String? title, List<Widget>? actions}) =>
    AppBar(
      centerTitle: false,
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: AppColors.blackColor),
          onPressed: () => Navigator.pop(context!)),
      title: Text(title.toString(),
          style: AppStyle.normal_19(AppColors.blackColor)),
      actions: actions,
    );

/// CUSTOM SLIVER APP BAR

SliverAppBar customSliverAppbar({Widget? title, Widget? flexibleSpace,double? expandedHeight}) =>
    SliverAppBar(
      foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        expandedHeight: expandedHeight,
        floating: true,
        pinned: true,
        stretch: true,
        automaticallyImplyLeading: false,
        title:  title,
        flexibleSpace: flexibleSpace);


String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please provide the email address";
  }

  // Simple email regex
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value.trim())) {
    return "Please enter a valid email address";
  }

  return null; // valid
}
