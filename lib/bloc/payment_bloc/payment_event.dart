import 'package:flutter/cupertino.dart';

abstract class PaymentEvent {}

class SubmitPaymentEvent extends PaymentEvent {
  final String customerName;
  final String offerId;
  final String vendorId;
  final String userId;
  final double amount;
  final BuildContext context;
  SubmitPaymentEvent(this.customerName, this.context,this.amount, this.vendorId, this.offerId, this.userId);
}

