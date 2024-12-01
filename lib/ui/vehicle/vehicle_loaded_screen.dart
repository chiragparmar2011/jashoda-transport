import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/data/model/CreatLoadModel.dart';
import 'package:jashoda_transport/ui/dashboard/dashboard_screen.dart';

import '../../cubit/bottomnav/bottom_nav_cubit.dart';

class VehicleLoadedScreen extends StatefulWidget {
  Creatloadmodel? creatloadmodel;

  VehicleLoadedScreen({this.creatloadmodel});

  @override
  State<VehicleLoadedScreen> createState() => _VehicleLoadedScreenState();
}

class _VehicleLoadedScreenState extends State<VehicleLoadedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Dimentions.sizedBox8H,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppStrings.perfectVehicleForLoad,
                  style: TextStyles().textStylesNunito(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Dimentions.sizedBox24H,
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(
                    color: AppColors.greyLightWhite,
                  ),
                ),
                child: ImageAssets(
                  image: AssetsPath.shipping,
                  height: 180,
                  width: 180,
                ),
              ),
              Dimentions.sizedBox24H,
              Text(
                AppStrings.vehicleName,
                style: TextStyles().textStylesMontserrat(
                  fontSize: 12,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.creatloadmodel!.truckDetails!.truckName.toString(),
                style: TextStyles().textStylesNunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimentions.sizedBox20H,
              Text(
                AppStrings.dimentions,
                style: TextStyles().textStylesMontserrat(
                  fontSize: 12,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.creatloadmodel!.truckDetails!.dimensions?.l.toString()} L X ${widget.creatloadmodel!.truckDetails!.dimensions?.w.toString()} W X ${widget.creatloadmodel!.truckDetails!.dimensions?.h.toString()} H (in foot)',
                style: TextStyles().textStylesNunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Dimentions.sizedBox20H,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppStrings.weightCapacity,
                    style: TextStyles().textStylesMontserrat(
                      fontSize: 12,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    AppStrings.date,
                    style: TextStyles().textStylesMontserrat(
                      fontSize: 12,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Max Load ${widget.creatloadmodel!.truckDetails?.maxLoad.toString()} kgs',
                    style: TextStyles().textStylesNunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatIsoTimestamp(widget.creatloadmodel!.date.toString()),
                    style: TextStyles().textStylesNunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Dimentions.sizedBox20H,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No. of boxes: ${widget.creatloadmodel!.boxDetails?.totalBoxes.toString()}",
                    style: TextStyles().textStylesMontserrat(
                      fontSize: 12,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ...?widget.creatloadmodel!.boxDetails?.boxes?.map((box) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Box No. ${box.boxNumber}: ${box.items} items',
                            style: TextStyles().textStylesNunito(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
              Dimentions.sizedBox40H,
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
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    context.read<BottomNavCubit>().updateNavItem(BottomNavItem.home);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }

  /// Function to format an ISO 8601 timestamp into `dd/MM/yyyy` format.
  String formatIsoTimestamp(String isoTimestamp) {
    try {
      // Parse the timestamp into a DateTime object
      DateTime dateTime = DateTime.parse(isoTimestamp);
      // Format the DateTime into the desired format
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      // Handle any parsing errors
      return "Invalid date";
    }
  }
}
