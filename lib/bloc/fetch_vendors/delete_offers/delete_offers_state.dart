import 'package:market_place_customer/data/models/user_profile_model.dart';

abstract class DeleteOffersState {}

class DeleteOffersInitial extends DeleteOffersState {}

class DeleteOffersLoading extends DeleteOffersState {}

class DeleteOffersSuccess extends DeleteOffersState {
   var  offersData;
  DeleteOffersSuccess({required this.offersData});
}
class DeleteOffersFailure extends DeleteOffersState {
  final String error;
  DeleteOffersFailure({required this.error});
}


class DeleteOffersInvalidResult extends DeleteOffersState {}

