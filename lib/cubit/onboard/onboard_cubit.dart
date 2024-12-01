import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';

part 'onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  OnboardCubit() : super(OnboardInitial());

  final PageController pageController = PageController();
  final int pageCount = 4;
  int currentPageIndex = 0;

  void updatePageIndicator(int index) {
    currentPageIndex = index;
    emit(HideOnboardingIndicator(index));
  }

  void dotNavigationClick(int index) {
    currentPageIndex = index;
    pageController.jumpToPage(index);
    emit(OnboardInitial());
  }

  void nextPage() {
    if (currentPageIndex < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPageIndex++;
      emit(OnboardInitial());
    }
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPageIndex--;
      emit(OnboardInitial());
    }
  }

  void navigateToMobileNumberScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, MyRoutes.inputMoNumberScreen);
  }

  String getAssetsImage(int index) {
    switch (index) {
      case 0:
        return AssetsPath.shipping;
      case 1:
        return AssetsPath.calculator;
      case 2:
        return AssetsPath.shipping;
      case 3:
        return AssetsPath.time;
      default:
        return '';
    }
  }

  String getHeaderText(int index) {
    switch (index) {
      case 0:
        return AppStrings.onBoardHeaderOne;
      case 1:
        return AppStrings.onBoardHeaderTwo;
      case 2:
        return AppStrings.onBoardHeaderThree;
      case 3:
        return AppStrings.onBoardHeaderFour;
      default:
        return '';
    }
  }

  String getContentText(int index) {
    switch (index) {
      case 0:
        return AppStrings.onBoardContentOne;
      case 1:
        return AppStrings.onBoardContentTwo;
      case 2:
        return AppStrings.onBoardContentThree;
      case 3:
        return AppStrings.onBoardContentFour;
      default:
        return '';
    }
  }
}
