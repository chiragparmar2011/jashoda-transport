import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/utils/dimentions.dart';
import 'package:jashoda_transport/core/utils/text_styles.dart';
import 'package:jashoda_transport/core/utils/utils.dart';
import 'package:jashoda_transport/core/widgets/buttons/back_arrow.dart';
import 'package:jashoda_transport/core/widgets/buttons/common_button.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/core/widgets/textformfield/common_textfield.dart';
import 'package:jashoda_transport/cubit/auth/registration/registration_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/auth/register/widget/company_name_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/email_address_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/full_name_widget.dart';
import 'package:jashoda_transport/ui/auth/register/widget/industry_type_widget.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final RegistrationCubit registrationCubit = injector<RegistrationCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
              child: BlocConsumer<RegistrationCubit, RegistrationState>(
                bloc: registrationCubit,
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    Navigator.pushNamed(context, MyRoutes.dashboardScreen);
                  }
                  if (state is RegisterFailedState) {
                    Utils.errorMessage(context, state.error ?? '');
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: registrationCubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Dimentions.sizedBox24H,
                        BackArrowWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Dimentions.sizedBox16H,
                        Text(
                          AppStrings.registerYourSelf,
                          style: TextStyles().textStylesNunito(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        Dimentions.sizedBox4H,
                        Text(
                          AppStrings.registerContent,
                          style: TextStyles().textStylesMontserrat(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Dimentions.sizedBox32H,
                        FullNameWidget(
                          controller: registrationCubit.fullNameController,
                        ),
                        Dimentions.sizedBox24H,
                        EmailAddressWidget(
                          controller: registrationCubit.emailAddController,
                        ),
                        Dimentions.sizedBox24H,
                        CompanyNameWidget(
                          controller: registrationCubit.companyNameController,
                        ),
                        Dimentions.sizedBox24H,
                        IndustryTypeWidget(
                          controller: registrationCubit.industryTypeController,
                        ),
                        const Spacer(),
                        CustomButtonWidget(
                          title: AppStrings.registerNow,
                          onPressed: () {
                            // if (registrationCubit.formKey.currentState!.validate()) {
                            //   registrationCubit.registerUser(
                            //     name: registrationCubit.fullNameController.text,
                            //     email:
                            //         registrationCubit.emailAddController.text,
                            //     companyName: registrationCubit
                            //         .companyNameController.text,
                            //     industryType: registrationCubit
                            //         .industryTypeController.text,
                            //   );
                            // }
                            Navigator.pushNamed(context, MyRoutes.dashboardScreen);
                          },
                          isLoading: state is RegisterLoadingState ? true : false,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
