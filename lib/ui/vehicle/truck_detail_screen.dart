import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/back_arrow.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/dashboard/home/home_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';

class TruckDetailScreen extends StatefulWidget {
  final String truckId;

  const TruckDetailScreen({super.key, required this.truckId});

  @override
  State<TruckDetailScreen> createState() => _TruckDetailScreenState();
}

class _TruckDetailScreenState extends State<TruckDetailScreen> {
  final HomeCubit homeCubit = injector<HomeCubit>();

  @override
  void initState() {
    homeCubit.fetchSingleTruck(widget.truckId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            if (state is SingleTruckLoadingState) {
              return const Center(
                child: CommonProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              );
            } else if (state is SingleTruckSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimentions.sizedBox24H,
                    BackArrowWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Dimentions.sizedBox20H,
                    ImageAssets(
                      image: AssetsPath.deliveryTruckIcon,
                      height: 110,
                      width: 110,
                    ),
                    Dimentions.sizedBox20H,
                    _buildContentText(
                      homeCubit.truckDetailModel?.truckDetails?.name ?? '',
                    ),
                    _buildDividerView(),
                    _buildHeaderText(AppStrings.dimensions),
                    Dimentions.sizedBox8H,
                    _buildContentText(
                      '${homeCubit.truckDetailModel?.truckDetails?.dimensions?.l ?? '0.0'} L X '
                      '${homeCubit.truckDetailModel?.truckDetails?.dimensions?.w ?? '0.0'} W X '
                      '${homeCubit.truckDetailModel?.truckDetails?.dimensions?.h ?? '0.0'} H',
                      fontSize: 20,
                      alignLeft: true,
                    ),
                    Dimentions.sizedBox10H,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildContentText(
                          'Max Load: ${homeCubit.truckDetailModel?.truckDetails?.maxLoad}',
                          fontSize: 16,
                        ),
                        _buildContentText(
                          'Total Weight: ${homeCubit.truckDetailModel?.truckDetails?.totalWeight}',
                          fontSize: 16,
                        ),
                      ],
                    ),
                    _buildDividerView(),
                    _buildHeaderText('Box Summary:'),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total Boxes: ${homeCubit.truckDetailModel?.boxes?.length}',
                        style: TextStyles().textStylesNunito(
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(
                        (homeCubit.truckDetailModel?.boxes ?? []).length,
                        (index) {
                          final box = homeCubit.truckDetailModel?.boxes?[index];
                          final isSingleBox =
                              homeCubit.truckDetailModel?.boxes?.length == 1;
                          final boxWidth = isSingleBox
                              ? MediaQuery.of(context).size.width
                              : (MediaQuery.of(context).size.width - 64);
                          return SizedBox(
                            width: boxWidth,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.greyWhite),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Box ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  _buildContentText(
                                    'Length: ${box?.boxLength}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                  _buildContentText(
                                    'Width: ${box?.boxWidth}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                  _buildContentText(
                                    'Height: ${box?.boxHeight}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                  _buildContentText(
                                    'Weight: ${box?.boxWeight}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                  _buildContentText(
                                    'Quantity: ${box?.boxQuantity}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                  _buildContentText(
                                    'Stackable: ${(box?.isStackable ?? false) ? "Yes" : "No"}',
                                    fontSize: 14,
                                    alignLeft: true,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FetchSingleTruckError) {
              Utils.errorMessage(context, state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
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
