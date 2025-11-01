import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/exports.dart';

///  Listen to specific offer's verification status in real-time
void listenSpecificOfferVerification(
    {required BuildContext context, required String offerId}) {
  final userId = LocalStorage.getString(Pref.userId);
  if (userId == null || userId.isEmpty) return;

  bool dialogShown = false;

  FirebaseFirestore.instance
      .collection('offers')
      .where('offerId', isEqualTo: offerId)
      .where('userId', isEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isEmpty) return;

    final data = snapshot.docs.first.data();
    final status = data['status']?.toString() ?? '';

    debugPrint('🔥 Offer Status: $status');

    if (status == 'pending' && !dialogShown) {
      dialogShown = true;

      _showPendingPaymentDialog(
        context,
        onClose: () {
          dialogShown = false;
        },
      );
    } else if (status == 'success' && dialogShown) {
      Navigator.of(context, rootNavigator: true).pop();
      dialogShown = false;
      snackBar(context, "Payment verified successfully!", AppColors.green);
    } else if (status == 'failed' && dialogShown) {
      Navigator.of(context, rootNavigator: true).pop();
      dialogShown = false;
      snackBar(
          context, "Payment failed! Please try again.", AppColors.redColor);
    }
  });
}

///  Pending Payment Dialog
void _showPendingPaymentDialog(BuildContext context,
    {required VoidCallback onClose}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Pending Payment Dialog",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.95),
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.hourglass_top,
                  color: Colors.orangeAccent, size: 60),
              const SizedBox(height: 16),
              const Text(
                "Payment Under Verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your payment is being verified.\nOnce confirmed, this will update automatically.",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  onClose(); // ✅ Proper reset
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  "Got it",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
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
}
