import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/routes/app_routes.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';

part 'input_mo_number_state.dart';

class EnterMoNumberCubit extends Cubit<EnterMoNumberState> {
  EnterMoNumberCubit(this.authRepositoryImpl) : super(EnterMoNumberInitial());

  AuthRepositoryImpl authRepositoryImpl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController enterMoNumberController = TextEditingController();

  Future<void> sendOtp({required String phoneNumber}) async {
    emit(OTPLoadingState());
    try {
      Map<String, String> requestData = {
        'countryCode': AppStrings.countryCode,
        'phoneNumber': phoneNumber,
      };
      final data = await authRepositoryImpl.sendOTP(requestData);
      emit(OTPSuccessState(data.toString()));
    } catch (error) {
      emit(OTPFailedState(ErrorHandler.handle(error).failure.message));
    }
  }

  void navigateToOTPVerificationScreen(BuildContext context) {
    Navigator.pushNamed(context, MyRoutes.otpVerificationScreen);
  }
}
