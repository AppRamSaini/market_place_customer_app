import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_customer/data/repository/offers_repository.dart';

import 'fetch_all_vendors_event.dart';
import 'fetch_all_vendors_state.dart';

class FetchVendorsBloc extends Bloc<GetVendorsEvent, FetchVendorsState> {
  final repo = OffersRepository();

  FetchVendorsBloc() : super(FetchVendorsInitial()) {
    on<GetVendorsEvent>((event, emit) async {
      emit(FetchVendorsLoading());

      try {
        final offers = await repo.fetchVendorsApi(event.context, event);

        if (offers is String) {
          print("RES===>$offers");

          // snackBar(event.context, offers.toString(), AppColors.redColor);
        } else {
          emit(FetchVendorsSuccess(model: offers));
        }
      } catch (e) {
        emit(FetchVendorsFailure(error: e.toString()));
      }
    });
  }
}
