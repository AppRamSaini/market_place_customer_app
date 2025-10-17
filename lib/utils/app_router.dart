import 'package:flutter/material.dart';

class AppRouter {
  /// Normal Push
   navigateTo(BuildContext context, Widget secondScreen) {
    Navigator.push(
      context,
      _buildCustomRoute(secondScreen),
    );
  }

  ///  Push Replacement
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

  /// Common Custom Route Builder
  PageRouteBuilder _buildCustomRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        late Animation<Offset> customAnimation;

        // Forward = push, Reverse = pop
        if (animation.status == AnimationStatus.forward) {
          customAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Right to left
            end: Offset.zero,
          ).animate(animation);
        } else {
          customAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0), // Bottom to top on back
            end: Offset.zero,
          ).animate(animation);
        }

        return SlideTransition(
          position: customAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 230),
    );
  }
}
