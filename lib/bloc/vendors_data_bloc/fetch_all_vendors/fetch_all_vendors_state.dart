
import 'package:market_place_customer/data/models/fetch_vendors_model.dart';

abstract class FetchVendorsState {}

class FetchVendorsInitial extends FetchVendorsState {}

class FetchVendorsLoading extends FetchVendorsState {}

class FetchVendorsSuccess extends FetchVendorsState {
  final FetchVendorsModel model;
  FetchVendorsSuccess({required this.model});
}
class FetchVendorsFailure extends FetchVendorsState {
  final String error;
  FetchVendorsFailure({required this.error});
}


class FetchVendorsInvalidResult extends FetchVendorsState {}

