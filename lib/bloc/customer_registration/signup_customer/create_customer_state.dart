import 'package:market_place_customer/data/models/customer_signup_model.dart';

abstract class CustomerSignupState {}

class CustomerSignupInitial extends CustomerSignupState {}

class CustomerSignupLoading extends CustomerSignupState {}

class CustomerSignupSuccess extends CustomerSignupState {
  final CustomerSignupModel customerSignupModel;
  CustomerSignupSuccess({required this.customerSignupModel});
}

class CustomerSignupFailure extends CustomerSignupState {
  final String error;
  CustomerSignupFailure({required this.error});
}


class CustomerSignupInvalidResult extends CustomerSignupState{}