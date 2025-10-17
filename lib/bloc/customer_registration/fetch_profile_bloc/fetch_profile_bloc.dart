import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_customer/data/repository/auth_repository.dart';
import 'package:market_place_customer/utils/custom.dart';
import 'fetch_profile_event.dart';
import 'fetch_profile_state.dart';

class FetchProfileDetailsBloc extends Bloc<FetchProfileDetailsEvent, FetchProfileDetailsState> {
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
