import 'package:market_place_customer/utils/exports.dart';

class UpdateMobileBloc
    extends Bloc<VerifyUpdateMobileEvent, UpdateMobileState> {
  UpdateMobileBloc() : super(UpdateMobileInitial()) {
    on<SubmitUpdateMobileEvent>(_onUpdateMobile);
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> _onUpdateMobile(
      SubmitUpdateMobileEvent event, Emitter<UpdateMobileState> emit) async {
    emit(UpdateMobileLoading());

    try {
      final user = await authRepository.updateMobile(
          mobile: event.mobileNumber, otp: event.otp, context: event.context);
      if (user != null) {
        emit(UpdateMobileSuccess(updateMobileNumberModel: user));
      } else {
        emit(UpdateMobileFailure(error: user.toString()));
      }
    } catch (e) {
      emit(UpdateMobileFailure(error: e.toString()));
    }
  }
}
