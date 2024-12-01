import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
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
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/vehicle/vehicle_loaded_screen.dart';

import 'widget/dimension_widget.dart';

class CreateNewCalculationScreen extends StatefulWidget {
  CreateNewCalculationScreen({super.key});

  @override
  State<CreateNewCalculationScreen> createState() => _CreateNewCalculationScreenState();
}

class _CreateNewCalculationScreenState extends State<CreateNewCalculationScreen> {
  final CalculationCubit calculationCubit = injector<CalculationCubit>();

  final _prefs = injector.get<SharedPreferenceHelper>();
 String? id;

  @override
  void initState() {
    setState(() {
      id = _prefs.getString("id");

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Id is==>${id}");

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocConsumer<CalculationCubit, CalculationState>(
            bloc: calculationCubit,
            listener: (context, state) {},
            builder: (context, state) {
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
                          if (calculationCubit.isAddingBox) _buildAddBoxForm(context) else _buildBoxList(context),
                        ],
                      ),
                    ),
                  ),
                  calculationCubit.boxes.isNotEmpty ? Divider() : Container(),
                  // Reset and Submit Buttons at the bottom
                  if (calculationCubit.boxes.isNotEmpty)
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
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleLoadedScreen(),));
                                showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16), // Rounded corners for the dialog
                                    ),
                                    backgroundColor: Colors.white, // Set dialog background color to white
                                    title: const Text(
                                      'Are you sure you want to submit?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis, // Prevent wrapping if text is long
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.black, // Text color
                                                backgroundColor: Colors.white, // Button background color
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 12,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12), // Button corners
                                                  side: const BorderSide(
                                                    color: Colors.black, // Border color
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close dialog
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white, // Text color
                                                backgroundColor: Color(0xff1DA116), // Button color
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 12,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12), // Button corners
                                                ),
                                              ),
                                              onPressed: () async {
                                                // Handle submit action here
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
            },
          ),
        ));
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
              DimensionModel dimensionData = calculationCubit.unitDimensionList[index];
              return DimensionWidget(
                unitName: dimensionData.name,
                selectedTextColor: dimensionData.isSelected ? AppColors.white : AppColors.black,
                selectBgColor: dimensionData.isSelected ? AppColors.primaryBlue : AppColors.white,
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
                      backGroundColor: calculationCubit.isStackable ? AppColors.primaryBlue : AppColors.white,
                      borderColor: calculationCubit.isStackable ? AppColors.primaryBlue : AppColors.black,
                      textColor: calculationCubit.isStackable ? AppColors.white : AppColors.black,
                      iconWidget: calculationCubit.isStackable ? ImageAssets(image: AssetsPath.checkIcon) : null,
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
                      backGroundColor: !calculationCubit.isStackable ? AppColors.primaryBlue : AppColors.white,
                      borderColor: !calculationCubit.isStackable ? AppColors.white : AppColors.black,
                      textColor: !calculationCubit.isStackable ? AppColors.white : AppColors.black,
                      iconWidget: !calculationCubit.isStackable ? ImageAssets(image: AssetsPath.checkIcon) : null,
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
                        calculationCubit.saveBox();
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
          physics: NeverScrollableScrollPhysics(), // Prevent scrolling within ListView
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    // Right section: Delete icon
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: InkWell(
                        child: ImageAssets(
                          image: AssetsPath.deleteIcon,
                        ),
                        onTap: () {
                          print("Tapper");
                          calculationCubit.removeBox(index);
                        },
                      ),
                    )
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
        // SizedBox(height: 10,),
      ],
    );
  }
}
