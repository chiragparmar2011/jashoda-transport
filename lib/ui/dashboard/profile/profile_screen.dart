import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/ui/dashboard/profile/widget/profile_section_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimentions.sizedBox24H,
            Text(
              "${AppStrings.hey} User!",
              style: TextStyles().textStylesNunito(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Dimentions.sizedBox24H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.personIcon,
              title: AppStrings.editProfile,
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.editProfileScreen);
              },
            ),
            Dimentions.sizedBox16H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.subscriptionIcon,
              title: AppStrings.yourSubscription,
              onTap: () {},
            ),
            Dimentions.sizedBox16H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.settingsIcon,
              title: AppStrings.settings,
              onTap: () {},
            ),
            Dimentions.sizedBox16H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.helpSupportIcon,
              title: AppStrings.helpAndSupport,
              onTap: () {},
            ),
            Dimentions.sizedBox16H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.termsConditionIcon,
              title: AppStrings.termsAndCondition,
              onTap: () {},
            ),
            Dimentions.sizedBox16H,
            ProfileSectionWidget(
              avtarImage: AssetsPath.privacyPolicyIcon,
              title: AppStrings.privacyPolicy,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
