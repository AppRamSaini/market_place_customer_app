import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_event.dart';
import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_state.dart';
import 'package:market_place_customer/data/repository/order_history_repo.dart';
import 'package:market_place_customer/utils/exports.dart';

class SaveBillBloc extends Bloc<SaveBillEvent, SaveBillState> {
  OrderHistoryRepo repo = OrderHistoryRepo();

  SaveBillBloc() : super(SaveBillInitial()) {
    on<AddBillEvent>(_saveBill);
  }

  Future _saveBill(AddBillEvent event, Emitter<SaveBillState> emit) async {
    final data = {
      if (event.billImage.path != 'null') 'bill': event.billImage,
    };
    emit(SaveBillLoading());
    try {
      final addGallery =
          await repo.saveBill(event.context, event.offerId, data);

      if (addGallery is String) {
        emit(SaveBillFailure(error: addGallery.toString()));
      } else {
        emit(SaveBillSuccess(saveBillModel: addGallery));
      }
    } catch (e) {
      emit(SaveBillFailure(error: e.toString()));
    }
  }
}
