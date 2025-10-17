
abstract class AddOffersState {}

class AddOffersInitial extends AddOffersState {}

class AddOffersLoading extends AddOffersState {}

class AddOffersSuccess extends AddOffersState {
  // final SubmitOffersModel offersModel;
  // AddOffersSuccess({required this.offersModel});
}

class AddOffersFailure extends AddOffersState {
  final String error;
  AddOffersFailure({required this.error});
}


class AddOffersInvalidResult extends AddOffersState{}