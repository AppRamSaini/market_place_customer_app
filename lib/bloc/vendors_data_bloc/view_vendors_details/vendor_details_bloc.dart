import 'package:market_place_customer/bloc/vendors_data_bloc/view_vendors_details/vendor_details_state.dart';
import 'package:market_place_customer/utils/exports.dart';

class VendorDetailsBloc extends Bloc<VendorDetailsEvent, VendorDetailsState> {
  final repo = OffersRepository();

  VendorDetailsBloc() : super(VendorDetailsInitial()) {
    on<ViewVendorDetailsEvent>((event, emit) async {
      emit(VendorDetailsLoading());
      try {
        final offers = await repo.fetchVendorDetailsApi(event);
        if (offers is String) {
        } else {
          emit(VendorDetailsSuccess(vendorsDetailsModel: offers));
        }
      } catch (e) {
        emit(VendorDetailsFailure(error: e.toString()));
      }
    });
  }
}
