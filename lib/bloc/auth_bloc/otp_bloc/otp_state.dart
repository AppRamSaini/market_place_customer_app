import 'package:market_place_customer/data/models/user_otp_modal.dart';

abstract class  VerifyOtpState {}

class OtpVerifyInitial extends VerifyOtpState{}
class OtpVerifyLoading extends VerifyOtpState{}


class OtpVerifySuccess extends VerifyOtpState{
  final UserOtpModal userOtpModel;
  OtpVerifySuccess({required this.userOtpModel});

}

class OtpVerifyFailure extends VerifyOtpState{
  final String error;
  OtpVerifyFailure({required this.error});
}
class InvalidOtpResult extends VerifyOtpState{
}
