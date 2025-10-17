import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_customer/data/repository/offers_repository.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/custom.dart';

import 'fetch_offers_event.dart';
import 'fetch_offers_state.dart';

class FetchOffersBloc extends Bloc<FetchOffersEvent, FetchOffersState> {
  final repo = OffersRepository();

  FetchOffersBloc() : super(FetchOffersInitial()) {
    on<GetOffersEvent>((event, emit) async {
      emit(FetchOffersLoading());

      try {
      //   final offers = await repo.fetchVendorsApi(event.context,event);
      //   if (offers is String) {
      //     snackBar(event.context, offers.toString(),AppColors.redColor);
      //   } else {
      //     emit(FetchOffersSuccess(fetchOffersListModel: offers));
      //   }
      } catch (e) {
        emit(FetchOffersFailure(error: e.toString()));
      }
    });
  }
}
