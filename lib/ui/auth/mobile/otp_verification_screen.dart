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
import 'package:jashoda_transport/cubit/auth/otp_verification/otp_verification_cubit.dart';
import 'package:jashoda_transport/getit_injector.dart';
import 'package:jashoda_transport/ui/auth/mobile/widget/custom_code_field.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({required this.phoneNumber, super.key});

  final String phoneNumber;
  final OtpVerificationCubit otpVerificationCubit = injector<OtpVerificationCubit>();

  @override
  Widget build(BuildContext context) {
    otpVerificationCubit.startResendOtpTimer();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocConsumer<OtpVerificationCubit, OtpVerificationState>(
            bloc: otpVerificationCubit,
            listener: (context, state) {
              if (state is OtpVerificationSuccessState) {
                Utils.successMessage(context, state.message);
                if (state.isRegistered) {
                  Navigator.pushNamed(context, MyRoutes.dashboardScreen);
                } else {
                  Navigator.pushNamed(context, MyRoutes.registrationScreen)
                      .then((value) {
                    otpVerificationCubit.otpVerificationController.clear();
                  });
                }
              }
              if (state is OtpVerificationErrorState) {
                Utils.errorMessage(context, state.error ?? '');
              }
            },
            builder: (context, state) {
              int timerValue = 30;
              bool showResendOtp = false;

              if (state is OtpVerificationTimerState) {
                timerValue = state.remainingTime;
                showResendOtp = state.canResendOtp;
              }
              return Form(
                key: otpVerificationCubit.formKey,
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
                    Center(
                      child: ImageAssets(
                        image: AssetsPath.mobileTwo,
                        height: 240,
                        width: 240,
                      ),
                    ),
                    Dimentions.sizedBox0H,
                    Text(
                      AppStrings.enterOTP,
                      style: TextStyles().textStylesNunito(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Dimentions.sizedBox8H,
                    Text(
                      '${AppStrings.otpSent}$phoneNumber.',
                      style: TextStyles().textStylesMontserrat(
                        fontSize: 12,
                      ),
                    ),
                    Dimentions.sizedBox24H,
                    CustomCodeField(
                      controller:
                          otpVerificationCubit.otpVerificationController,
                      validator: (String? value) {
                        return Utils().requiredValidator(value ?? '');
                      },
                    ),
                    Dimentions.sizedBox24H,
                    CustomButtonWidget(
                      title: AppStrings.verifyOTP,
                      onPressed: () {
                        if (otpVerificationCubit.formKey.currentState!.validate()) {
                          otpVerificationCubit.verifyOTP(
                            phoneNumber: phoneNumber,
                            otp: otpVerificationCubit.otpVerificationController.text,
                          );
                        }
                      },
                      isLoading:
                          state is OtpVerificationLoadingState ? true : false,
                    ),
                    Dimentions.sizedBox16H,
                    if (!showResendOtp)
                      Text(
                        "$timerValue ${AppStrings.seconds}",
                        style: TextStyles().textStylesMontserrat(
                          fontSize: 16,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    if (showResendOtp)
                      GestureDetector(
                        onTap: () {
                          otpVerificationCubit.resendOtp(phoneNumber);
                        },
                        child: Text(
                          AppStrings.resendOTP,
                          style: TextStyles().textStylesMontserrat(
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                            decoration: TextDecoration.underline,
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
    );
  }
}
