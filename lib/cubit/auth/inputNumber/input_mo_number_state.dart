part of 'input_mo_number_cubit.dart';

@immutable
sealed class EnterMoNumberState {}

final class EnterMoNumberInitial extends EnterMoNumberState {}

final class OTPLoadingState extends EnterMoNumberState {}

final class OTPSuccessState extends EnterMoNumberState {
  final String message;

  OTPSuccessState(this.message);
}

final class OTPFailedState extends EnterMoNumberState {
  final String? error;

  OTPFailedState(this.error);
}
