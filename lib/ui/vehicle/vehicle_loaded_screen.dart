import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/data/model/load/create_load_model.dart';
import 'package:jashoda_transport/ui/dashboard/dashboard_screen.dart';

class VehicleLoadedScreen extends StatefulWidget {
  final CreateLoadModel? data;

  const VehicleLoadedScreen({super.key, this.data});

  @override
  State<VehicleLoadedScreen> createState() => _VehicleLoadedScreenState();
}

class _VehicleLoadedScreenState extends State<VehicleLoadedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                ImageAssets(
                  image: AssetsPath.deliveryTruckIcon,
                  height: 110,
                  width: 110,
                ),
                Dimentions.sizedBox20H,
                _buildContentText(widget.data?.truckDetails?.truckName ?? ''),
                _buildDividerView(),
                _buildHeaderText(AppStrings.dimensions),
                Dimentions.sizedBox8H,
                _buildContentText(
                  '${widget.data?.truckDetails?.dimensions?.l} L X '
                  '${widget.data?.truckDetails?.dimensions?.w} W X '
                  '${widget.data?.truckDetails?.dimensions?.h} H',
                  fontSize: 20,
                  alignLeft: true,
                ),
                Dimentions.sizedBox10H,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildContentText(
                      'Max Load: ${widget.data?.truckDetails?.maxLoad}',
                      fontSize: 16,
                    ),
                    _buildContentText(
                      'Total Weight: ${widget.data?.truckDetails?.totalWeight}',
                      fontSize: 16,
                    ),
                  ],
                ),
                _buildDividerView(),
                _buildHeaderText('Box Summary'),
                Dimentions.sizedBox8H,
                _buildContentText(
                  'Total Boxes: ${widget.data?.boxDetails?.totalBoxes}',
                  alignLeft: true,
                ),
                _buildContentText(
                  'Total Items: ${widget.data?.boxDetails?.totalItems}',
                  alignLeft: true,
                ),
                const SizedBox(height: 12),
                ...?widget.data?.boxDetails?.boxes?.map(
                  (box) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _buildContentText(
                          'Box ${box.boxNumber}: ${box.items} items',
                          fontSize: 16,
                          alignLeft: true,
                        ),
                      ),
                    );
                  },
                ),
                _buildDividerView(),
                _buildHeaderText('Loading Instructions'),
                const SizedBox(height: 8),
                ...(widget.data?.truckDetails?.loadingInstructions ?? []).map(
                  (step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContentText(
                          'Step ${step.step}:',
                          fontSize: 16,
                          alignLeft: true,
                        ),
                        Text(
                          step.content ?? '',
                          style: TextStyles().textStylesNunito(fontSize: 14),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildDividerView(),
                _buildHeaderText('Loading Zones'),
                const SizedBox(height: 8),
                ...(widget.data?.truckDetails?.loadingZones ?? []).map(
                  (zone) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContentText(
                          'Zone ${zone.zoneNumber} (${zone.width} x ${zone.height}):',
                          fontSize: 16,
                          alignLeft: true,
                        ),
                        _buildContentText(
                          'Box: ${zone.boxDetails?.boxLength} x ${zone.boxDetails?.boxWidth} x ${zone.boxDetails?.boxHeight}, '
                          'Weight: ${zone.boxDetails?.boxWeight}kg',
                          fontSize: 16,
                          alignLeft: true,
                        ),
                        _buildContentText(
                          'Quantity: ${zone.boxDetails?.boxQuantity}, '
                          'Stackable: ${zone.boxDetails?.isStackable ?? false ? "Yes" : "No"}',
                          fontSize: 16,
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
                    navigateToHomeScreen(context);
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    context.read<BottomNavCubit>().updateNavItem(BottomNavItem.calculation);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
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
