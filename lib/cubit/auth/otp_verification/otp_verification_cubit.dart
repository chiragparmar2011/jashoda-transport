import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit(this.authRepositoryImpl) : super(OtpVerificationInitial());

  AuthRepositoryImpl authRepositoryImpl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpVerificationController = TextEditingController();
  final prefs = injector<SharedPreferenceHelper>();

  Timer? _resendOtpTimer;
  int remainingTime = 30;
  bool canResendOtp = false;

  void startResendOtpTimer() {
    remainingTime = 30;
    canResendOtp = false;
    emit(OtpVerificationTimerState(remainingTime, canResendOtp));

    _resendOtpTimer?.cancel();
    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        emit(OtpVerificationTimerState(remainingTime, canResendOtp));
      } else {
        timer.cancel();
        canResendOtp = true;
        emit(OtpVerificationTimerState(0, canResendOtp));
      }
    });
  }

  Future<void> resendOtp(String phoneNumber) async {
    try {
      emit(ResendOtpLoadingState());
      Map<String, String> requestData = {
        'countryCode': AppStrings.countryCode,
        'phoneNumber': phoneNumber,
      };

      await authRepositoryImpl.sendOTP(requestData);
      startResendOtpTimer();
      emit(OtpVerificationInitial());
    } catch (error) {
      emit(OtpVerificationErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  Future<void> verifyOTP({required String phoneNumber, required String otp}) async {
    try {
      emit(OtpVerificationLoadingState());
      Map<String, String> requestData = {
        'countryCode': AppStrings.countryCode,
        'phoneNumber': phoneNumber,
        'otp': otp,
      };
      final data = await authRepositoryImpl.verifyOTP(requestData);
      prefs.setString(key: 'id', value: data?.userId ?? '');
      prefs.setBool(key: 'isLoggedId', value: true);
      if (data != null) {
        emit(OtpVerificationSuccessState(data.message, data.isRegistered));
      }
    } catch (error) {
      emit(OtpVerificationErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  @override
  Future<void> close() {
    _resendOtpTimer?.cancel();
    return super.close();
  }
}
