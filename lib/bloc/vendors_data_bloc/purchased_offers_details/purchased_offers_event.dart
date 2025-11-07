import 'package:flutter/cupertino.dart';

abstract class PurchasedOffersEvent {}

class PurchasedOffersDetailsEvent extends PurchasedOffersEvent {
  final BuildContext context;
  final String? offersId;

  PurchasedOffersDetailsEvent({required this.context, this.offersId});
}

class ResetOffersEvent extends PurchasedOffersEvent {}
