import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/dashboard/calculation/calculation_cubit.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/getit_injector.dart';

class SavedCalculationScreen extends StatefulWidget {
  const SavedCalculationScreen({super.key});

  @override
  State<SavedCalculationScreen> createState() => _SavedCalculationScreenState();
}

class _SavedCalculationScreenState extends State<SavedCalculationScreen> {
  final CalculationCubit calculationCubit = injector<CalculationCubit>();

  @override
  void initState() {
    // calculationCubit.fetchSaveCalculations('6744b9f4a07f02312a804606');
    calculationCubit.fetchSaveCalculations('674c4ea08940a71eee7a1a33');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocConsumer<CalculationCubit, CalculationState>(
          bloc: calculationCubit,
          listener: (context, state) {
            if (state is SaveCalculationLoadingState) {
              const CommonProgressIndicator(
                color: AppColors.primaryBlue,
              );
            }
            if (state is SaveCalculationErrorState) {
              Utils.errorMessage(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is SaveCalculationLoadingState) {
              return const Center(
                child: CommonProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimentions.sizedBox16H,
                Text(
                  AppStrings.savedCalculation,
                  style: TextStyles().textStylesNunito(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.separated(
                  itemCount: (calculationCubit.truckDetailList ?? []).length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TruckDetailModel data = (calculationCubit.truckDetailList ?? [])[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.greyLightWhite),
                      ),
                      child: Row(
                        children: [
                          ImageAssets(
                            image: AssetsPath.shipping,
                            height: 48,
                            width: 48,
                          ),
                          Dimentions.sizedBox22W,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.vehicleName,
                                  style: TextStyles().textStylesMontserrat(
                                    fontSize: 10,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data.truckDetails?.name ?? '',
                                        style: TextStyles().textStylesMontserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      Utils().formattedDate(data.createdAt ?? ''),
                                      style: TextStyles().textStylesMontserrat(
                                        fontSize: 12,
                                        color: AppColors.darkBlackGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppStrings.dimentions,
                                      style: TextStyles().textStylesMontserrat(
                                        fontSize: 12,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        ' ${data.truckDetails?.dimensions?.l ?? ''}'
                                        ' ${'x'} '
                                        '${data.truckDetails?.dimensions?.w ?? ''}'
                                        ' ${'x'} '
                                        '${data.truckDetails?.dimensions?.h ?? ''}'
                                        ' ${'x'} '
                                        'in foot',
                                        style: TextStyles().textStylesMontserrat(
                                          fontSize: 12,
                                          color: AppColors.darkBlackGrey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Dimentions.sizedBox24H;
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
