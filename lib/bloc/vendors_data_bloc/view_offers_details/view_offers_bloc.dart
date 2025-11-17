import 'package:market_place_customer/utils/exports.dart';

class ViewOffersBloc extends Bloc<ViewOffersEvent, ViewOffersState> {
  final repo = OffersRepository();

  ViewOffersBloc() : super(ViewOffersInitial()) {
    on<ViewOffersDetailsEvent>((event, emit) async {
      emit(ViewOffersLoading());
      try {
        final offers = await repo.fetchOffersDetailsApi(event);
        if (offers is String) {
          snackBar(event.context, offers.toString());
        } else {
          emit(ViewOffersSuccess(offersDetailModel: offers));
        }
      } catch (e) {
        emit(ViewOffersFailure(error: e.toString()));
      }
    });
  }
}
