import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_bloc.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_event.dart';
import 'package:market_place_customer/screens/dilogs/payment_approved.dart';
import 'package:market_place_customer/screens/dilogs/payment_updated.dart';
import 'package:market_place_customer/utils/dialog_controller.dart';

import '../../utils/exports.dart';
import '../qr_management/generate_qr_code.dart';

Future<void> verifyPaymentForUsedOffers({
  required QrCodeContentModel offers,
  required BuildContext context,
}) async {
  final firestore = FirebaseFirestore.instance;

  final docRef = firestore.collection('purchased_offers').doc(offers.offerId);

  final existingDoc = await docRef.get();

  if (!existingDoc.exists) {
    await docRef.set({
      'offer_id': offers.offerId,
      'amount': offers.totalAmount,
      'updated_amount': "",
      'status': 'verifying',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}

void listenSpecificOfferVerificationForUsedOffers({
  required BuildContext context,
  required String offerId,
}) {
  FirebaseFirestore.instance
      .collection('purchased_offers')
      .doc(offerId)
      .snapshots()
      .listen((snapshot) {
    if (!snapshot.exists) return;

    final status = snapshot['status']?.toString() ?? '';
    final amount = snapshot['amount']?.toString() ?? '';
    debugPrint("🔥 REALTIME STATUS = $status");

    // CLOSE EXISTING DIALOG IF ANY
    if (DialogController.isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();
      DialogController.closeDialog();
    }

    // SHOW CORRECT DIALOG
    if (status == "approved") {
      context.read<PurchasedOffersBloc>().add(
          PurchasedOffersDetailsEvent(context: context, offersId: offerId));
      DialogController.openDialog();
      showPaymentApprovedDialog(context, onClose: DialogController.closeDialog);
    } else if (status == "update_amount") {
      DialogController.openDialog();
      showAmountUpdatedDialog(context,
          onClose: DialogController.closeDialog,
          newAmount: double.parse(amount.toString()));
      context.read<PurchasedOffersBloc>().add(
          PurchasedOffersDetailsEvent(context: context, offersId: offerId));
    } else if (status == "failed") {
      DialogController.closeDialog();
      snackBar(
          context, "Payment failed! Please try again.", AppColors.redColor);
    }
  });
}
