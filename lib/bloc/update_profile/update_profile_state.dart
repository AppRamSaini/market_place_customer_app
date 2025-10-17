abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {}

class UpdateProfileFailure extends UpdateProfileState {
  final String error;
  UpdateProfileFailure({required this.error});
}

class UpdateProfileInvalidResult extends UpdateProfileState {}
