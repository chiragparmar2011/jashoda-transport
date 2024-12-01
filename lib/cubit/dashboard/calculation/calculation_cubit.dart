import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/data/model/load/calculation_model.dart';
import 'package:jashoda_transport/data/model/load/dimension_model.dart';
import 'package:jashoda_transport/data/model/new/box.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/repo_impl/truck_load_repo_impl/truck_load_repository_impl.dart';

part 'calculation_state.dart';

class CalculationCubit extends Cubit<CalculationState> {
  CalculationCubit(this.truckLoadRepositoryImpl) : super(CalculationInitial());

  TruckLoadRepositoryImpl truckLoadRepositoryImpl;

  int? age;
  // State variables
  List<DimensionModel> unitDimensionList = [
    DimensionModel(
      'inch',
      false,
      DimensionUnits.inch.index,
    ),
    DimensionModel(
      'mm',
      false,
      DimensionUnits.mm.index,
    ),
    DimensionModel(
      'feet',
      false,
      DimensionUnits.feet.index,
    ),
    DimensionModel(
      'cm',
      false,
      DimensionUnits.cm.index,
    ),
  ];
  final List<Box> boxes = [];
  bool isAddingBox = false;

  // Controllers
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool isStackable = true;


  // Emit dimension changes
  void updateDimensions(bool isSelectedValue, int index) {
    unitDimensionList[index].isSelected = !isSelectedValue;
    if (unitDimensionList[index].isSelected) {
      age = unitDimensionList[index].type;
    } else {
      age = null;
    }
    for (var i = 0; i < unitDimensionList.length; i++) {
      if (i != index) {
        unitDimensionList[i].isSelected = false;
      }
    }
    emit(DimensionDataChangeState(unitDimensionList[index].isSelected));
  }

  // Start adding a new box
  void startAddingBox() {
    isAddingBox = true;
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  // Save a box
  void saveBox() {
    final int length = int.tryParse(lengthController.text) ?? 0;
    final int width = int.tryParse(widthController.text) ?? 0;
    final int height = int.tryParse(heightController.text) ?? 0;
    final int quantity = int.tryParse(quantityController.text) ?? 0;

    if (length > 0 && width > 0 && height > 0 && quantity > 0) {
      boxes.add(Box(
        length: length,
        width: width,
        height: height,
        quantity: quantity,
        isStackable: isStackable,
      ));
      isAddingBox = false;
      clearForm();
      emit(BoxFlowState(
        boxes: List.from(boxes),
        isAddingBox: isAddingBox,
        isStackable: isStackable,
      ));
    } else {
      // Trigger an error state or use a listener in the UI
    }
  }

  // Reset all boxes
  void resetBoxes() {
    boxes.clear();
    isAddingBox = false;
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  void toggleAddBox(bool value) {
    isAddingBox = value;
    emit(
      BoxFlowState(
        boxes: List.from(boxes),
        isAddingBox: isAddingBox,
        isStackable: isStackable,
      ),
    );
  }

  // Submit boxes
  void submitBoxes() {
    // Handle box submission logic
    // Navigate to next screen with _boxes data
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NextScreen(boxes: _boxes),
    //   ),
    // );
    print("Submitted Boxes: $boxes");
  }

  // Clear form
  void clearForm() {
    lengthController.clear();
    widthController.clear();
    heightController.clear();
    quantityController.clear();
    isStackable = true;
  }

  // Update stackable status
  void updateStackable(bool value) {
    isStackable = value;
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  // Delete a box
  void deleteBox(int index) {
    boxes.removeAt(index);
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  List<TruckDetailModel>? truckDetailList = [];

  /// Save Calculation API CALl
  Future<void> fetchSaveCalculations(String userID) async {
    emit(SaveCalculationLoadingState());
    try {
      truckDetailList = await truckLoadRepositoryImpl.savedCalculation(userID);
      emit(SaveCalculationLoadedState(truckDetailList));
    } catch (error) {
      emit(SaveCalculationErrorState(ErrorHandler.handle(error).failure.message));
    }
  }
}
