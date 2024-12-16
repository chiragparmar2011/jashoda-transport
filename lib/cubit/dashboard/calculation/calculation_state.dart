part of 'calculation_cubit.dart';

@immutable
sealed class CalculationState {}

final class CalculationInitial extends CalculationState {}

final class DimensionDataChangeState extends CalculationState {
  final bool isSelected;

  DimensionDataChangeState(this.isSelected);
}

class BoxFlowState extends CalculationState {
  final List<Box> boxes;
  final bool isAddingBox;
  final bool isStackable;

  BoxFlowState({
    required this.boxes,
    required this.isAddingBox,
    required this.isStackable,
  });
}

final class SaveCalculationLoadingState extends CalculationState {}

final class SaveCalculationLoadedState extends CalculationState {
  final List<TruckDetailModel>? truckDetailModel;

  SaveCalculationLoadedState(this.truckDetailModel);
}

final class SaveCalculationErrorState extends CalculationState {
  final String error;

  SaveCalculationErrorState(this.error);
}

final class SubmitBoxLoadingState extends CalculationState {}

final class SubmitBoxLoadedState extends CalculationState {
  final CreateLoadModel? createLoadModel;

  SubmitBoxLoadedState(this.createLoadModel);
}

final class SubmitBoxErrorState extends CalculationState {
  final String error;

  SubmitBoxErrorState(this.error);
}

final class SaveBoxErrorState extends CalculationState {
  final String error;

  SaveBoxErrorState(this.error);
}