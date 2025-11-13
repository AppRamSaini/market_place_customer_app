import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_place_customer/utils/app_assets.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffix;
  final int? maxLength;
  final Widget? prefix;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final int maxLines;
  final int minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.hintText,
    this.readOnly = false,
    this.controller,
    this.suffix,
    this.maxLength,
    this.prefix,
    this.onChanged,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatters,
    this.validator,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorMessage;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          errorMessage = widget.validator?.call(widget.controller?.text);
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            validator: (value) {
              final error = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) setState(() => errorMessage = error);
              });
              return error;
            },
            onChanged: (value) {
              setState(() {
                errorMessage = widget.validator?.call(value);
              });

              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            decoration: InputDecoration(
              isDense: true,
              counter: const SizedBox(),
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey.shade500),

              // hide flutter default red line/message
              errorStyle: const TextStyle(height: 0, fontSize: 0),

              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
        ),
        widget.validator != null
            ? AnimatedOpacity(
                opacity:
                    (errorMessage != null && errorMessage!.isNotEmpty) ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, left: 6),
                  child: Text(
                    errorMessage ?? "",
                    style: AppStyle.normal_13(AppColors.red600),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

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
      this.onChanged,
      this.onTap,
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
