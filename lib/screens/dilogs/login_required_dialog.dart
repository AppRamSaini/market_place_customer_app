import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:market_place_customer/screens/auth/login.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_router.dart';

showLoginRequiredDialog(BuildContext context, {required VoidCallback onClose}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Login Required Dialog",
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔸 Animated Icon
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.themeColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(Icons.lock_outline_rounded,
                        color: AppColors.themeColor, size: 45),
                  ),

                  const SizedBox(height: 18),

                  // 🔸 Title
                  const Text(
                    "Login Required",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔸 Subtitle / Message
                  const Text(
                    "Please log in to continue.\nAccess to this offer is limited to registered users only.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🔸 Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onClose();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.themeColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          AppRouter().navigateTo(context, const LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 12),
                        ),
                        child: const Text(
                          "Login Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        ),
      );
    },
  );
}
