import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/dashboard/profile/widget/profile_section_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  final prefs = injector.get<SharedPreferenceHelper>();

  @override
  void initState() {
    userName = prefs.getUser()?.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimentions.sizedBox24H,
              RichText(
                text: TextSpan(
                  text: AppStrings.hey,
                  style: TextStyles().textStylesNunito(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: userName,
                      style: TextStyles().textStylesNunito(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
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
              Dimentions.sizedBox16H,
              ProfileSectionWidget(
                avtarImage: AssetsPath.logOutIcon,
                title: AppStrings.logout,
                onTap: () {
                  context.read<BottomNavCubit>().updateNavItem(BottomNavItem.home);
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                    MyRoutes.inputMoNumberScreen,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
