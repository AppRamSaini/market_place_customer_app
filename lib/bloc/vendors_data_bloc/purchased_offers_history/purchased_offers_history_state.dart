import 'package:market_place_customer/data/models/purchased_offers_history_model.dart';

abstract class PurchasedOffersHistoryState {}

class PurchasedOffersHistoryInitial extends PurchasedOffersHistoryState {}

class PurchasedOffersHistoryLoading extends PurchasedOffersHistoryState {}

class PurchasedOffersHistorySuccess extends PurchasedOffersHistoryState {
  final PurchasedOffersHistoryModel model;
  final bool hasReachedMax;
  final bool isPaginating;

  PurchasedOffersHistorySuccess(
      {required this.model,
      this.hasReachedMax = false,
      this.isPaginating = false});

  PurchasedOffersHistorySuccess copyWith(
      {PurchasedOffersHistoryModel? vendorsModel,
      bool? hasReachedMax,
      bool? isPaginating}) {
    return PurchasedOffersHistorySuccess(
        model: vendorsModel ?? model,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isPaginating: isPaginating ?? this.isPaginating);
  }
}

class PurchasedOffersHistoryFailure extends PurchasedOffersHistoryState {
  final String error;

  PurchasedOffersHistoryFailure({required this.error});
}

class PurchasedOffersHistoryInvalidResult extends PurchasedOffersHistoryState {}
