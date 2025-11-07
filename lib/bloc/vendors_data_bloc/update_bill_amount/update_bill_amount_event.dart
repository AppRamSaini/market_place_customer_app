import 'package:flutter/cupertino.dart';

abstract class UpdateBillAmountEvent {}

class SubmitBillAmountEvent extends UpdateBillAmountEvent {
  final String offerId;
  final String amount;
  final BuildContext context;

  SubmitBillAmountEvent(
      {required this.context, required this.offerId, required this.amount});
}
