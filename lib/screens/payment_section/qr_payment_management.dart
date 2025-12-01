import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/purchased_offers_details/purchased_offers_event.dart';
import 'package:market_place_customer/screens/dilogs/payment_approved.dart';
import 'package:market_place_customer/screens/dilogs/payment_updated.dart';
import 'package:market_place_customer/screens/dilogs/payment_verifying.dart';
import 'package:market_place_customer/utils/dialog_controller.dart';

import '../../utils/exports.dart';
import '../qr_management/generate_qr_code.dart';

Future<void> verifyPaymentForUsedOffers(
    {required QrCodeContentModel offers, required BuildContext context}) async {
  print("🔥 CALLED UPDATE: ===>>>${offers.offerId}");

  final firestore = FirebaseFirestore.instance;

  final docRef = firestore.collection('purchased_offers').doc(offers.offerId);

  final existingDoc = await docRef.get();

  if (!existingDoc.exists) {
    await docRef.set({
      'offer_id': offers.offerId,
      'amount': offers.totalAmount,
      'updated_amount': '',
      'status': 'creating',
      'is_amount_update': '',
      'is_amount_updated': '',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}

/// update payment status on firebase
Future<void> updatePaymentDataOnFirebaseForUsedOffers(
    {required String offerId,
    required String status,
    required String amount,
    required String from,
    bool isAmountUpdate = false}) async {
  final firestore = FirebaseFirestore.instance;

  final docRef = firestore.collection('purchased_offers').doc(offerId);

  await docRef.set({
    'offer_id': offerId,
    'amount': amount,
    'updated_amount': amount,
    'status': status,
    'update_amount_from': from,
    'is_amount_updated': isAmountUpdate,
    'updatedAt': DateTime.now().millisecondsSinceEpoch,
  }, SetOptions(merge: true));
}

listenSpecificOfferVerificationForUsedOffers({
  required BuildContext context,
  required String offerId,
}) {
  FirebaseFirestore.instance
      .collection("purchased_offers")
      .doc(offerId)
      .snapshots()
      .listen((event) {
    if (!event.exists) return;

    final data = event.data()!;
    final status = data["status"].toString();
    final amount = data["amount"].toString();
    final offerId = data["offer_id"].toString();
    final isUpdated = data["amount"].toString();

    print("🔥 FIREBASE STATUS → $status");

    // -------------------------------------------
    // STEP 1: VERIFYING → Show verifying dialog
    // -------------------------------------------
    if (status == "verifying") {
      showVerifyingDialog(context);
      return;
    }

    // -------------------------------------------
    // STEP 2: UPDATE_AMOUNT → close old → show updated dialog
    // -------------------------------------------
    if (status == "update_amount") {
      showAmountUpdatedDialog(
        context,
        newAmount: double.tryParse(amount) ?? 0,
        onClose: () {
          print('object');
          closeActiveDialog();
          context.read<PurchasedOffersBloc>().add(PurchasedOffersDetailsEvent(
              context: context, offersId: offerId.toString()));
        },
      );
      return;
    }

    // -------------------------------------------
    // STEP 3: APPROVED → close old → show approved dialog
    // -------------------------------------------
    if (status == "approved") {
      showPaymentApprovedDialog(context: context, onClose: () {});
      context.read<OrderHistoryBloc>().add(
          GetOrderHistoryEvent(context: context, page: 1, isLoadMore: false));
      context.read<PurchasedOffersHistoryBloc>().add(
          GetPurchasedOffersHistoryEvent(
              context: context, page: 1, isLoadMore: false));
      Timer.periodic(const Duration(milliseconds: 300), (timer) {
        AppRouter().navigateAndClearStack(
            context, const CustomerDashboard(selectedTabIndex: 1));
      });

      return;
    }

    if (status == "failed") {
      closeActiveDialog();
      return;
    }
  });
}
