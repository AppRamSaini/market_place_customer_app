import 'package:market_place_customer/utils/exports.dart';

class CustomButtons {
  // ------------------------------
  // BUTTON 1 (Gradient + Animated)
  // ------------------------------
  static Widget primary(
      {required String text,
      required VoidCallback? onPressed,
      double? width,
      double height = 50,
      bool animate = true,
      Color textColor = AppColors.whiteColor}) {
    final button = GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.themeColor,
              AppColors.themeColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.themeColor.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppStyle.medium_16(textColor),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.034, vertical: size.height * 0.02),
      child: animate
          ? FadeInUp(duration: const Duration(milliseconds: 700), child: button)
          : button,
    );
  }

  // ------------------------------
  // BUTTON 2 (Simple Material)
  // ------------------------------
  static Widget small({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    double? height,
    Color bgColor = AppColors.themeColor,
    Color textColor = AppColors.whiteColor,
  }) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      minWidth: width,
      height: height,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: AppStyle.normal_10(textColor),
      ),
    );
  }

  // ------------------------------
  // BUTTON 3 (Rounded Material)
  // ------------------------------
  static Widget rounded({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    double? height,
    Color bgColor = AppColors.themeColor,
    Color textColor = AppColors.whiteColor,
  }) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      minWidth: width,
      height: height,
      elevation: 0,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        text,
        style: AppStyle.normal_14(textColor),
      ),
    );
  }

  // -----------------------------------
  // BACK – NEXT BUTTON COMBO
  // -----------------------------------
  static Widget backNext({
    required BuildContext context,
    required VoidCallback onBack,
    required VoidCallback onNext,
    String backText = 'Back',
    String nextText = 'Next',
    double? width,
    bool hideBack = false,
  }) {
    return Padding(
      padding: globalBottomPadding(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hideBack
                ? const SizedBox()
                : rounded(
                    text: backText,
                    onPressed: onBack,
                    height: size.height * 0.05,
                    width: size.width * 0.4,
                    bgColor: AppColors.black20.withOpacity(0.5),
                  ),
            rounded(
              text: nextText,
              onPressed: onNext,
              height: size.height * 0.05,
              width: width ?? size.width * 0.4,
            ),
          ],
        ),
      ),
    );
  }
}
