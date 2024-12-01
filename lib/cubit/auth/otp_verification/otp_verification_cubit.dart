import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit(this.authRepositoryImpl) : super(OtpVerificationInitial());

  AuthRepositoryImpl authRepositoryImpl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpVerificationController = TextEditingController();

  Future<void> verifyOTP({required String phoneNumber, required String otp}) async {
    try {
      emit(OtpVerificationLoadingState());
      Map<String, String> requestData = {
        'countryCode': AppStrings.countryCode,
        'phoneNumber': phoneNumber,
        'otp': otp,
      };
      final data = await authRepositoryImpl.verifyOTP(requestData);
      if (data != null) {
        emit(OtpVerificationSuccessState(data.message, data.isRegistered));
      }
    } catch (error) {
      emit(OtpVerificationErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  void navigateToRegistrationScreen(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.registrationScreen);
  }
}
