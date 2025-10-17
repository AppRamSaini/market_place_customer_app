import 'package:flutter/cupertino.dart';

abstract class VerifyOtpEvent {}

class SubmitOtpEvent extends VerifyOtpEvent {
  final String otp;
  final String role;
  final String mobileNumber;
  final BuildContext context;
  SubmitOtpEvent(
      {required this.mobileNumber,
      required this.otp,
      required this.role,
      required this.context});
}
