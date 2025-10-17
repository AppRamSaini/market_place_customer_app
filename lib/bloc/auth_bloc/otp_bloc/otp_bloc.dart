
import 'package:market_place_customer/utils/exports.dart';

class VerifyOtpBloc extends Bloc<SubmitOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(OtpVerifyInitial()) {
    on<SubmitOtpEvent>(_onOtpVerify);
  }
  AuthRepository authRepository = AuthRepository();
  Future<void> _onOtpVerify(
      SubmitOtpEvent event, Emitter<VerifyOtpState> emit) async {
    emit(OtpVerifyLoading());

    try {
      final user = await authRepository.otpVerify(
          mobile: event.mobileNumber,
          otp: event.otp,
          roleType: event.role.toString(),
          context: event.context);
      if (user != null) {
        emit(OtpVerifySuccess(userOtpModel: user));
      } else {
        emit(InvalidOtpResult());
      }
    } catch (e) {
      emit(OtpVerifyFailure(error: e.toString()));
    }
  }
}
