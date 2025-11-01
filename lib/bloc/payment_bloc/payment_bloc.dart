import 'package:market_place_customer/utils/exports.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentRepository paymentRepository = PaymentRepository();

  PaymentBloc() : super(PaymentInitial()) {
    on<SubmitPaymentEvent>(_onSubmitPayment);
  }

  Future _onSubmitPayment(
      SubmitPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final paymentRes = await paymentRepository.submitPaymentStatus(
          context: event.context,
          amount: event.amount,
          offerId: event.offerId,
          vendorId: event.vendorId);

      if (paymentRes != null) {
        if (paymentRes is String) {
          emit(PaymentFailure(
              error: paymentRes.toString(), paymentEvent: event));
        } else {
          emit(PaymentSuccess(paymentModel: paymentRes, paymentEvent: event));
        }
      }
    } catch (e) {
      emit(PaymentFailure(error: e.toString(), paymentEvent: event));
    }
  }
}
