part of 'registration_cubit.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegisterLoadingState extends RegistrationState {}

final class RegisterSuccessState extends RegistrationState {
  final UserModel? userModel;

  RegisterSuccessState(this.userModel);
}

final class RegisterFailedState extends RegistrationState {
  final String? error;

  RegisterFailedState(this.error);
}
