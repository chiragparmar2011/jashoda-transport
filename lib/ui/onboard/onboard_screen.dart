import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/cubit/onboard/onboard_cubit.dart';
import 'package:jashoda_transport/ui/onboard/widget/onboard_widget.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final OnboardCubit onboardCubit = OnboardCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardCubit, OnboardState>(
        bloc: onboardCubit,
        builder: (context, state) {
          return Stack(
            children: [
              PageView.builder(
                controller: onboardCubit.pageController,
                onPageChanged: (index) {
                  onboardCubit.updatePageIndicator(index);
                },
                itemCount: onboardCubit.pageCount,
                itemBuilder: (context, index) {
                  return OnboardWidget(
                    pageController: onboardCubit.pageController,
                    assetsImage: onboardCubit.getAssetsImage(index),
                    headerText: onboardCubit.getHeaderText(index),
                    contentText: onboardCubit.getContentText(index),
                    skipText: AppStrings.skip,
                    showSkipButton: index == 0,
                    btnText: index == 3 ? AppStrings.getStarted : AppStrings.next,
                    onPressed: () {
                      if (index < onboardCubit.pageCount - 1) {
                        onboardCubit.nextPage();
                      } else {
                        onboardCubit.navigateToMobileNumberScreen(context);
                      }
                    },
                    showBackButton: index > 0 ? true : false,
                    onBackPressed: onboardCubit.previousPage,
                    onDotClicked: (index) {
                      onboardCubit.dotNavigationClick(index);
                    },
                    pageCount: onboardCubit.pageCount,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
