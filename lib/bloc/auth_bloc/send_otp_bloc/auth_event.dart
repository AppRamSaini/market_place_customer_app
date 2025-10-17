import 'package:flutter/cupertino.dart';

abstract class AuthEvent {}

class SendOtpRequested extends AuthEvent {
  final String mobile;
  final BuildContext context;
  SendOtpRequested(this.mobile, this.context);
}

class ResendOtpRequested extends AuthEvent {
  final String mobile;
  final BuildContext context;
  ResendOtpRequested(this.mobile, this.context);
}

enum AuthFlowType { login, resendOtp }
