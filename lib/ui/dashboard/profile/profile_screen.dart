import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/dialog/confirmation_dialog.dart';
import 'package:jashoda_transport/cubit/dashboard/profile/editprofile/edit_profile_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/dashboard/profile/widget/profile_section_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final EditProfileCubit cubit = injector<EditProfileCubit>();

  @override
  void initState() {
    cubit.fetchUserDetail(userId: cubit.prefs.getString('id'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: SingleChildScrollView(
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is FetchUserDetailSuccessState) {
                cubit.userModel = state.userModel;
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimentions.sizedBox24H,
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: AppStrings.hey,
                      style: TextStyles().textStylesNunito(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: cubit.userModel?.name,
                          style: TextStyles().textStylesNunito(
                            fontSize: 24,
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
                    onTap: () async {
                      final isUpdated = await Navigator.pushNamed(
                        context,
                        MyRoutes.editProfileScreen,
                        arguments: {
                          'userModel': cubit.userModel,
                        },
                      );

                      if (isUpdated == true) {
                        cubit.fetchUserDetail(
                          userId: cubit.prefs.getString('id'),
                        );
                      }
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
                    onTap: () async {
                      showLogoutDialog(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        confirmationTitle: AppStrings.logOutContent,
        confirmText: AppStrings.logout,
        cancelText: AppStrings.cancel,
        confirmOnPressed: () async {
          await cubit.prefs.clear();
          if (context.mounted) {
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              MyRoutes.inputMoNumberScreen,
              (Route<dynamic> route) => false,
            );
          }
        },
        cancelOnPressed: () {
          Navigator.of(context).pop();
        },
        bgColor: AppColors.red,
      ),
    );
  }
}
