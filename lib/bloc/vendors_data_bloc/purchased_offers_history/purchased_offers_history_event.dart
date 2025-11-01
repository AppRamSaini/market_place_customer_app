import 'package:flutter/cupertino.dart';

abstract class PurchasedOffersHistoryEvent {}

class GetPurchasedOffersHistoryEvent extends PurchasedOffersHistoryEvent {
  final BuildContext context;
  GetPurchasedOffersHistoryEvent({required this.context});
}
