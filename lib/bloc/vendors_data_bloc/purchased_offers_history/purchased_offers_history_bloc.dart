import 'package:market_place_customer/data/models/purchased_offers_history_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class PurchasedOffersHistoryBloc
    extends Bloc<GetPurchasedOffersHistoryEvent, PurchasedOffersHistoryState> {
  final repo = OffersRepository();

  PurchasedOffersHistoryBloc() : super(PurchasedOffersHistoryInitial()) {
    on<GetPurchasedOffersHistoryEvent>((event, emit) async {
      try {
        final currentState = state;

        if (!event.isLoadMore) {
          emit(PurchasedOffersHistoryLoading());

          final data = await repo.fetchPurchasedOffersApi(event);

          if (data is String) {
            snackBar(event.context, data.toString(), AppColors.redColor);
          } else {
            emit(PurchasedOffersHistorySuccess(model: data));
          }
        } else if (currentState is PurchasedOffersHistorySuccess) {
          emit(currentState.copyWith(isPaginating: true));

          final newData = await repo.fetchPurchasedOffersApi(event);
          if (newData is String) {
            snackBar(event.context, newData.toString(), AppColors.redColor);
            emit(currentState.copyWith(isPaginating: false));
            return;
          }

          final oldList = currentState.model.data!.purchasedCustomers ?? [];
          final newList = newData.data!.data.purchasedCustomers ?? [];

          final List<PurchasedCustomer> combinedList = [...oldList, ...newList];

          bool reachedMax = newList.isEmpty;

          newData.data!.data = combinedList;

          emit(currentState.copyWith(
            vendorsModel: newData,
            hasReachedMax: reachedMax,
            isPaginating: false,
          ));
        }
      } catch (e) {
        emit(PurchasedOffersHistoryFailure(error: e.toString()));
      }
    });
  }
}
