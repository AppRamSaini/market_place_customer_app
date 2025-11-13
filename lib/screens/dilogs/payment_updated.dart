import 'dart:ui';

import 'package:market_place_customer/utils/exports.dart';

bool _paymentDialogOpen = false;

void showAmountUpdatedDialog(
  BuildContext context, {
  required double newAmount,
  required VoidCallback onClose,
}) {
  if (_paymentDialogOpen) return;
  _paymentDialogOpen = true;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Amount Updated Dialog",
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 1),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                    builder: (_, value, child) => Transform.scale(
                      scale: value,
                      child: child,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.themeColor,
                        size: 60,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Amount Updated Successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Your payment amount has been successfully updated by the vendor.\nPlease review the updated details below:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.45,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Amount details
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Updated Final Amount: ₹${newAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.themeColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _paymentDialogOpen = false;
                      onClose();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).then((_) {
    _paymentDialogOpen = false;
  });
}
