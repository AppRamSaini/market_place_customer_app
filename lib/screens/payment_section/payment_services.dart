import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_place_customer/screens/payment_section/payment_success.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuyOfferPaymentModel {
  final double amount;
  final BuildContext context;
  final String? customerName;
  final String? offersId;
  final String? vendorId;
  final String? userId;
  final String? orderId;

  BuyOfferPaymentModel(
      {this.customerName,
      required this.context,
      this.vendorId,
      required this.amount,
      this.offersId,
      this.userId,
      this.orderId});
}

class RazorpayPaymentServices {
  var razorpaykey = dotenv.env['RAZORPAY_API_KEY_TEST'];
  Razorpay razorpay = Razorpay();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  submitBuyOffers({final BuyOfferPaymentModel? dataModel}) async {
    try {
      var options = {
        'key': razorpaykey,
        'amount': (dataModel!.amount).toInt(),
        'name': dataModel.customerName ?? '',
        "order_id": dataModel.orderId,
        'description': 'Buying an offer',
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'notes': {
          'offers_id': dataModel.offersId ?? '',
          'vendor_id': dataModel.vendorId ?? '',
        },
        'theme': {'color': '#3399cc'},
        'external': {
          'wallets': ['paytm']
        },
      };

      /// Attach listeners
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (res) => handlePaymentErrorResponse(res, dataModel));
      razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (res) => handlePaymentSuccessResponse(res, dataModel),
      );
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
          (res) => handleExternalWalletSelected(res, dataModel.context));

      /// Open Razorpay payment window (close loading before this)
      razorpay.open(options);
    } catch (e) {
      debugPrint("⚠️ Razorpay Error: $e");
      snackBar(dataModel!.context, "Payment initialization failed!");
    }
  }

  /// 🔴 Payment Failed
  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuyOfferPaymentModel dataModel) async {
    snackBar(dataModel.context, "Payment Failed: ${response.message}",
        AppColors.redColor);

    updatePaymentDataOnFirebase(dataModel.offersId.toString(),
        dataModel.vendorId.toString(), dataModel.userId.toString(), 'failed');
  }

  /// ✅ Payment Success
  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response, BuyOfferPaymentModel dataModel) async {
    updatePaymentDataOnFirebase(dataModel.offersId.toString(),
        dataModel.vendorId.toString(), dataModel.userId.toString(), 'success');

    dataModel.context
        .read<PurchasedOffersHistoryBloc>()
        .add(GetPurchasedOffersHistoryEvent(context: dataModel.context));

    AppRouter().navigateTo(dataModel.context, const PaymentSuccessPage());

    // Bloc event trigger
    // dataModel.context.read<PaymentBloc>().add(
    //       SubmitPaymentEvent(
    //         dataModel.customerName.toString(),
    //         dataModel.context,
    //         dataModel.amount ?? 0,
    //         dataModel.vendorId.toString(),
    //         dataModel.offersId.toString(),
    //         dataModel.userId.toString(),
    //       ),
    //     );

    // // Repository call (await result)
    // PaymentRepository paymentRepository = PaymentRepository();
    // final result = await paymentRepository.handlePaymentSuccessResponse(
    //     response, dataModel);
    //
    // EasyLoading.dismiss();
    // if (result is PaymentSuccess) {
    //   debugPrint("✅ Verified: ${result.paymentModel.status}");
    //
    //   // अगर backend से payment verified आ गया
    //   if (result.paymentModel.status == true) {
    //     AppRouter().navigateTo(dataModel.context, const PaymentSuccessPage());
    //   }
    // }
  }

  /// 💳 External Wallet Selected
  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    snackBar(context, "External Wallet Selected: ${response.walletName}");
  }

  Future<void> verifyPaymentAndBuyOffers({
    required BuyOfferPaymentModel dataModel,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final pendingQuery = await firestore
        .collection('offers')
        .where('userId', isEqualTo: dataModel.userId)
        .where('offerId', isEqualTo: dataModel.offersId)
        .where('vendorId', isEqualTo: dataModel.vendorId)
        .where('status', isEqualTo: 'pending')
        .get();

    if (pendingQuery.docs.isNotEmpty) {
      /// pending payment verifications
      snackBar(
          dataModel.context,
          "You already have a pending transaction for this offer.",
          AppColors.redColor);
      return;
    }

    // ✅ unique document id create (userId + offerId + vendorId)
    final docId =
        '${dataModel.userId}_${dataModel.offersId}_${dataModel.vendorId}';

    // ✅ Save new pending offer with merge (so it updates if already exists)
    await firestore.collection('offers').doc(docId).set({
      'userId': dataModel.userId,
      'offerId': dataModel.offersId,
      'vendorId': dataModel.vendorId,
      'amount': dataModel.amount,
      'status': 'creating',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));

    // ✅ Payment API call or Razorpay process
    submitBuyOffers(dataModel: dataModel);
  }

  /// update payment status on firebase
  updatePaymentDataOnFirebase(
    String offersId,
    String vendorId,
    String userId,
    String status,
  ) async {
    final docId = '${userId}_${offersId}_$vendorId';

    final docRef = _firestore.collection('offers').doc(docId);
    await docRef.set({
      'userId': userId,
      'offerId': offersId,
      'vendorId': vendorId,
      'status': status,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }
}
