import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/cancle_button.dart';
import 'package:jashoda_transport/core/widgets/buttons/check_button.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button_with_icon.dart';
import 'package:jashoda_transport/core/widgets/buttons/confirmation_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/core/widgets/textformfield/dimension_from_field.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/data/model/load/dimension_model.dart';
import 'package:jashoda_transport/getit_injector.dart';

import 'widget/dimension_widget.dart';

class CreateNewCalculationScreen extends StatelessWidget {
  CreateNewCalculationScreen({super.key});

  final CalculationCubit calculationCubit = injector<CalculationCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocConsumer<CalculationCubit, CalculationState>(
          bloc: calculationCubit,
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
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
            );
          },
        ),
      ),
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
                  calculationCubit.updateDimensions;
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
                'Box No. 1',
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CancelButton(
                      width: 174,
                      height: 44,
                      title: AppStrings.cancel,
                      onPressed: () {
                        calculationCubit.isAddingBox = false;
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
                        calculationCubit.saveBox;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
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

  Widget _buildBoxList(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: calculationCubit.boxes.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final box = calculationCubit.boxes[index];
            return Card(
              child: ListTile(
                title: Text(
                  'Box ${index + 1}: ${box.length} x ${box.width} x ${box.height}',
                ),
                subtitle: Text(
                  'Quantity: ${box.quantity}, Stackable: ${box.isStackable ? 'Yes' : 'No'}',
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    calculationCubit.boxes.removeAt(index);
                  },
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
        if (calculationCubit.boxes.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CancelButton(
                  width: 174,
                  height: 44,
                  title: AppStrings.reset,
                  onPressed: () {
                    calculationCubit.resetBoxes;
                  },
                ),
              ),
              Dimentions.sizedBox16W,
              Flexible(
                child: ConfirmationButton(
                  width: 174,
                  height: 44,
                  title: AppStrings.submit,
                  onPressed: () {},
                  backgroundColor: AppColors.orange,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
