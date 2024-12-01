import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/back_arrow.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/onboard/onboard_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//ignore: must_be_immutable
class OnboardWidget extends StatelessWidget {
  const OnboardWidget({
    required this.assetsImage,
    required this.headerText,
    required this.contentText,
    required this.skipText,
    required this.btnText,
    required this.onPressed,
    this.showBackButton = false,
    this.showSkipButton = false,
    this.onBackPressed,
    required this.onDotClicked,
    required this.pageCount,
    required this.pageController,
    super.key,
  });

  final String assetsImage;
  final String headerText;
  final String contentText;
  final String skipText;
  final String btnText;
  final VoidCallback onPressed;
  final bool showBackButton;
  final bool showSkipButton;
  final VoidCallback? onBackPressed;
  final void Function(int)? onDotClicked;
  final int pageCount;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Dimentions.sizedBox64H,
            if (showBackButton)
              BackArrowWidget(
                onTap: onBackPressed,
              ),
            ImageAssets(
              image: assetsImage,
              height: 364,
              width: 364,
            ),
            _buildPageIndicator(context),
            Dimentions.sizedBox24H,
            Text(
              headerText,
              style: TextStyles().textStylesNunito(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Dimentions.sizedBox12H,
            Text(
              contentText,
              style: TextStyles().textStylesMontserrat(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            CustomButtonWidget(
              title: btnText,
              onPressed: onPressed,
              isLoading: false,
            ),
            Dimentions.sizedBox24H,
            if (showSkipButton)
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.inputMoNumberScreen);
                },
                child: Text(
                  AppStrings.skip,
                  style: TextStyles().textStylesMontserrat(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }



  Widget _buildPageIndicator(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      onDotClicked: onDotClicked,
      count: pageCount,
      effect: const ExpandingDotsEffect(
        activeDotColor: AppColors.primaryBlue,
        dotHeight: 12,
        spacing: 12,
        dotWidth: 12,
        radius: 50,
        dotColor: AppColors.primaryBlueExtraLight,
      ),
    );
  }
}
