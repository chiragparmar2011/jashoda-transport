part of 'onboard_cubit.dart';

@immutable
sealed class OnboardState {}

final class OnboardInitial extends OnboardState {}

final class HideOnboardingIndicator extends OnboardState {
  final int index;
  HideOnboardingIndicator(this.index);
}
