import 'package:market_place_customer/data/models/fetch_vendors_model.dart';
import 'package:market_place_customer/utils/exports.dart';

class FetchVendorsBloc extends Bloc<FetchVendorsEvent, FetchVendorsState> {
  final repo = OffersRepository();

  FetchVendorsBloc() : super(FetchVendorsInitial()) {
    on<GetVendorsEvent>((event, emit) async {
      try {
        final currentState = state;

        if (!event.isLoadMore) {
          emit(FetchVendorsLoading());
          final data = await repo.fetchVendorsApi(event.context, event);

          if (data is String) {
            snackBar(event.context, data.toString(), AppColors.redColor);
          } else {
            emit(FetchVendorsSuccess(model: data));
          }
        } else if (currentState is FetchVendorsSuccess) {
          emit(currentState.copyWith(isPaginating: true));

          final newData = await repo.fetchVendorsApi(event.context, event);
          if (newData is String) {
            snackBar(event.context, newData.toString(), AppColors.redColor);
            emit(currentState.copyWith(isPaginating: false));
            return;
          }

          final oldList = currentState.model.data!.data ?? [];
          final newList = newData.data!.data ?? [];

          final List<VendorDataList> combinedList = [...oldList, ...newList];

          bool reachedMax = newList.isEmpty;

          newData.data!.data = combinedList;

          emit(currentState.copyWith(
            vendorsModel: newData,
            hasReachedMax: reachedMax,
            isPaginating: false,
          ));
        }
      } catch (e) {
        emit(FetchVendorsFailure(error: e.toString()));
      }
    });
  }
}
