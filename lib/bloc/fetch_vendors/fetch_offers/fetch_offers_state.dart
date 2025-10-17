import 'package:market_place_customer/data/models/fetchoffers_model.dart';
import 'package:market_place_customer/data/models/user_profile_model.dart';

abstract class FetchOffersState {}

class FetchOffersInitial extends FetchOffersState {}

class FetchOffersLoading extends FetchOffersState {}

class FetchOffersSuccess extends FetchOffersState {
  final FetchOffersListModel fetchOffersListModel;
  FetchOffersSuccess({required this.fetchOffersListModel});
}
class FetchOffersFailure extends FetchOffersState {
  final String error;
  FetchOffersFailure({required this.error});
}


class FetchOffersInvalidResult extends FetchOffersState {}

