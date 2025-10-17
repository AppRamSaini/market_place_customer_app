import 'package:market_place_customer/bloc/auth_bloc/send_otp_bloc/auth_event.dart';
import 'package:market_place_customer/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  final AuthFlowType type;
  AuthSuccess({required this.user, required this.type});
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}


class AuthInvalidResult extends AuthState{}