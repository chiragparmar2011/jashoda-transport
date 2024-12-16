import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/back_arrow.dart';
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
  final EditProfileCubit editProfileCubit = injector<EditProfileCubit>();
  final _prefs = injector.get<SharedPreferenceHelper>();

  @override
  void initState() {
    editProfileCubit.id = _prefs.getString('id');
    _initializeUserDetails();
    super.initState();
  }

  Future<void> _initializeUserDetails() async {
    await editProfileCubit.fetchUserDetail(userId: editProfileCubit.id);
    editProfileCubit.fullNameController.text =
        editProfileCubit.userModel?.name ?? '';
    editProfileCubit.emailAddController.text =
        editProfileCubit.userModel?.email ?? '';
    editProfileCubit.companyNameController.text =
        editProfileCubit.userModel?.companyName ?? '';
    editProfileCubit.industryTypeController.text =
        editProfileCubit.userModel?.industryType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            bloc: editProfileCubit,
            listener: (context, state) {
              if (state is EditProfileSuccessState) {
                Navigator.of(context).pop();
              }
              if (state is EditProfileErrorState) {
                Utils.errorMessage(context, state.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: editProfileCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimentions.sizedBox24H,
                    BackArrowWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Dimentions.sizedBox16H,
                    Text(
                      AppStrings.yourProfile,
                      style: TextStyles().textStylesNunito(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Dimentions.sizedBox24H,
                    GestureDetector(
                      onTap: () async {
                        await editProfileCubit.pickImage();
                      },
                      child: Center(
                        child: editProfileCubit.profilePicture.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(
                                  base64Decode(editProfileCubit.profilePicture
                                      .split(',')[1]),
                                ),
                                radius: 84,
                              )
                            : ImageAssets(
                                image: AssetsPath.addAvtarIcon,
                                height: 168,
                                width: 168,
                              ),
                      ),
                    ),
                    Dimentions.sizedBox32H,
                    FullNameWidget(
                      controller: editProfileCubit.fullNameController,
                    ),
                    Dimentions.sizedBox24H,
                    EmailAddressWidget(
                      controller: editProfileCubit.emailAddController,
                      readOnly: true,
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
                            onPressed: () {
                              if (editProfileCubit.formKey.currentState!.validate()) {
                                editProfileCubit.updateUser(
                                  userId: editProfileCubit.id,
                                  name: editProfileCubit.fullNameController.text,
                                  companyName: editProfileCubit.companyNameController.text,
                                  industryType: editProfileCubit.industryTypeController.text,
                                  profilePicture: editProfileCubit.profilePicture.isNotEmpty
                                      ? editProfileCubit.profilePicture
                                      : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/wQAAwEB/atfz7AAAAAASUVORK5CYII=',
                                );
                              }
                            },
                            isLoading: state is EditProfileLoadingState ? true : false,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
