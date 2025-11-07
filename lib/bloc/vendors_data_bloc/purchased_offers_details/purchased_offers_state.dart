import 'package:market_place_customer/data/models/purchased_offers_details_model.dart';

abstract class PurchasedOffersState {}

class PurchasedOffersInitial extends PurchasedOffersState {}

class PurchasedOffersLoading extends PurchasedOffersState {}

class PurchasedOffersSuccess extends PurchasedOffersState {
  final PurchasedOffersDetailModel offersDetailModel;

  PurchasedOffersSuccess({required this.offersDetailModel});
}

class PurchasedOffersFailure extends PurchasedOffersState {
  final String error;

  PurchasedOffersFailure({required this.error});
}

class PurchasedOffersInvalidResult extends PurchasedOffersState {}
