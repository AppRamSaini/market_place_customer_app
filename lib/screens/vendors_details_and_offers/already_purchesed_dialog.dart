import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:market_place_customer/screens/dashboard/customer_dashboard.dart';
import 'package:market_place_customer/screens/profile_and_settings/login_required_dialog.dart';
import 'package:market_place_customer/utils/app_router.dart';

import '../../data/storage/sharedpreferenc.dart';

/// show already purchased dialog
Future<void> showAlreadyPurchasedDialog(BuildContext context) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Already Purchased",
    pageBuilder: (_, __, ___) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: Stack(
          children: [
            /// 🔹 Background blur
            GestureDetector(
              onTap: () => Navigator.of(context).pop(), // tap outside to close
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.black38),
              ),
            ),

            /// 🔹 Dialog content
            Center(
              child: ElasticIn(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🎉 Emoji animation
                      BounceInDown(
                        duration: const Duration(milliseconds: 800),
                        child: const Text(
                          "🎉",
                          style: TextStyle(fontSize: 48),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Already Purchased!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                          "You have already purchased this offer.\nEnjoy your benefits!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              height: 1.4)),

                      const SizedBox(height: 25),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          AppRouter().navigateAndClearStack(context,
                              const CustomerDashboard(selectedTabIndex: 1));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        icon: const Icon(Icons.check_circle_outline,
                            color: Colors.white),
                        label: const Text(
                          "Got it",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

/*Future<void> showAlreadyPurchasedDialog(BuildContext context) async {


  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Already Purchased",
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.93),
          elevation: 8,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ElasticIn(
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BounceInDown(
                        duration: const Duration(milliseconds: 700),
                        child: const Text("🎉",
                            style: TextStyle(fontSize: 52)),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Already Purchased!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You’ve already purchased this offer.\nEnjoy your benefits anytime!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          Navigator.of(context, rootNavigator: true).pop();
                          AppRouter().navigateAndClearStack(
                            context,
                            const CustomerDashboard(selectedTabIndex: 1),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 13),
                          elevation: 3,
                        ),
                        icon: const Icon(Icons.check_circle_outline,
                            color: Colors.white),
                        label: const Text(
                          "Got it",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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


  //
  // showGeneralDialog(
  //   context: context,
  //   barrierDismissible: true,
  //   barrierLabel: "Already Purchased",
  //   transitionDuration: const Duration(milliseconds: 250),
  //   pageBuilder: (context, anim1, anim2) {
  //     return
  //
  //
  //       BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
  //       child: AlertDialog(
  //         backgroundColor: Colors.white.withOpacity(0.93),
  //         elevation: 8,
  //         shape:
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //         contentPadding:
  //         const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
  //         content:
  //
  //         Stack(
  //           children: [
  //             /// 🔹 Background blur + tap outside to dismiss
  //             GestureDetector(
  //               onTap: () => Navigator.of(context, rootNavigator: true).pop(),
  //               child: BackdropFilter(
  //                 filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
  //                 child: Container(color: Colors.black38),
  //               ),
  //             ),
  //
  //             /// 🔹 Dialog content
  //             Center(
  //               child: ElasticIn(
  //                 duration: const Duration(milliseconds: 600),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     BounceInDown(
  //                       duration: const Duration(milliseconds: 700),
  //                       child: const Text("🎉",
  //                           style: TextStyle(fontSize: 52)),
  //                     ),
  //                     const SizedBox(height: 10),
  //                     const Text(
  //                       "Already Purchased!",
  //                       style: TextStyle(
  //                         fontSize: 22,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.green,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 10),
  //                     const Text(
  //                       "You’ve already purchased this offer.\nEnjoy your benefits anytime!",
  //                       textAlign: TextAlign.center,
  //                       style: TextStyle(
  //                         color: Colors.black87,
  //                         fontSize: 15,
  //                         height: 1.4,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 28),
  //                     ElevatedButton.icon(
  //                       onPressed: () {
  //                         HapticFeedback.mediumImpact();
  //                         Navigator.of(context, rootNavigator: true).pop();
  //                         AppRouter().navigateAndClearStack(
  //                           context,
  //                           const CustomerDashboard(selectedTabIndex: 1),
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.green,
  //                         shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12)),
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 36, vertical: 13),
  //                         elevation: 3,
  //                       ),
  //                       icon: const Icon(Icons.check_circle_outline,
  //                           color: Colors.white),
  //                       label: const Text(
  //                         "Got it",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  //   transitionBuilder: (context, anim1, anim2, child) {
  //     return FadeTransition(
  //       opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
  //       child: ScaleTransition(
  //         scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
  //         child: child,
  //       ),
  //     );
  //   },
  // );
}*/

/// displaying expired dialog
Future<void> showOfferExpiredDialog(BuildContext context) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Offer Expired",
    pageBuilder: (_, __, ___) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: Stack(
          children: [
            /// 🔹 Background blur
            GestureDetector(
              onTap: () => Navigator.of(context).pop(), // tap outside to close
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black38),
              ),
            ),

            /// 🔹 Dialog content
            Center(
              child: ElasticIn(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// ⚠️ Emoji animation
                      BounceInDown(
                        duration: const Duration(milliseconds: 800),
                        child: const Text(
                          "⏰",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Offer Expired",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Oops! This offer has expired.\nPlease check other available offers.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 25),

                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white),
                        label: const Text(
                          "Close",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// checked ,login required
Future<bool> checkedLogin(BuildContext context) async {
  final token = LocalStorage.getString(Pref.token);
  final bool isNotLoggedIn = token == null || token.isEmpty;

  if (isNotLoggedIn) {
    await showLoginRequiredDialog(context, onClose: () {});
    return false;
  }

  return true;
}
