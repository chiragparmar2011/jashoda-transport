import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/data/model/load/box.dart';
import 'package:jashoda_transport/data/model/load/create_load_model.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/widget/truck_view.dart';

class VehicleLoadedScreen extends StatefulWidget {
  final CreateLoadModel? data;
  final List<Box>? boxes;

  const VehicleLoadedScreen({super.key, this.data, this.boxes});

  @override
  State<VehicleLoadedScreen> createState() => _VehicleLoadedScreenState();
}

class _VehicleLoadedScreenState extends State<VehicleLoadedScreen> {
  final CalculationCubit calculationCubit = injector<CalculationCubit>();
  String id = '';
  final _prefs = injector.get<SharedPreferenceHelper>();
  SelectedTruck? _selectedTruck;

  @override
  void initState() {
    id = _prefs.getString('id');
    _selectedTruck = widget.data?.selectedTruck;
    super.initState();
  }

  SelectedTruck convertToSelectedTruck(AlternativeTrucks truck) {
    return SelectedTruck(
      name: truck.name,
      maxWeight: truck.maxWeight?.toInt(),
      dimensions: truck.dimensions,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Merged (Selected & Alternative) trucks.
    List<AlternativeTrucks> allTrucks = [
      if (widget.data?.selectedTruck != null)
        AlternativeTrucks(
          name: widget.data?.selectedTruck?.name,
          dimensions: widget.data?.selectedTruck?.dimensions,
          maxWeight: widget.data?.selectedTruck?.maxWeight?.toDouble(),
        ),
      ...widget.data?.alternativeTrucks ?? [],
    ];

    /// Remove Duplicate Trucks.
    final uniqueTrucks = {
      for (var t in allTrucks) t.name: t,
    }.values.toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocConsumer<CalculationCubit, CalculationState>(
            bloc: calculationCubit,
            listener: (context, state) {
              switch (state) {
                case SubmitTruckLoadedState():
                  Utils.successMessage(
                    context,
                    'Truck load saved successfully.',
                  );
                  navigateToHomeScreen(context);
                  break;
                case SubmitBoxErrorState():
                  Utils.errorMessage(context, state.error);
                  break;
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimentions.sizedBox8H,
                    Center(
                      child: Text(
                        AppStrings.truckCalculation,
                        style: TextStyles().textStylesNunito(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Dimentions.sizedBox20H,
                    const TruckViewWidget(),
                    Dimentions.sizedBox20H,
                    Text(
                      AppStrings.vehicleName,
                      style: TextStyles().textStylesMontserrat(
                        fontSize: 12,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Text(
                      _selectedTruck?.name ?? '',
                      style: TextStyles().textStylesNunito(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    _buildDividerView(),
                    _buildHeaderText(AppStrings.dimensions),
                    Dimentions.sizedBox8H,
                    _buildContentText(
                      '${_selectedTruck?.dimensions?.length} L X '
                      '${_selectedTruck?.dimensions?.width} W X '
                      '${_selectedTruck?.dimensions?.height} H',
                      fontSize: 20,
                      alignLeft: true,
                    ),
                    Dimentions.sizedBox10H,
                    _buildContentText(
                      'Max Weight: ${_selectedTruck?.maxWeight}',
                      fontSize: 16,
                      alignLeft: true,
                    ),
                    // _buildDividerView(),
                    // _buildHeaderText('Loading Zones'),
                    // const SizedBox(height: 8),
                    // ...(widget.data?.loadingPlan?.zones ?? []).map(
                    //   (zone) => Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 6),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         _buildContentText(
                    //           'Zone ${zone.zoneNumber} (W: ${zone.dimensionsDepth?.width}, H: ${zone.dimensionsDepth?.height}, D: ${zone.dimensionsDepth?.depth})',
                    //           fontSize: 16,
                    //           alignLeft: true,
                    //         ),
                    //         _buildContentText(
                    //           'Position: X: ${zone.position?.x}, Y: ${zone.position?.y}, Z: ${zone.position?.z}',
                    //           fontSize: 14,
                    //           alignLeft: true,
                    //         ),
                    //         _buildContentText(
                    //           'Box Size: ${zone.boxDetails?.dimensions?.length} x ${zone.boxDetails?.dimensions?.width} x ${zone.boxDetails?.dimensions?.height}, '
                    //           'Weight: ${zone.boxDetails?.weight}kg',
                    //           fontSize: 14,
                    //           alignLeft: true,
                    //         ),
                    //         _buildContentText(
                    //           'Quantity: ${zone.boxDetails?.quantity}, '
                    //           'Stackable: ${zone.boxDetails?.stackable == true ? "Yes" : "No"}',
                    //           fontSize: 14,
                    //           alignLeft: true,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // _buildDividerView(),
                    // _buildHeaderText('Step-by-Step Plan'),
                    // const SizedBox(height: 8),
                    // ...(widget.data?.loadingPlan?.steps ?? []).map(
                    //   (step) => Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 6),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         _buildContentText(
                    //           'Step ${step.stepNumber}: ${step.action}',
                    //           fontSize: 16,
                    //           alignLeft: true,
                    //         ),
                    //         Dimentions.sizedBox4H,
                    //         Text(
                    //           'Box Dimensions: ${step.details?.boxDimensions}\n'
                    //           'Weight: ${step.details?.boxWeight}\n'
                    //           'Location: ${step.details?.zoneLocation}\n'
                    //           'Running Weight: ${step.details?.runningWeight}',
                    //           style: TextStyles().textStylesNunito(fontSize: 14),
                    //         ),
                    //         if ((step.safetyNotes?.isNotEmpty ?? false))
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 4),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: step.safetyNotes!.map((note) {
                    //                 return Text(
                    //                   note,
                    //                   style: TextStyles().textStylesNunito(
                    //                     fontSize: 12,
                    //                     color: AppColors.orange,
                    //                   ),
                    //                 );
                    //               }).toList(),
                    //             ),
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    _buildDividerView(),
                    _buildHeaderText('Alternative Trucks'),
                    const SizedBox(height: 8),
                    ...(uniqueTrucks).map(
                      (truck) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTruck = convertToSelectedTruck(truck);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _selectedTruck?.name == truck.name
                                  ? AppColors.green.withOpacity(0.2)
                                  : AppColors.white,
                              border: Border.all(
                                color: _selectedTruck?.name == truck.name
                                    ? AppColors.green
                                    : AppColors.primaryBlue,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildContentText(
                                  truck.name ?? '',
                                  fontSize: 16,
                                  alignLeft: true,
                                ),
                                _buildContentText(
                                  'Dimensions: ${truck.dimensions?.length} x ${truck.dimensions?.width} x ${truck.dimensions?.height}',
                                  fontSize: 14,
                                  alignLeft: true,
                                ),
                                _buildContentText(
                                  'Max Load: ${truck.maxWeight}',
                                  fontSize: 14,
                                  alignLeft: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // _buildDividerView(),
                    // _buildHeaderText('Loading Instructions'),
                    // const SizedBox(height: 8),
                    // ...(widget.data?.loadingPlan?.instructions ?? []).map(
                    //   (step) => Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 6),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         _buildContentText(
                    //           'Step ${step.step}: ${step.zone}',
                    //           fontSize: 16,
                    //           alignLeft: true,
                    //         ),
                    //         Text(
                    //           step.instruction ?? '',
                    //           style: TextStyles().textStylesNunito(fontSize: 14),
                    //           textAlign: TextAlign.left,
                    //         ),
                    //         if (step.warning != null)
                    //           Padding(
                    //             padding: const EdgeInsets.only(top: 4.0),
                    //             child: Text(
                    //               '${step.warning}',
                    //               style: TextStyles().textStylesNunito(
                    //                 fontSize: 12,
                    //                 color: AppColors.red,
                    //               ),
                    //             ),
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    _buildDividerView(),
                    _buildHeaderText('Box Summary'),
                    Dimentions.sizedBox8H,
                    _buildContentText(
                      'Total Boxes: ${widget.data?.boxDetailsItems?.totalBoxes}',
                      alignLeft: true,
                    ),
                    _buildContentText(
                      'Total Items: ${widget.data?.boxDetailsItems?.totalItems}',
                      alignLeft: true,
                    ),
                    const SizedBox(height: 12),
                    ...(widget.data?.boxDetailsItems?.boxes ?? []).map(
                      (box) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContentText(
                              'Box ${box.boxNumber}:',
                              fontSize: 16,
                              alignLeft: true,
                            ),
                            _buildContentText(
                              'Dimensions: ${box.dimensions?.length} x ${box.dimensions?.width} x ${box.dimensions?.height} cm',
                              fontSize: 14,
                              alignLeft: true,
                            ),
                            _buildContentText(
                              'Weight: ${box.weight} kg',
                              fontSize: 14,
                              alignLeft: true,
                            ),
                            _buildContentText(
                              'Quantity: ${box.quantity}',
                              fontSize: 14,
                              alignLeft: true,
                            ),
                            _buildContentText(
                              'Stackable: ${box.stackable == true ? "Yes" : "No"}',
                              fontSize: 14,
                              alignLeft: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dimentions.sizedBox20H,
                    CustomButtonWidget(
                      title: AppStrings.save,
                      onPressed: () {
                        if (_selectedTruck != null) {
                          Map<String, dynamic> data = {
                            'name': _selectedTruck?.name,
                            'dimensions': _selectedTruck?.dimensions,
                            'total_weight': _selectedTruck?.maxWeight,
                          };
                          calculationCubit.submitSelectedTruck(
                            userId: id,
                            truckDetails: data,
                            boxes: widget.boxes,
                          );
                        }
                      },
                      isLoading: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    context.read<BottomNavCubit>().updateNavItem(BottomNavItem.calculation);
    Navigator.pushNamedAndRemoveUntil(
      context,
      MyRoutes.dashboardScreen,
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildHeaderText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyles().textStylesMontserrat(
          fontSize: 14,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContentText(String text,
      {double fontSize = 24, bool alignLeft = false}) {
    return Align(
      alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
      child: Text(
        text,
        style: TextStyles().textStylesNunito(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDividerView() {
    return const Column(
      children: [
        Dimentions.sizedBox10H,
        Divider(color: AppColors.greyWhite),
        Dimentions.sizedBox10H,
      ],
    );
  }
}
