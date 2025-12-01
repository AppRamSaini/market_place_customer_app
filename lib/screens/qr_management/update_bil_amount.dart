import '../../utils/exports.dart';

Future<void> updateBillAmount({
  required BuildContext context,
  required TextEditingController amountController,
  required int minBillAmount,
  void Function()? onPressed,
}) async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// 🟢 Create LOCAL CONTROLLER to avoid resetting issue
  final localController = TextEditingController(text: amountController.text);

  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
              vertical: size.height * 0.03,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Handle Bar
                  Container(
                    height: 5,
                    width: 55,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Update Bill Amount",
                        style: AppStyle.semiBold_18(AppColors.themeColor),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Enter the updated bill amount below to modify the payable total.",
                    textAlign: TextAlign.center,
                    style: AppStyle.normal_14(AppColors.black50),
                  ),

                  const SizedBox(height: 25),

                  /// TEXT FIELD (using local controller)
                  CustomTextField(
                    controller: localController,
                    hintText: "Enter amount",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    prefix: const Icon(Icons.currency_rupee_rounded,
                        color: AppColors.themeColor),
                    validator: (value) {
                      if (localController.text.isEmpty) {
                        return 'Please enter total bill amount';
                      } else if (int.tryParse(localController.text)! <
                          minBillAmount) {
                        return 'Bill amount must be at least ₹$minBillAmount';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// UPDATE BUTTON
                  CustomButtons.rounded(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        /// 🟢 Transfer back final value (only once)
                        amountController.text = localController.text;

                        Navigator.pop(context);
                        onPressed?.call();
                      }
                    },
                    text: "Update Amount",
                    bgColor: AppColors.themeColor,
                    height: size.height * 0.055,
                    width: size.width,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info_outline,
                          size: 18, color: AppColors.greyColor),
                      const SizedBox(width: 6),
                      Text(
                        "Make sure this matches the actual bill total.",
                        style: AppStyle.normal_12(AppColors.black50),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
