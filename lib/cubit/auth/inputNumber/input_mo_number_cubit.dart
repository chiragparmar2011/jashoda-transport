import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';

part 'input_mo_number_state.dart';

class EnterMoNumberCubit extends Cubit<EnterMoNumberState> {
  EnterMoNumberCubit(this.authRepositoryImpl) : super(EnterMoNumberInitial());

  AuthRepositoryImpl authRepositoryImpl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController enterMoNumberController = TextEditingController();
  final prefs = injector<SharedPreferenceHelper>();

  Future<void> sendOtp({required String phoneNumber}) async {
    emit(OTPLoadingState());
    try {
      Map<String, String> requestData = {
        'countryCode': AppStrings.countryCode,
        'phoneNumber': phoneNumber,
      };

      final data = await authRepositoryImpl.sendOTP(requestData);
      prefs.setString(key: "phoneNumber", value: phoneNumber.toString());
      emit(OTPSuccessState(data.toString()));
    } catch (error) {
      emit(OTPFailedState(ErrorHandler.handle(error).failure.message));
    }
  }

  void navigateToOTPVerificationScreen(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.otpVerificationScreen);
  }
}
