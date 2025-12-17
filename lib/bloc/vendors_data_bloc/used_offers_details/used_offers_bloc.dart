import 'package:market_place_customer/bloc/vendors_data_bloc/used_offers_details/used_offers_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/used_offers_details/used_offers_state.dart';
import 'package:market_place_customer/utils/exports.dart';

class UsedOffersBloc extends Bloc<UsedOffersEvent, UsedOffersState> {
  final repo = OffersRepository();

  UsedOffersBloc() : super(UsedOffersInitial()) {
    on<UsedOffersDetailsEvent>((event, emit) async {
      emit(UsedOffersLoading());
      try {
        final offers = await repo.fetchUsedOffersDetailsApi(event);
        if (offers is String) {
          if (offers == 'no_internet') {
            emit(NoInternetConnection());
            return;
          }

          if (offers == 'unauthorized') {
            await LocalStorage.setBool(Pref.isLogged, false);
            emit(FetchOffersLoginRequired());
            return;
          }
          emit(UsedOffersFailure(error: offers.toString()));
          return;
        } else {
          emit(UsedOffersSuccess(offersDetailModel: offers));
        }
      } catch (e) {
        emit(UsedOffersFailure(error: e.toString()));
      }
    });
  }
}
