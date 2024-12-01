import 'package:flutter/material.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/widgets/buttons/cancle_button.dart';
import 'package:jashoda_transport/core/widgets/buttons/confirmation_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/dashboard/profile/editprofile/edit_profile_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/auth/register/widget/company_name_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/email_address_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/full_name_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/industry_type_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileCubit editProfileCubit = EditProfileCubit();
  final _prefs = injector.get<SharedPreferenceHelper>();

  @override
  void initState() {
    editProfileCubit.userModel = _prefs.getUser();
    editProfileCubit.fullNameController.text = editProfileCubit.userModel?.name ?? '';
    editProfileCubit.emailAddController.text = editProfileCubit.userModel?.email ?? '';
    editProfileCubit.companyNameController.text = editProfileCubit.userModel?.companyName ?? '';
    editProfileCubit.industryTypeController.text = editProfileCubit.userModel?.industryType ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimentions.sizedBox24H,
              Text(
                AppStrings.yourProfile,
                style: TextStyles().textStylesNunito(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Dimentions.sizedBox24H,
              Center(
                child: ImageAssets(
                  image: AssetsPath.addAvtarIcon,
                  height: 168,
                  width: 168,
                ),
              ),
              Dimentions.sizedBox32H,
              FullNameWidget(
                controller: editProfileCubit.fullNameController,
              ),
              Dimentions.sizedBox24H,
              EmailAddressWidget(
                controller: editProfileCubit.emailAddController,
              ),
              Dimentions.sizedBox24H,
              CompanyNameWidget(
                controller: editProfileCubit.companyNameController,
              ),
              Dimentions.sizedBox24H,
              IndustryTypeWidget(
                controller: editProfileCubit.industryTypeController,
              ),
              Dimentions.sizedBox32H,
              Row(
                children: [
                  Flexible(
                    child: CancelButton(
                      width: 174,
                      title: AppStrings.cancel,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Dimentions.sizedBox16W,
                  Flexible(
                    child: ConfirmationButton(
                      width: 174,
                      title: AppStrings.save,
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
