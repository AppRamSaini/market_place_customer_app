


abstract class UpdateOffersState {}

class UpdateOffersInitial extends UpdateOffersState {}

class UpdateOffersLoading extends UpdateOffersState {}

class UpdateOffersSuccess extends UpdateOffersState {
  var offersData;
  UpdateOffersSuccess({required this.offersData});
}

class UpdateOffersFailure extends UpdateOffersState {
  final String error;
  UpdateOffersFailure({required this.error});
}


class UpdateOffersInvalidResult extends UpdateOffersState{}