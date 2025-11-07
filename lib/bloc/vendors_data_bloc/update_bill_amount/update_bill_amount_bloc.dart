import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_event.dart';
import 'package:market_place_customer/bloc/vendors_data_bloc/update_bill_amount/update_bill_amount_state.dart';
import 'package:market_place_customer/utils/exports.dart';

class UpdateBillAmountBloc
    extends Bloc<UpdateBillAmountEvent, UpdateBillAmountState> {
  PaymentRepository repository = PaymentRepository();

  UpdateBillAmountBloc() : super(UpdateBillAmountInitial()) {
    on<SubmitBillAmountEvent>(updateBillAmountApi);
  }

  Future<void> updateBillAmountApi(
      SubmitBillAmountEvent event, Emitter<UpdateBillAmountState> emit) async {
    emit(UpdateBillAmountLoading());
    try {
      final updatedBill = await repository.updateBillAmount(
          amount: event.amount, context: event.context, offerId: event.offerId);

      if (updatedBill != null) {
        if (updatedBill is String) {
          snackBar(event.context, updatedBill.toString(), AppColors.redColor);
        } else {
          emit(UpdateBillAmountSuccess(billAmountModel: updatedBill));
        }
      } else {
        emit(UpdateBillAmountInvalidResult());
      }
    } catch (e) {
      emit(UpdateBillAmountFailure(error: e.toString()));
    }
  }
}
