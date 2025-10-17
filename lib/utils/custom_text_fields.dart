import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_place_customer/utils/app_assets.dart';
import 'package:market_place_customer/utils/app_styles.dart';
import 'package:market_place_customer/utils/app_colors.dart';

/// CUSTOM TEXT FIELDS
Widget customTextField(
        {String? hintText,
        bool readOnly = false,
        bool showPrefix = false,
        TextEditingController? controller,
        Widget? suffix,
        int? maxLength,
        Widget? prefix,
        void Function(String)? onChanged,
        TextInputType? keyboardType,
        int? maxLines = 1,
        int? minLines = 1,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,
        void Function()? onTap}) =>
    TextFormField(
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      style: AppStyle.normal_16(AppColors.blackColor),
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          isDense: true,
          counter: const SizedBox(),
          filled: true,
          prefixIcon: prefix,
          fillColor: AppColors.theme10,
          hintText: hintText,
          hintStyle: AppStyle.normal_16(AppColors.black20),
          suffixIcon: suffix,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme10, width: 0.5))),
    );

// /// SEARCH TEXT FIELD
// Widget searchTextFields(
//         {String? hintText,
//         bool readOnly = false,
//         bool showPrefix = false,
//         TextEditingController? controller,
//         Widget? suffix,
//         int? maxLength,
//         Widget? prefix,
//         Color? fillColor,
//         void Function(String)? onChanged,
//         TextInputType? keyboardType,
//         String? Function(String?)? validator,
//         void Function()? onTap}) =>
//     TextFormField(
//       keyboardType: keyboardType,
//       readOnly: readOnly,
//       onTap: onTap,
//       controller: controller,
//       style: AppStyle.medium_16(AppColors.whiteColor),
//       validator: validator,
//       maxLength: maxLength,
//       onChanged: onChanged,
//       textInputAction: TextInputAction.done,
//       cursorColor: AppColors.whiteColor,
//       decoration: InputDecoration(
//           isDense: true,
//           counter: const SizedBox(),
//           filled: true,
//           prefixIcon: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Image.asset(Assets.searchIcon,
//                   height: 10, width: 10, color: AppColors.whiteColor)),
//           fillColor: fillColor,
//           hintText: hintText,
//           hintStyle: AppStyle.normal_16(AppColors.whiteColor),
//           suffixIcon: suffix,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
//           disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
//           focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(30),
//               borderSide: BorderSide(color: AppColors.theme10, width: 0.5))),
//     );

List<String>? hints = [
  "Search restaurants",
  "Search salons",
  "Search clothes nearby",
  "Find offers & coupons",
];

class AnimatedHintSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffix;
  final Color? fillColor;
  bool readOnly;

  void Function()? onTap;

  final void Function(String)? onChanged;

  AnimatedHintSearchField(
      {super.key,
      this.controller,
      this.suffix,
      this.fillColor,
      this.onChanged,   this.onTap,
      this.readOnly = false});

  @override
  State<AnimatedHintSearchField> createState() =>
      _AnimatedHintSearchFieldState();
}

class _AnimatedHintSearchFieldState extends State<AnimatedHintSearchField> {
  int _currentHintIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentHintIndex =
            (_currentHintIndex + 1) % hints!.length; // rotate hints
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      controller: widget.controller,
      style: AppStyle.medium_16(AppColors.whiteColor),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        isDense: true,
        counter: const SizedBox(),
        filled: true,
        fillColor: widget.fillColor,
        prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(Assets.searchIcon,
                height: 10, width: 10, color: AppColors.white80)),
        hintText: hints![_currentHintIndex],
        hintStyle: AppStyle.normal_16(AppColors.white80),
        suffixIcon: widget.suffix,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.theme10, width: 0.5),
        ),
      ),
    );
  }
}

class AnimatedHintSearchField1 extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? suffix;
  final Color? fillColor;
  bool readOnly;

  final void Function(String)? onChanged;

  AnimatedHintSearchField1(
      {super.key,
      this.controller,
      this.suffix,
      this.fillColor,
      this.onChanged,
      this.readOnly = false});

  @override
  State<AnimatedHintSearchField1> createState() =>
      _AnimatedHintSearchField1State();
}

class _AnimatedHintSearchField1State extends State<AnimatedHintSearchField1> {
  int _currentHintIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentHintIndex =
            (_currentHintIndex + 1) % hints!.length; // rotate hints
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      readOnly: widget.readOnly,
      controller: widget.controller,
      style: AppStyle.normal_16(AppColors.blackColor),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        isDense: true,
        counter: const SizedBox(),
        filled: true,
        fillColor: widget.fillColor,
        prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(Assets.searchIcon,
                height: 10, width: 10, color: AppColors.blackColor)),
        hintText: hints![_currentHintIndex],
        hintStyle: AppStyle.normal_16(AppColors.blackColor),
        suffixIcon: widget.suffix,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.theme10, width: 0.5)),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.theme10, width: 0.5),
        ),
      ),
    );
  }
}
