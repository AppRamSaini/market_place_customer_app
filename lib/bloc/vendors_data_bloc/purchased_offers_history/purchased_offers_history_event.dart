import 'package:flutter/cupertino.dart';

abstract class PurchasedOffersHistoryEvent {}

class GetPurchasedOffersHistoryEvent extends PurchasedOffersHistoryEvent {
  final BuildContext context;
  final int page;
  final bool isLoadMore;

  GetPurchasedOffersHistoryEvent(
      {required this.context, required this.page, this.isLoadMore = false});
}
