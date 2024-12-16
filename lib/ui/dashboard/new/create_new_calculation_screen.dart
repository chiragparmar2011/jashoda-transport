import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/cancle_button.dart';
import 'package:jashoda_transport/core/widgets/buttons/check_button.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button_with_icon.dart';
import 'package:jashoda_transport/core/widgets/buttons/confirmation_button.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';
import 'package:jashoda_transport/core/widgets/dialog/confirmation_dialog.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/core/widgets/textformfield/dimension_from_field.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/data/model/load/dimension_model.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/vehicle/vehicle_loaded_screen.dart';

import 'widget/dimension_widget.dart';

class CreateNewCalculationScreen extends StatefulWidget {
  const CreateNewCalculationScreen({super.key});

  @override
  State<CreateNewCalculationScreen> createState() =>
      _CreateNewCalculationScreenState();
}

class _CreateNewCalculationScreenState
    extends State<CreateNewCalculationScreen> {
  final CalculationCubit calculationCubit = injector<CalculationCubit>();

  final _prefs = injector.get<SharedPreferenceHelper>();
  String? id = '';

  @override
  void initState() {
    id = _prefs.getString('id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: BlocConsumer<CalculationCubit, CalculationState>(
        bloc: calculationCubit,
        listener: (context, state) {
          if (state is SubmitBoxLoadedState) {
            final createLoadModel = state.createLoadModel;

            if (createLoadModel?.date == null ||
                (createLoadModel?.date ?? '').isEmpty) {
              Utils.errorMessage(context, "Invalid date received from server.");
              return;
            }
            Utils.successMessage(context, "Box Added");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VehicleLoadedScreen(
                  createLoadModel: state.createLoadModel,
                ),
              ),
            );
          }

          if (state is SaveBoxErrorState) {
            Utils.errorMessage(context, state.error);
          }

          if (state is SubmitBoxErrorState) {
            Utils.errorMessage(
              context,
              'No suitable truck can accommodate your boxes based on the given details.',
            );
          }
        },
        builder: (context, state) {
          if (state is SubmitBoxLoadingState) {
            return const Center(
              child: CommonProgressIndicator(
                color: AppColors.primaryBlue,
              ),
            );
          }
          return _buildMain();
        },
      ),
    );
  }

  Widget _buildMain() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimentions.sizedBox16H,
                Text(
                  AppStrings.calculateYourLoad,
                  style: TextStyles().textStylesNunito(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Dimentions.sizedBox4H,
                Text(
                  AppStrings.calculationHeader,
                  style: TextStyles().textStylesMontserrat(
                    fontSize: 12,
                  ),
                ),
                Dimentions.sizedBox24H,
                if (calculationCubit.isAddingBox)
                  _buildAddBoxForm(context)
                else
                  _buildBoxList(context),
              ],
            ),
          ),
        ),
        calculationCubit.boxes.isNotEmpty ? const Divider() : Container(),
        if (calculationCubit.boxes.isNotEmpty && !calculationCubit.isAddingBox)
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: CancelButton(
                    width: 174,
                    height: 44,
                    title: AppStrings.reset,
                    onPressed: () {
                      calculationCubit.resetBoxes();
                    },
                  ),
                ),
                Dimentions.sizedBox16W,
                Flexible(
                  child: ConfirmationButton(
                    width: 174,
                    height: 44,
                    foregroundColor: AppColors.orange,
                    title: AppStrings.submit,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmationDialog(
                          confirmationTitle: AppStrings.youWantToSubmit,
                          confirmText: AppStrings.submit,
                          cancelText: AppStrings.cancel,
                          confirmOnPressed: () {
                            calculationCubit.submitBox(
                              userId: id,
                            );
                            Navigator.pop(context);
                          },
                          cancelOnPressed: () {
                            Navigator.of(context).pop();
                          },
                          bgColor: AppColors.green,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAddBoxForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectDimension,
          style: TextStyles().textStylesMontserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Dimentions.sizedBox8H,
        SizedBox(
          height: 32,
          child: ListView.separated(
            itemCount: calculationCubit.unitDimensionList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DimensionModel dimensionData =
                  calculationCubit.unitDimensionList[index];
              return DimensionWidget(
                unitName: dimensionData.name,
                selectedTextColor: dimensionData.isSelected
                    ? AppColors.white
                    : AppColors.black,
                selectBgColor: dimensionData.isSelected
                    ? AppColors.primaryBlue
                    : AppColors.white,
                onTap: () {
                  calculationCubit.updateDimensions(
                      dimensionData.isSelected, index);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Dimentions.sizedBox12W;
            },
          ),
        ),
        Dimentions.sizedBox24H,
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.greyWhite),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Box',
                style: TextStyles().textStylesNunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Dimentions.sizedBox12H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DimensionFromField(
                      controller: calculationCubit.lengthController,
                      hintText: AppStrings.enterLength,
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(
                    child: DimensionFromField(
                      controller: calculationCubit.widthController,
                      hintText: AppStrings.enterWidth,
                    ),
                  ),
                ],
              ),
              Dimentions.sizedBox24H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DimensionFromField(
                      controller: calculationCubit.heightController,
                      hintText: AppStrings.enterHeight,
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(
                    child: DimensionFromField(
                      controller: calculationCubit.quantityController,
                      hintText: AppStrings.noOfQuantity,
                    ),
                  ),
                ],
              ),
              Dimentions.sizedBox24H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DimensionFromField(
                      controller: calculationCubit.weightController,
                      hintText: AppStrings.enterWeight,
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(child: Container()),
                ],
              ),
              Dimentions.sizedBox24H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CheckButton(
                      height: 40,
                      title: AppStrings.stackable,
                      onChanged: () {
                        calculationCubit.updateStackable(true);
                      },
                      backGroundColor: calculationCubit.isStackable
                          ? AppColors.primaryBlue
                          : AppColors.white,
                      borderColor: calculationCubit.isStackable
                          ? AppColors.primaryBlue
                          : AppColors.black,
                      textColor: calculationCubit.isStackable
                          ? AppColors.white
                          : AppColors.black,
                      iconWidget: calculationCubit.isStackable
                          ? ImageAssets(image: AssetsPath.checkIcon)
                          : null,
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(
                    child: CheckButton(
                      height: 40,
                      title: AppStrings.nonStackable,
                      onChanged: () {
                        calculationCubit.updateStackable(false);
                      },
                      backGroundColor: !calculationCubit.isStackable
                          ? AppColors.primaryBlue
                          : AppColors.white,
                      borderColor: !calculationCubit.isStackable
                          ? AppColors.white
                          : AppColors.black,
                      textColor: !calculationCubit.isStackable
                          ? AppColors.white
                          : AppColors.black,
                      iconWidget: !calculationCubit.isStackable
                          ? ImageAssets(image: AssetsPath.checkIcon)
                          : null,
                    ),
                  ),
                ],
              ),
              Dimentions.sizedBox32H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CancelButton(
                      width: 174,
                      height: 44,
                      title: AppStrings.cancel,
                      onPressed: () {
                        calculationCubit.toggleAddBox(false);
                        calculationCubit.clearForm();
                      },
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(
                    child: ConfirmationButton(
                      width: 174,
                      height: 44,
                      title: AppStrings.save,
                      onPressed: () {
                        calculationCubit.saveBox();
                      },
                      isConfirm: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoxList(BuildContext context) {
    if (calculationCubit.isAddingBox) {
      return Container();
    } else {
      return Column(
        children: [
          ListView.builder(
            itemCount: calculationCubit.boxes.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final box = calculationCubit.boxes[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left section: Box details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Box No. ${index + 1}",
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 16.0,
                              runSpacing: 8.0,
                              children: [
                                Text(
                                  "Length: ${box.length}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  "Width: ${box.width}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  "Height: ${box.height}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 16.0,
                              runSpacing: 8.0,
                              children: [
                                Text(
                                  "No. of Items: ${box.quantity}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  "Items: ${box.isStackable ? 'Stackable' : 'Not Stackable'}",
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: InkWell(
                          child: ImageAssets(
                            image: AssetsPath.deleteIcon,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmationDialog(
                                confirmationTitle: AppStrings.youWantToDelete,
                                confirmText: AppStrings.delete,
                                cancelText: AppStrings.cancel,
                                confirmOnPressed: () {
                                  calculationCubit.removeBox(index);
                                  Navigator.of(context).pop();
                                },
                                cancelOnPressed: () {
                                  Navigator.of(context).pop();
                                },
                                bgColor: AppColors.red,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Dimentions.sizedBox24H,
          CustomButtonWithIconWidget(
            height: 48,
            title: AppStrings.addBox,
            onPressed: () {
              calculationCubit.toggleAddBox(true);
            },
            iconWidget: ImageAssets(image: AssetsPath.addWhiteIcon),
          ),
        ],
      );
    }
  }
}
