part of 'otp_verification_cubit.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoadingState extends OtpVerificationState {}

class OtpVerificationSuccessState extends OtpVerificationState {
  final String message;
  final bool isRegistered;

  OtpVerificationSuccessState(this.message, this.isRegistered);
}

final class OtpVerificationErrorState extends OtpVerificationState {
  final String? error;

  OtpVerificationErrorState(this.error);
}