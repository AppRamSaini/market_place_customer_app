import 'package:market_place_customer/data/models/saved_bill_model.dart';

abstract class SaveBillState {}

class SaveBillInitial extends SaveBillState {}

class SaveBillLoading extends SaveBillState {}

class SaveBillSuccess extends SaveBillState {
  final SavedBillModel saveBillModel;

  SaveBillSuccess({required this.saveBillModel});
}


class SaveBillFailure extends SaveBillState {
  final String error;

  SaveBillFailure({required this.error});
}

class SaveBillInvalidResult extends SaveBillState {}
