import 'package:market_place_customer/bloc/fetch_vendors/update_offers/update_offers_event.dart';
import 'package:market_place_customer/bloc/fetch_vendors/update_offers/update_offers_state.dart';
import 'package:market_place_customer/utils/exports.dart';

class UpdateOffersBloc extends Bloc<UpdateOffersEvent, UpdateOffersState> {
  OffersRepository offersRepository = OffersRepository();

  UpdateOffersBloc() : super(UpdateOffersInitial()) {
    on<SubmitUpdateOffersEvent>(_updateOffersApi);
  }

  Future _updateOffersApi(
      SubmitUpdateOffersEvent event, Emitter<UpdateOffersState> emit) async {
    emit(UpdateOffersLoading());
    try {
      final updateOffers = await offersRepository.updateOffersApi(event);
      if (updateOffers != null) {
        if (updateOffers is String) {
          snackBar(event.context, updateOffers.toString());
        } else {
          emit(UpdateOffersSuccess(offersData: updateOffers));
        }
      } else {
        emit(UpdateOffersInvalidResult());
      }
    } catch (e) {
      emit(UpdateOffersFailure(error: e.toString()));
    }
  }
}
