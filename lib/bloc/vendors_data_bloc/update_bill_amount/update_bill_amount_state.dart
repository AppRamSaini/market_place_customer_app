import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_event.dart';
import 'package:market_place_customer/data/models/update_bill_amount_model.dart';

abstract class UpdateBillAmountState {}

class UpdateBillAmountInitial extends UpdateBillAmountState {}

class UpdateBillAmountLoading extends UpdateBillAmountState {}

class UpdateBillAmountSuccess extends UpdateBillAmountState {
  final UpdateBillAmountModel billAmountModel;
  final PageSource pageSource;

  UpdateBillAmountSuccess(
      {required this.billAmountModel, required this.pageSource});
}

class UpdateBillAmountFailure extends UpdateBillAmountState {
  final String error;

  UpdateBillAmountFailure({required this.error});
}

class UpdateBillAmountInvalidResult extends UpdateBillAmountState {}
