import 'package:market_place_customer/data/models/used_offers_details.dart';

abstract class UsedOffersState {}

class UsedOffersInitial extends UsedOffersState {}

class UsedOffersLoading extends UsedOffersState {}

class UsedOffersSuccess extends UsedOffersState {
  final UsedOffersDetailsModel offersDetailModel;

  UsedOffersSuccess({required this.offersDetailModel});
}

class UsedOffersFailure extends UsedOffersState {
  final String error;

  UsedOffersFailure({required this.error});
}

class NoInternetConnection extends UsedOffersState {}

class FetchOffersLoginRequired extends UsedOffersState {}
