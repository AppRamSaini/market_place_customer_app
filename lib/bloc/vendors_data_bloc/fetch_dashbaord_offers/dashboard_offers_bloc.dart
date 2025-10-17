import 'package:market_place_customer/bloc/vendors_data_bloc/fetch_dashbaord_offers/dashboard_offers_state.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'dashboard_offers_event.dart';

class FetchDashboardOffersBloc
    extends Bloc<FetchDashboardOffersEvent, FetchDashboardOffersState> {
  final repo = OffersRepository();

  FetchDashboardOffersBloc() : super(FetchDashboardOffersInitial()) {
    on<DashboardOffersEvent>((event, emit) async {
      emit(FetchDashboardOffersLoading());

      try {
        final offers = await repo.fetchVendorsOffers(event.context);
        if (offers is String) {
          snackBar(event.context, offers.toString(), AppColors.redColor);
        } else {
          emit(FetchDashboardOffersSuccess(dashboardOffersModel: offers));
        }
      } catch (e) {
        emit(FetchDashboardOffersFailure(error: e.toString()));
      }
    });
  }
}
