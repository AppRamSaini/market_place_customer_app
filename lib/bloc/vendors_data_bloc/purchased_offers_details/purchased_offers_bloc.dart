import 'package:market_place_customer/utils/exports.dart';

import 'purchased_offers_event.dart';

class PurchasedOffersBloc
    extends Bloc<PurchasedOffersEvent, PurchasedOffersState> {
  final repo = OffersRepository();

  PurchasedOffersBloc() : super(PurchasedOffersInitial()) {
    on<PurchasedOffersDetailsEvent>((event, emit) async {
      emit(PurchasedOffersLoading());
      try {
        final offers = await repo.fetchPurchasedOffersDetailsApi(event);
        if (offers is String) {
          snackBar(event.context, offers.toString());
        } else {
          emit(PurchasedOffersSuccess(offersDetailModel: offers));
        }
      } catch (e) {
        emit(PurchasedOffersFailure(error: e.toString()));
      }
    });
  }
}
