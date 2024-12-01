import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button_with_icon.dart';
import 'package:jashoda_transport/core/widgets/dialog/common_progress_indicator.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/dashboard/home/home_cubit.dart';
import 'package:jashoda_transport/data/model/load/calculation_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/getit_injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit homeCubit = injector<HomeCubit>();

  @override
  void initState() {
    homeCubit.fetchRecentCalculation('6744b9f4a07f02312a804606');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: BlocConsumer<HomeCubit, HomeState>(
          bloc: homeCubit,
          listener: (context, state) {
            if (state is TruckDetailLoadingState) {
              const CommonProgressIndicator(color: AppColors.primaryBlue,);
            }
            if (state is TruckDetailErrorState) {
              Utils.errorMessage(context, state.error);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimentions.sizedBox24H,
                Text(
                  "${AppStrings.welcome} User!",
                  style: TextStyles().textStylesNunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  AppStrings.homeHeader,
                  style: TextStyles().textStylesMontserrat(
                    fontSize: 14,
                  ),
                ),
                const Divider(
                  color: AppColors.greyWhite,
                  thickness: 1,
                ),
                Dimentions.sizedBox16H,
              state is TruckDetailLoadingState  ?
              const Center(
                child: CommonProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              )
             : Expanded(
                  child: (homeCubit.truckDetailList ?? []).isEmpty
                      ? _buildWithOutDetail()
                      : _buildWithDetail(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWithOutDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text(
            AppStrings.homeInitialText,
            style: TextStyles().textStylesMontserrat(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Dimentions.sizedBox24H,
        CustomButtonWithIconWidget(
          height: 64,
          title: AppStrings.startNewCalculation,
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.createCalculationScreen);
          },
          iconWidget: ImageAssets(image: AssetsPath.addWhiteIcon),
        ),
      ],
    );
  }

  Widget _buildWithDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButtonWithIconWidget(
          height: 64,
          title: AppStrings.startNewCalculation,
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.createCalculationScreen);
          },
          iconWidget: ImageAssets(image: AssetsPath.addWhiteIcon),
        ),
        Dimentions.sizedBox24H,
        Text(
          AppStrings.recentCalculation,
          style: TextStyles().textStylesNunito(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: ListView.separated(
            itemCount: (homeCubit.truckDetailList ?? []).length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              TruckDetailModel? data = homeCubit.truckDetailList?[index];
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
                                  data?.truckDetails?.name ?? '',
                                  style: TextStyles().textStylesMontserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                Utils().formattedDate('${data?.createdAt}' ?? ''),
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
                                  ' ${data?.truckDetails?.dimensions?.l ?? ''}'
                                  ' ${'x'} '
                                  '${data?.truckDetails?.dimensions?.w ?? ''}'
                                  ' ${'x'} '
                                  '${data?.truckDetails?.dimensions?.h ?? ''}'
                                  ' ${'x'} '
                                  '${/*data.dimensionType*/ 'in foot'}',
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
          ),
        )
      ],
    );
  }
}
