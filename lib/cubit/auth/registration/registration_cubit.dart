import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit(this.authRepositoryImpl) : super(RegistrationInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthRepositoryImpl authRepositoryImpl;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController industryTypeController = TextEditingController();
  final prefs = injector<SharedPreferenceHelper>();

  Future<void> registerUser({
    required String name,
    required String email,
    required String companyName,
    required String industryType,
  }) async {
    try {
      emit(RegisterLoadingState());
      Map<String, String> requestData = {
        'name': email,
        'email': email,
        'companyName': companyName,
        'industryType': industryType,
        'phoneNumber':prefs.getString('phoneNumber').toString()
      };
      UserModel? data = await authRepositoryImpl.register(requestData);
      print("id register==>${data?.sId}");
      prefs.setString(key: "id", value: data?.sId ?? '');
      prefs.setUser(data);
      emit(RegisterSuccessState(data));
    } catch (error) {
      emit(RegisterFailedState(ErrorHandler.handle(error).failure.message));
    }
  }
}
