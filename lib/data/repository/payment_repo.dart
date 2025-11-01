import 'package:market_place_customer/bloc/payment_bloc/payment_bloc.dart';
import 'package:market_place_customer/data/models/payment_model.dart';
import 'package:market_place_customer/screens/payment_section/payment_services.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentRepository {
  Future submitPaymentStatus(
      {required BuildContext context,
      required double amount,
      String? offerId,
      vendorId}) async {
    final api = ApiManager();

    var data = {
      "amount": amount,
      "currency": "INR",
      "receipt": "receipt_1",
      "offer_id": offerId ?? '',
      "vendor_id": vendorId ?? ''
    };
    final result = await api.post(url: ApiEndPoints.makePayment, data: data);

    print('==>>>>$result');
    if (result is String) {
      return result;
    } else {
      return PaymentModel.fromJson(result);
    }
  }

  Future<PaymentState> handlePaymentSuccessResponse(
      PaymentSuccessResponse response, BuyOfferPaymentModel dataModel) async {
    debugPrint("✅ Payment Success: ${response.paymentId}");

    final bloc = dataModel.context.read<PaymentBloc>();

    final completer = Completer<PaymentState>();

    // पहले declare करो, फिर assign करो
    late StreamSubscription subscription;

    subscription = bloc.stream.listen((state) {
      if (state is PaymentSuccess || state is PaymentFailure) {
        if (!completer.isCompleted) {
          completer.complete(state);
        }
        subscription.cancel();
      }
    });

    // Event dispatch
    bloc.add(
      SubmitPaymentEvent(
        dataModel.customerName.toString(),
        dataModel.context,
        dataModel.amount ?? 0,
        dataModel.vendorId.toString(),
        dataModel.offersId.toString(),
        dataModel.userId.toString(),
      ),
    );

    // Bloc से response का wait
    final result = await completer.future;
    return result;
  }
}
