import 'package:market_place_customer/data/models/support_model.dart';

abstract class SupportState {}

class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class SupportSuccess extends SupportState {
  final HelpSupportModel helpSupportModel;
  SupportSuccess({required this.helpSupportModel});
}

class SupportFailure extends SupportState {
  final String error;
  SupportFailure({required this.error});
}
class SupportInvalidResult extends SupportState {}
