import 'package:market_place_customer/data/models/update_bill_amount_model.dart';

abstract class UpdateBillAmountState {}

class UpdateBillAmountInitial extends UpdateBillAmountState {}

class UpdateBillAmountLoading extends UpdateBillAmountState {}

class UpdateBillAmountSuccess extends UpdateBillAmountState {
  final UpdateBillAmountModel billAmountModel;

  UpdateBillAmountSuccess({required this.billAmountModel});
}

class UpdateBillAmountFailure extends UpdateBillAmountState {
  final String error;

  UpdateBillAmountFailure({required this.error});
}

class UpdateBillAmountInvalidResult extends UpdateBillAmountState {}
