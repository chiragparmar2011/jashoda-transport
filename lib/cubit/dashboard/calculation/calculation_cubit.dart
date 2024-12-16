import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/data/model/create_load_model.dart';
import 'package:jashoda_transport/data/model/load/dimension_model.dart';
import 'package:jashoda_transport/data/model/new/box.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/repo_impl/truck_load_repo_impl/truck_load_repository_impl.dart';

part 'calculation_state.dart';

class CalculationCubit extends Cubit<CalculationState> {
  CalculationCubit(this.truckLoadRepositoryImpl) : super(CalculationInitial());

  TruckLoadRepositoryImpl truckLoadRepositoryImpl;

  int? dimension = DimensionUnits.cm.index;
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
      true,
      DimensionUnits.cm.index,
    ),
  ];

  final List<Box> boxes = [];
  int nextBoxNumber = 1;
  bool isAddingBox = false;

  List<TruckDetailModel>? truckDetailList = [];
  CreateLoadModel? createLoadModel;

  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool isStackable = true;

  void updateDimensions(bool isSelectedValue, int index) {
    if (unitDimensionList[index].isSelected) {
      return;
    }

    String oldDimension = unitDimensionList.firstWhere((unit) => unit.isSelected).name;
    String newDimension = unitDimensionList[index].name;

    unitDimensionList[index].isSelected = true;
    dimension = unitDimensionList[index].type;

    for (var i = 0; i < unitDimensionList.length; i++) {
      if (i != index) {
        unitDimensionList[i].isSelected = false;
      }
    }

    if (lengthController.text.isNotEmpty) {
      lengthController.text = convertUnit(
        double.tryParse(lengthController.text) ?? 0,
        oldDimension,
        newDimension,
      ).toStringAsFixed(2);
    }

    if (widthController.text.isNotEmpty) {
      widthController.text = convertUnit(
        double.tryParse(widthController.text) ?? 0,
        oldDimension,
        newDimension,
      ).toStringAsFixed(2);
    }

    if (heightController.text.isNotEmpty) {
      heightController.text = convertUnit(
        double.tryParse(heightController.text) ?? 0,
        oldDimension,
        newDimension,
      ).toStringAsFixed(2);
    }

    weightController.text = weightController.text;
    quantityController.text = quantityController.text;

    emit(DimensionDataChangeState(unitDimensionList[index].isSelected));
  }

  void saveBox() {
    final double? lengthValue = double.tryParse(lengthController.text);
    final double? widthValue = double.tryParse(widthController.text);
    final double? heightValue = double.tryParse(heightController.text);
    final double? quantityValue = double.tryParse(quantityController.text);
    final double? weightValue = double.tryParse(weightController.text);

    if (lengthValue == null ||
        widthValue == null ||
        heightValue == null ||
        quantityValue == null ||
        weightValue == null) {
      emit(SaveBoxErrorState('Please fill all fields.'));
      return;
    }

    final int length = (lengthValue > 0) ? lengthValue.round() : 1;
    final int width = (widthValue > 0) ? widthValue.round() : 1;
    final int height = (heightValue > 0) ? heightValue.round() : 1;
    final int quantity = (quantityValue > 0) ? quantityValue.round() : 1;
    final int weight = (weightValue > 0) ? weightValue.round() : 1;

    if (length > 0 && width > 0 && height > 0 && quantity > 0 && weight > 0) {
      boxes.add(Box(
        length: length,
        width: width,
        height: height,
        weight: weight,
        quantity: quantity,
        isStackable: isStackable,
      ));

      isAddingBox = false;
      nextBoxNumber++;
      clearForm();
      emit(BoxFlowState(
        boxes: List.from(boxes),
        isAddingBox: isAddingBox,
        isStackable: isStackable,
      ));
    }
  }

  double convertUnit(double value, String fromUnit, String toUnit) {
    const conversionRates = {
      'cm_to_inch': 0.393701,
      'cm_to_mm': 10,
      'cm_to_feet': 0.0328084,
      'inch_to_cm': 2.54,
      'inch_to_mm': 25.4,
      'inch_to_feet': 0.0833333,
      'mm_to_cm': 0.1,
      'mm_to_inch': 0.0393701,
      'mm_to_feet': 0.00328084,
      'feet_to_cm': 30.48,
      'feet_to_inch': 12,
      'feet_to_mm': 304.8,
    };

    if (fromUnit == toUnit) return value;

    final key = '${fromUnit}_to_$toUnit';
    return value * (conversionRates[key] ?? 1);
  }

  void resetBoxes() {
    boxes.clear();
    isAddingBox = false;
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  void removeBox(int index) {
    boxes.removeAt(index);
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

  void clearForm() {
    lengthController.clear();
    widthController.clear();
    heightController.clear();
    quantityController.clear();
    weightController.clear();
    isStackable = true;
  }

  void updateStackable(bool value) {
    isStackable = value;
    emit(BoxFlowState(
      boxes: List.from(boxes),
      isAddingBox: isAddingBox,
      isStackable: isStackable,
    ));
  }

  Future<void> fetchSaveCalculations(String userID) async {
    emit(SaveCalculationLoadingState());
    try {
      truckDetailList = await truckLoadRepositoryImpl.savedCalculation(userID);
      emit(SaveCalculationLoadedState(truckDetailList));
    } catch (error) {
      emit(SaveCalculationErrorState(
          ErrorHandler.handle(error).failure.message));
    }
  }

  Future<void> submitBox({String? userId}) async {
    emit(SubmitBoxLoadingState());
    try {
      createLoadModel = await truckLoadRepositoryImpl.submitBoxDataRepo(
        userId: userId,
        boxes: boxes,
      );
      nextBoxNumber = 1;
      if (createLoadModel != null) {
        emit(SubmitBoxLoadedState(createLoadModel));
      }
    } catch (error) {
      emit(SubmitBoxErrorState(ErrorHandler.handle(error).failure.message));
    }
  }
}
