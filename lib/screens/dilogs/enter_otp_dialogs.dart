import '../../utils/exports.dart';

Future<void> showOtpDialog(
  BuildContext context, {
  required String mobile,
  required Function(String otp) onVerify,
}) async {
  final TextEditingController otpController = TextEditingController();
  String? errorText;
  bool isValidOtp = false;

  await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (context, animation, secondary, child) {
      final curved = Curves.easeOutBack.transform(animation.value);

      final defaultPinTheme = PinTheme(
        width: 55,
        height: 55,
        textStyle: AppStyle.medium_20(AppColors.themeColor),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      );

      return Transform.scale(
        scale: curved,
        child: Opacity(
          opacity: animation.value,
          child: StatefulBuilder(
            builder: (context, setState) {
              /// REAL-TIME validation function
              void validate(String value) {
                if (value.isEmpty) {
                  errorText = "Please enter OTP";
                  isValidOtp = false;
                } else if (value.length < 6) {
                  errorText =
                      "Please enter the 6-digit OTP received on your mobile number";
                  isValidOtp = false;
                } else {
                  errorText = null;
                  isValidOtp = true;
                }
                setState(() {});
              }

              return Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.2))
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Text("Enter OTP",
                            style: AppStyle.medium_20(AppColors.themeColor)),
                        const SizedBox(height: 5),
                        Text(
                          "A 6-digit code was sent to $mobile",
                          textAlign: TextAlign.center,
                          style: AppStyle.normal_13(Colors.black54),
                        ),
                        const SizedBox(height: 25),

                        /// OTP INPUT (REAL TIME VALIDATION HERE)
                        Pinput(
                          length: 6,
                          controller: otpController,
                          defaultPinTheme: defaultPinTheme,
                          onChanged: validate,
                          onCompleted: validate,
                        ),

                        /// REAL-TIME ERROR BELOW OTP
                        if (errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                errorText!,
                                style: AppStyle.normal_15(AppColors.red600),
                              ),
                            ),
                          ),

                        const SizedBox(height: 20),

                        /// VERIFY BUTTON (DISABLED UNTIL VALID)
                        Opacity(
                          opacity: isValidOtp ? 1.0 : 0.5,
                          child: IgnorePointer(
                            ignoring: !isValidOtp,
                            child: CustomButtons.primary(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              text: "Verify OTP",
                              onPressed: () {
                                onVerify(otpController.text.trim());
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: AppStyle.medium_16(AppColors.red600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}
