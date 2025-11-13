import 'package:market_place_customer/bloc/update_profile/update_bloc_event.dart';
import 'package:market_place_customer/bloc/update_profile/update_profile_state.dart';
import 'package:market_place_customer/data/repository/profile_repository.dart';
import 'package:market_place_customer/utils/exports.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final profileRepo = ProfileRepository();

  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateProfileSubmitted>(_updateProfile);
  }

  Future _updateProfile(
      UpdateProfileSubmitted event, Emitter<UpdateProfileState> emit) async {
    final data = {
      'name': event.name,
      'email': event.email,
      if (event.imageFile.path != 'null') 'avatar': event.imageFile,
    };

    print(data);

    emit(UpdateProfileLoading());
    try {
      final userprofile = await profileRepo.updateProfile(event.context, data);
      if (userprofile != null) {
        emit(UpdateProfileSuccess());
      } else {
        emit(UpdateProfileInvalidResult());
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: e.toString()));
    }
  }
}
