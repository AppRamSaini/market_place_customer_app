import 'package:market_place_customer/bloc/payment_bloc/payment_event.dart';
import 'package:market_place_customer/data/models/payment_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentModel paymentModel;
  final SubmitPaymentEvent paymentEvent;
  PaymentSuccess({required this.paymentModel, required this.paymentEvent});
}

class PaymentFailure extends PaymentState {
  final String error;
  final SubmitPaymentEvent paymentEvent;

  PaymentFailure({required this.error, required this.paymentEvent});
}

class PaymentInvalidResult extends PaymentState {}
