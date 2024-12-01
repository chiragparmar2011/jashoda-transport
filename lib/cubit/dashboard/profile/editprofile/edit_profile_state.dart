part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoadingState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {
  final UserModel? userModel;

  EditProfileSuccessState(this.userModel);
}

final class EditProfileErrorState extends EditProfileState {
  final String error;

  EditProfileErrorState(this.error);
}
