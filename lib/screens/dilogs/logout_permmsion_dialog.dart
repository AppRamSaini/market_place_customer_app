import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

showLogoutPermissionDialog(BuildContext context,
    {required VoidCallback onConfirm}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Logout Dialog",
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: FadeInUp(
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
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// 🔥 Animated LOGOUT Icon (Pulse + Bounce)
                    BounceInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Pulse(
                        infinite: true,
                        duration: const Duration(seconds: 2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.15),
                              shape: BoxShape.circle),
                          padding: const EdgeInsets.all(20),
                          child: const Icon(
                            Icons.logout_rounded,
                            size: 30,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// Title
                    FadeIn(
                      duration: const Duration(milliseconds: 600),
                      child: const Text(
                        "Logout?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Message
                    FadeIn(
                      delay: const Duration(milliseconds: 150),
                      duration: const Duration(milliseconds: 600),
                      child: const Text(
                        "Are you sure you want to logout?\nYou will need to login again to continue.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Buttons (Slide Animation)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// Cancel Button
                        SlideInLeft(
                          duration: const Duration(milliseconds: 500),
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.orange),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        /// Logout Button
                        SlideInRight(
                          duration: const Duration(milliseconds: 500),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onConfirm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 13),
                            ),
                            child: const Text(
                              "Logout",
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
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: child,
      );
    },
  );
}
