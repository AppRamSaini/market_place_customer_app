import 'package:market_place_customer/utils/exports.dart';

Future<void> updateBillAmount({
  required BuildContext context,
  required TextEditingController amountController,
  required int minBillAmount,
  void Function()? onPressed,
}) async {
  double _calculatedDiscount = 0.0;
  double _payableAmount = 0.0;
  bool _isValidAmount = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  if (amountController.text.isNotEmpty) {
    double value = double.tryParse(amountController.text) ?? 0.0;
    if (value == value.toInt()) {
      amountController.text = value.toInt().toString();
    } else {
      amountController.text = value.toString();
    }
  }

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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  // Drag handle
                  Container(
                    height: 5,
                    width: 55,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  // Header Row
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

                  // Sub info
                  Text(
                    "Enter the updated bill amount below to modify the payable total.",
                    textAlign: TextAlign.center,
                    style: AppStyle.normal_14(AppColors.black50),
                  ),

                  const SizedBox(height: 25),

                  // Text Field
                  CustomTextField(
                    controller: amountController,
                    hintText: "Enter amount",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    suffix: Text("₹${_calculatedDiscount.toStringAsFixed(0)}",
                        style: AppStyle.medium_14(AppColors.green)),
                    prefix: const Icon(Icons.currency_rupee_rounded,
                        color: AppColors.themeColor),
                    validator: (value) {
                      if (amountController == null ||
                          amountController.text.isEmpty) {
                        return 'Please enter total bill amount';
                      } else if (int.tryParse(amountController.text)! <
                          minBillAmount) {
                        return 'Bill amount must be at least ₹$minBillAmount';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  // Update Button
                  CustomButtons.rounded(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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

                  // Tip Section (optional but nice touch)
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
