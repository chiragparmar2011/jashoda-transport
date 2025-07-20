part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class TruckDetailLoadingState extends HomeState {}

final class TruckDetailLoadedState extends HomeState {
  final List<TruckListModel>? truckDetailModel;

  TruckDetailLoadedState(this.truckDetailModel);
}

final class TruckDetailErrorState extends HomeState {
  final String error;

  TruckDetailErrorState(this.error);
}

final class SingleTruckLoadingState extends HomeState {}

final class SingleTruckSuccess extends HomeState {
  final TruckDetailModel? truckDetailModel;

  SingleTruckSuccess(this.truckDetailModel);
}

final class FetchSingleTruckError extends HomeState {
  final String error;

  FetchSingleTruckError(this.error);
}
