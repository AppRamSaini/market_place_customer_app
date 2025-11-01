
import 'package:market_place_customer/data/models/purchased_offers_history_model.dart';

abstract class PurchasedOffersHistoryState {}

class PurchasedOffersHistoryInitial extends PurchasedOffersHistoryState {}

class PurchasedOffersHistoryLoading extends PurchasedOffersHistoryState {}

class PurchasedOffersHistorySuccess extends PurchasedOffersHistoryState {
  final PurchasedOffersHistoryModel model;
  PurchasedOffersHistorySuccess({required this.model});
}
class PurchasedOffersHistoryFailure extends PurchasedOffersHistoryState {
  final String error;
  PurchasedOffersHistoryFailure({required this.error});
}


class PurchasedOffersHistoryInvalidResult extends PurchasedOffersHistoryState {}

