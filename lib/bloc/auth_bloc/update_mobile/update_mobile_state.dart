import 'package:market_place_customer/data/models/update_mobile_model.dart';

abstract class UpdateMobileState {}

class UpdateMobileInitial extends UpdateMobileState {}

class UpdateMobileLoading extends UpdateMobileState {}

class UpdateMobileSuccess extends UpdateMobileState {
  final UpdateMobileNumberModel updateMobileNumberModel;

  UpdateMobileSuccess({required this.updateMobileNumberModel});
}

class UpdateMobileFailure extends UpdateMobileState {
  final String error;

  UpdateMobileFailure({required this.error});
}
