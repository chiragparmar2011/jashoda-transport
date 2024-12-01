import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:jashoda_transport/cubit/auth/inputNumber/input_mo_number_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';

class EnterMoNumberScreen extends StatelessWidget {
  EnterMoNumberScreen({super.key});

  final EnterMoNumberCubit enterMoNumberCubit = injector<EnterMoNumberCubit>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: BlocConsumer<EnterMoNumberCubit, EnterMoNumberState>(
                  bloc: enterMoNumberCubit,
                  listener: (context, state) {
                    if (state is OTPSuccessState) {
                      Utils.successMessage(context, state.message);
                      Navigator.pushNamed(
                        context,
                        MyRoutes.otpVerificationScreen,
                        arguments: {
                          'phoneNumber':
                              enterMoNumberCubit.enterMoNumberController.text,
                        },
                      ).then((value) {
                        enterMoNumberCubit.enterMoNumberController.clear();
                      });
                    }
                    if (state is OTPFailedState) {
                      Utils.errorMessage(context, state.error ?? '');
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: enterMoNumberCubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Dimentions.sizedBox24H,
                          BackArrowWidget(
                            onTap: () {
                              SystemNavigator.pop();
                            },
                          ),
                          Dimentions.sizedBox16H,
                          Center(
                            child: ImageAssets(
                              image: AssetsPath.avtar,
                              height: 240,
                              width: 240,
                            ),
                          ),
                          Text(
                            AppStrings.enterNumberText,
                            style: TextStyles().textStylesNunito(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Dimentions.sizedBox8H,
                          Text(
                            AppStrings.instructionMobileNoText,
                            style: TextStyles().textStylesMontserrat(
                              fontSize: 12,
                            ),
                          ),
                          Dimentions.sizedBox24H,
                          CommonTextField(
                            controller:
                                enterMoNumberCubit.enterMoNumberController,
                            hintText: AppStrings.enterNumberText,
                            hintFontSize: 16,
                            validator: (value) {
                              return Utils().numberValidator(value ?? '');
                            },
                            keyboardType: TextInputType.number,
                            prefixIconButton: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text('+91 ')),
                          ),
                          Dimentions.sizedBox24H,
                          CustomButtonWidget(
                            title: AppStrings.sendOTP,
                            onPressed: () {
                              if (enterMoNumberCubit.formKey.currentState!
                                  .validate()) {
                                enterMoNumberCubit.sendOtp(
                                  phoneNumber: enterMoNumberCubit
                                      .enterMoNumberController.text,
                                );
                              }
                            },
                            isLoading: state is OTPLoadingState ? true : false,
                          ),
                          const Spacer(),
                          Center(
                            child: Text(
                              'By continuing you agree with',
                              style: TextStyles().textStylesMontserrat(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyles().textStylesMontserrat(
                                  fontSize: 12,
                                  color: AppColors.primaryBlue,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' & ',
                                    style: TextStyles().textStylesMontserrat(
                                      fontSize: 12,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and conditions.',
                                    style: TextStyles().textStylesMontserrat(
                                      fontSize: 12,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
