import 'dart:ui';

import '../../utils/exports.dart';

/// Dialog: Offer Already Used
Future<void> showAlreadyUsedOfferDialog(BuildContext context) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Offer Already Used",
    pageBuilder: (_, __, ___) => Container(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: Stack(
          children: [
            /// Background blur
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(color: Colors.black38)),

            /// Dialog Box
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
                      /// Icon Animation
                      BounceInDown(
                        duration: const Duration(milliseconds: 800),
                        child: const Text("⚠️", style: TextStyle(fontSize: 48)),
                      ),

                      const SizedBox(height: 12),

                      /// Title
                      const Text(
                        "Offer Already Used",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Subtitle
                      const Text(
                        "You’ve already redeemed this offer.\n"
                        "This offer cannot be used again. Please explore other available offers.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.45,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Button
                      ElevatedButton(
                        onPressed: () {
                          AppRouter().navigateAndClearStack(context,
                              const CustomerDashboard(selectedTabIndex: 1));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                        ),
                        child: const Text(
                          "Browse Offers",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
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
