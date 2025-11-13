import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_event.dart';
import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_state.dart';
import 'package:market_place_customer/data/models/order_history_%20model.dart';
import 'package:market_place_customer/data/repository/order_history_repo.dart';
import 'package:market_place_customer/utils/exports.dart';

class OrderHistoryBloc extends Bloc<GetOrderHistoryEvent, OrderHistoryState> {
  final repo = OrderHistoryRepo();

  OrderHistoryBloc() : super(OrderHistoryInitial()) {
    on<GetOrderHistoryEvent>((event, emit) async {
      try {
        final currentState = state;

        if (!event.isLoadMore) {
          emit(OrderHistoryLoading());
          final data = await repo.fetchOrdersApi(event.context, event.page);

          if (data is String) {
            snackBar(event.context, data.toString(), AppColors.redColor);
          } else {
            emit(OrderHistorySuccess(model: data));
          }
        } else if (currentState is OrderHistorySuccess) {
          emit(currentState.copyWith(isPaginating: true));

          final newData = await repo.fetchOrdersApi(event.context, event.page);
          if (newData is String) {
            snackBar(event.context, newData.toString(), AppColors.redColor);
            emit(currentState.copyWith(isPaginating: false));
            return;
          }

          final oldList = currentState.model.data!.redeemedOffers ?? [];
          final newList = newData.data!.redeemedOffers ?? [];

          final List<RedeemedOffer> combinedList = [...oldList, ...newList];

          bool reachedMax = newList.isEmpty;

          newData.data!.redeemedOffers = combinedList;

          emit(currentState.copyWith(
            customersModel: newData,
            hasReachedMax: reachedMax,
            isPaginating: false,
          ));
        }
      } catch (e) {
        emit(OrderHistoryFailure(error: e.toString()));
      }
    });
  }
}
