

import 'package:market_place_customer/utils/exports.dart';

class CustomerSignupBloc
    extends Bloc<CustomerSignupEvent, CustomerSignupState> {
  AuthRepository authRepository = AuthRepository();

  CustomerSignupBloc() : super(CustomerSignupInitial()) {
    on<CustomerSignupEvent>(_customerSignupRepo);
  }

  Future _customerSignupRepo(CustomerSignupEvent event,
      Emitter<CustomerSignupState> emit) async {
    emit(CustomerSignupLoading());
    try {
      final customerSignup = await authRepository.customerRegistration(
          context: event.context, customer: event);
      if (customerSignup != null && customerSignup.status==true) {
        emit(CustomerSignupSuccess(customerSignupModel: customerSignup));
      } else {
        emit(CustomerSignupInvalidResult());
      }
    } catch (e) {
      emit(CustomerSignupFailure(error: e.toString()));
    }
  }
}
