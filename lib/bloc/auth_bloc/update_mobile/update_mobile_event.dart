import 'package:flutter/cupertino.dart';

abstract class VerifyUpdateMobileEvent {}

class SubmitUpdateMobileEvent extends VerifyUpdateMobileEvent {
  final String otp;
  final String mobileNumber;
  final BuildContext context;

  SubmitUpdateMobileEvent(
      {required this.mobileNumber, required this.otp, required this.context});
}
