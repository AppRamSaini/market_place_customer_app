import 'package:market_place_customer/data/models/vendor_details_model.dart';

abstract class VendorDetailsState {}

class VendorDetailsInitial extends VendorDetailsState {}
class VendorDetailsLoading extends VendorDetailsState {}
class VendorDetailsSuccess extends VendorDetailsState {
  final VendorsDetailsModel vendorsDetailsModel;
  VendorDetailsSuccess({required this.vendorsDetailsModel});
}
class VendorDetailsFailure extends VendorDetailsState {
  final String error;
  VendorDetailsFailure({required this.error});
}
class VendorDetailsInvalidResult extends VendorDetailsState {}

