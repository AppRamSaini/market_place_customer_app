import 'exports.dart';

/// snack bar message
void snackBar(BuildContext context, String title,
    [Color color = AppColors.green]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      clipBehavior: Clip.antiAlias,
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

/// global padding data
EdgeInsetsGeometry globalBottomPadding(BuildContext context) =>
    EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom);

/// firsts latter's capitalization
String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return '';
  return text[0].toUpperCase() + text.substring(1);
}

/// error message
Widget errorMessage(String error, {double? topSize}) => Center(
      child: Padding(
        padding: EdgeInsets.only(
            left: size.width * 0.1,
            right: size.width * 0.1,
            top: topSize ?? 0.0),
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: AppStyle.medium_14(AppColors.redColor),
        ),
      ),
    );
