import 'package:market_place_customer/utils/exports.dart';

import 'fetch_profile_event.dart';

class FetchProfileDetailsBloc
    extends Bloc<FetchProfileDetailsEvent, FetchProfileDetailsState> {
  final repo = AuthRepository();

  FetchProfileDetailsBloc() : super(FetchProfileDetailsInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(FetchProfileDetailsLoading());
      try {
        final businessProfile = await repo.fetchProfile(event.context);
        if (businessProfile is String) {
          snackBar(event.context, businessProfile.toString());
        } else {
          emit(FetchProfileDetailsSuccess(profileModel: businessProfile));
        }
      } catch (e) {
        emit(FetchProfileDetailsFailure(error: e.toString()));
      }
    });
  }
}
