import 'package:market_place_customer/utils/exports.dart';

class PurchasedOffersHistoryBloc
    extends Bloc<GetPurchasedOffersHistoryEvent, PurchasedOffersHistoryState> {
  final repo = OffersRepository();

  PurchasedOffersHistoryBloc() : super(PurchasedOffersHistoryInitial()) {
    on<GetPurchasedOffersHistoryEvent>((event, emit) async {
      emit(PurchasedOffersHistoryLoading());
      try {
        final offersHistory = await repo.fetchPurchasedOffersApi();

        if (offersHistory is String) {
          print("RES===>$offersHistory");
          snackBar(event.context, offersHistory.toString(), AppColors.redColor);
        } else {
          emit(PurchasedOffersHistorySuccess(model: offersHistory));
        }
      } catch (e) {
        emit(PurchasedOffersHistoryFailure(error: e.toString()));
      }
    });
  }
}
