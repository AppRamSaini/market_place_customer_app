import 'package:market_place_customer/utils/exports.dart';

/// CUSTOM BUTTON 1
Widget CustomButton(
        {required void Function()? onPressed,
        Color bgColor = AppColors.themeColor,
        Color txtColor = AppColors.whiteColor,
        String? txt,
        double? minWidth}) =>
    MaterialButton(
      minWidth: minWidth,
      height: size.height * 0.055,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(
        txt.toString(),
        style: AppStyle.medium_16(txtColor),
      ),
    );

/// CUSTOM BUTTON 2
Widget CustomButton2(
        {required void Function()? onPressed,
        Color bgColor = AppColors.themeColor,
        Color txtColor = AppColors.whiteColor,
        String? txt,
        double? minWidth,
        double? height}) =>
    MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      minWidth: minWidth,
      height: height,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        txt.toString(),
        style: AppStyle.normal_10(txtColor),
      ),
    );

/// CUSTOM BUTTON 3
Widget CustomButton3(
        {required void Function()? onPressed,
        Color bgColor = AppColors.themeColor,
        Color txtColor = AppColors.whiteColor,
        String? txt,
        double? minWidth,
        double? height}) =>
    MaterialButton(
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 3),
      minWidth: minWidth,
      height: height,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        txt.toString(),
        style: AppStyle.normal_14(txtColor),
      ),
    );


/// CUSTOM  BACK OR NEXT BUTTONS
Widget backOrNextBtn({
  required BuildContext context,
  bool hideOnBack = false,
  double? minWidth,
  required void Function()? onBack,
  required void Function()? onNext,
  String? text2 = 'Next',
  String? text1 = 'Back',
}) =>
    Padding(
      padding: globalBottomPadding(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hideOnBack
                ? SizedBox()
                : CustomButton3(
                    onPressed: onBack,
                    txt: text1,
                    height: size.height * 0.05,
                    minWidth: size.width * 0.4,
                    bgColor: AppColors.black20.withOpacity(0.5)),
            CustomButton3(
                onPressed: onNext,
                txt: text2,
                height: size.height * 0.05,
                minWidth: minWidth ?? size.width * 0.4),
          ],
        ),
      ),
    );
