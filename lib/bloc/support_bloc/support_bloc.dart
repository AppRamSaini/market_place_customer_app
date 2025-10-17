import 'package:market_place_customer/bloc/support_bloc/support_event.dart';
import 'package:market_place_customer/bloc/support_bloc/support_state.dart';
import 'package:market_place_customer/data/repository/notification_repo.dart';
import 'package:market_place_customer/utils/exports.dart';

class SupportBloc extends Bloc<FetchSupportEvent, SupportState> {
  final notificationRepo = NotificationsRepository();

  SupportBloc() : super(SupportInitial()) {
    on<FetchSupportEvent>(_onFetchHelpSupportData);
  }

  Future _onFetchHelpSupportData(
      FetchSupportEvent event, Emitter<SupportState> emit) async {
    emit(SupportLoading());
    try {
      final helpData =
          await notificationRepo.fetchSupportDetails(event.context);
      if (helpData != null) {
        emit(SupportSuccess(helpSupportModel: helpData));
      } else {
        emit(SupportInvalidResult());
      }
    } catch (e) {
      emit(SupportFailure(error: e.toString()));
    }
  }
}
