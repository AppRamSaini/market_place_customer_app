import 'package:market_place_customer/utils/exports.dart';

AppBar customAppbar(
        {BuildContext? context,
        String? title,
        List<Widget>? actions,
        bool hideLeading = false}) =>
    AppBar(
      elevation: 0,
      leading: !hideLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 20, color: AppColors.themeColor),
              onPressed: () => Navigator.pop(context!))
          : null,
      title: Text(title.toString(),
          style: AppStyle.medium_20(AppColors.themeColor)),
      actions: actions,
    );

/// CUSTOM SLIVER APP BAR

SliverAppBar customSliverAppbar(
        {Widget? title, Widget? flexibleSpace, double? expandedHeight}) =>
    SliverAppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        expandedHeight: expandedHeight,
        floating: true,
        pinned: true,
        stretch: true,
        automaticallyImplyLeading: false,
        title: title,
        flexibleSpace: flexibleSpace);
