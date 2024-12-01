part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class TruckDetailLoadingState extends HomeState {}

final class TruckDetailLoadedState extends HomeState {
  final List<TruckDetailModel>? truckDetailModel;

  TruckDetailLoadedState(this.truckDetailModel);
}

final class TruckDetailErrorState extends HomeState {
  final String error;

  TruckDetailErrorState(this.error);
}
