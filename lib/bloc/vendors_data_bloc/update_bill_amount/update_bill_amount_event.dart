import 'package:flutter/cupertino.dart';

abstract class UpdateBillAmountEvent {}

class SubmitBillAmountEvent extends UpdateBillAmountEvent {
  final String offerId;
  final double amount;
  final BuildContext context;
  final PageSource pageSource;

  SubmitBillAmountEvent(
      {required this.context,
      required this.offerId,
      required this.amount,
      required this.pageSource});
}

enum PageSource {
  fromDetailsPage,
  fromQrPage,
}
