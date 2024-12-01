import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';

class VehicleLoadedScreen extends StatelessWidget {
  const VehicleLoadedScreen({super.key});

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
                'TATA ACE',
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
                '7 L X 4.8 W X 4.8 H (in foot)',
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
                    'Max Load 850 kgs',
                    style: TextStyles().textStylesNunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '23/10/2024',
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
                    AppStrings.noOfBoxes,
                    style: TextStyles().textStylesMontserrat(
                      fontSize: 12,
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Box No. 1: 12 items',
                        style: TextStyles().textStylesNunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Box No. 1: 12 items',
                        style: TextStyles().textStylesNunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Box No. 1: 12 items',
                        style: TextStyles().textStylesNunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Box No. 1: 12 items',
                        style: TextStyles().textStylesNunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Dimentions.sizedBox40H,
              CustomButtonWidget(
                title: AppStrings.save,
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.savedCalculationScreen);
                },
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
