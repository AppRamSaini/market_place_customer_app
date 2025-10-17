import 'package:market_place_customer/utils/exports.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<ResendOtpRequested>(_onResendOtpRequested);
  }

  Future<void> _onSendOtpRequested(
      SendOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.loginUser(
          mobileNumber: event.mobile.toString(),
          context: event.context);

      if (user != null) {
        emit(AuthSuccess(user: user!, type: AuthFlowType.login));
      }else{
        emit(AuthInvalidResult());
      }
    } catch (e) {
      print('------->>');
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onResendOtpRequested(
      ResendOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.loginUser(
          mobileNumber: event.mobile,
          context: event.context);
      if (user != null) {
        emit(AuthSuccess(user: user!, type: AuthFlowType.resendOtp));
      }else{
        emit(AuthInvalidResult());
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
