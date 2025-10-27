import 'package:market_place_customer/data/models/offers_detail_model.dart';

abstract class ViewOffersState {}

class ViewOffersInitial extends ViewOffersState {}

class ViewOffersLoading extends ViewOffersState {}

class ViewOffersSuccess extends ViewOffersState {
  final OffersDetailModel offersDetailModel;
  ViewOffersSuccess({required this.offersDetailModel});
}
class ViewOffersFailure extends ViewOffersState {
  final String error;
  ViewOffersFailure({required this.error});
}


class ViewOffersInvalidResult extends ViewOffersState {}

