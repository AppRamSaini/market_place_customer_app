import 'package:flutter/material.dart';

class AppRouter {
  /// Normal Push
  void navigateTo(BuildContext context, Widget secondScreen) {
    Navigator.push(
      context,
      _buildCustomRoute(secondScreen),
    );
  }

  /// Push Replacement
  void replaceWith(BuildContext context, Widget secondScreen) {
    Navigator.pushReplacement(
      context,
      _buildCustomRoute(secondScreen),
    );
  }

  /// Push and Remove Until (clear all previous routes)
  void navigateAndClearStack(BuildContext context, Widget secondScreen) {
    Navigator.pushAndRemoveUntil(
      context,
      _buildCustomRoute(secondScreen),
      (route) => false,
    );
  }

  /// Custom Page Route (iOS-style dual slide animation)
  PageRouteBuilder _buildCustomRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        /// ---- NEW PAGE ANIMATION (Right → Left) ----
        final newPageSlide = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));

        /// ---- OLD PAGE SUBTLE MOVE (Right → Left) ----
        final oldPageSlide = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.2, 0.0), // smooth parallax effect
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOutCubic,
        ));

        return SlideTransition(
          position: oldPageSlide, // OLD screen moves slightly
          child: SlideTransition(
            position: newPageSlide, // NEW screen slides fully
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 260),
    );
  }
}
