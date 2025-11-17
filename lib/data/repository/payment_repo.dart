import 'package:market_place_customer/data/models/payment_model.dart';
import 'package:market_place_customer/data/models/update_bill_amount_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class PaymentRepository {
  Future submitPaymentStatus({
    required BuildContext context,
    required double amount,
    String? offerId,
    vendorId,
  }) async {
    final api = ApiManager();

    var data = {
      "amount": amount,
      "currency": "INR",
      "receipt": "receipt_1",
      "offer_id": offerId ?? '',
      "vendor_id": vendorId ?? ''
    };
    final result = await api.post(url: ApiEndPoints.makePayment, data: data);

    print('PAYMENT==>>>>$result');
    if (result is String) {
      return result;
    } else {
      return PaymentModel.fromJson(result);
    }
  }

  /// update bill amount
  Future<UpdateBillAmountModel> updateBillAmount(
      {required BuildContext context,
      required double amount,
      String? offerId}) async {
    final api = ApiManager();
    var data = {"total_amount": amount.toString()};
    final result = await api.post(
        url: "${ApiEndPoints.updateBillAmount}/$offerId", data: data);
    print('PAYMENT==>>>>$result');
    if (result is String) {
      return throw Exception(result.toString());
    } else {
      return UpdateBillAmountModel.fromJson(result);
    }
  }

// Future<PaymentState> handlePaymentSuccessResponse(
//     PaymentSuccessResponse response, BuyOfferPaymentModel dataModel) async {
//   debugPrint("✅ Payment Success: ${response.paymentId}");
//
//   final bloc = dataModel.context.read<PaymentBloc>();
//
//   final completer = Completer<PaymentState>();
//
//   // पहले declare करो, फिर assign करो
//   late StreamSubscription subscription;
//
//   subscription = bloc.stream.listen((state) {
//     if (state is PaymentSuccess || state is PaymentFailure) {
//       if (!completer.isCompleted) {
//         completer.complete(state);
//       }
//       subscription.cancel();
//     }
//   });
//
//   // Event dispatch
//   bloc.add(
//     SubmitPaymentEvent(
//       dataModel.customerName.toString(),
//       dataModel.context,
//       dataModel.amount ?? 0,
//       dataModel.vendorId.toString(),
//       dataModel.offersId.toString(),
//       dataModel.userId.toString(),
//     ),
//   );
//
//   // Bloc से response का wait
//   final result = await completer.future;
//   return result;
// }
}
