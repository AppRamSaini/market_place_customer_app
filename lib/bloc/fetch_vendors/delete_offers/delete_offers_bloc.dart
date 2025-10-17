

import 'package:market_place_customer/utils/exports.dart';
import 'delete_offers_event.dart';
import 'delete_offers_state.dart';
class DeleteOffersBloc extends Bloc<DeleteOffersEvent, DeleteOffersState> {
  final repo = OffersRepository();

  DeleteOffersBloc() : super(DeleteOffersInitial()) {
    on<DeleteOffersSubmit>((event, emit) async {
      emit(DeleteOffersLoading());
      try {
        final offers = await repo.deleteOffersApi(event);
        if (offers is String) {
          snackBar(event.context, offers.toString());
          emit(DeleteOffersInvalidResult());
         await EasyLoading.dismiss();
        } else {
          emit(DeleteOffersSuccess(offersData: offers));
        }
      } catch (e) {
        emit(DeleteOffersFailure(error: e.toString()));
      }
    });
  }
}
