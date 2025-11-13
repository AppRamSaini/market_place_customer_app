import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

showDeleteAccountDialog(BuildContext context,
    {required VoidCallback onConfirm}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Delete Account Dialog",
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: FadeInUp(
              // 🔥 Whole dialog animation
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,

              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🔥 Animated Delete Icon (Bounce + Pulse)
                    BounceInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Pulse(
                        infinite: true,
                        duration: const Duration(seconds: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            size: 30,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// Title
                    FadeIn(
                      duration: const Duration(milliseconds: 600),
                      child: const Text(
                        "Delete Account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Subtitle
                    FadeIn(
                      delay: const Duration(milliseconds: 150),
                      duration: const Duration(milliseconds: 600),
                      child: const Text(
                        "Are you sure you want to delete your account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// Cancel Button Animation
                        SlideInLeft(
                          duration: const Duration(milliseconds: 500),
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.redAccent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 38, vertical: 12)),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        /// Delete Button Animation
                        SlideInRight(
                          duration: const Duration(milliseconds: 500),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onConfirm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 13),
                            ),
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
        ),
      );
    },

    /// Dialog Fade Transition
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: child,
      );
    },
  );
}
