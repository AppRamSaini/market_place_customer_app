import 'package:market_place_customer/data/models/profile_model.dart';

abstract class FetchProfileDetailsState {}

class FetchProfileDetailsInitial extends FetchProfileDetailsState {}

class FetchProfileDetailsLoading extends FetchProfileDetailsState {}

class FetchProfileDetailsSuccess extends FetchProfileDetailsState {
  final ProfileModel profileModel;
  FetchProfileDetailsSuccess({required this.profileModel});
}
class FetchProfileDetailsFailure extends FetchProfileDetailsState {
  final String error;
  FetchProfileDetailsFailure({required this.error});
}


class FetchProfileDetailsInvalidResult extends FetchProfileDetailsState {}

