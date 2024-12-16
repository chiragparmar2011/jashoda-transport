import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/data/repo_impl/auto_repo_impl/authentication_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.authRepositoryImpl) : super(EditProfileInitial());

  AuthRepositoryImpl authRepositoryImpl;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController industryTypeController = TextEditingController();
  UserModel? userModel;
  String id = '';
  String userName = '';
  String profilePicture = "";
  final prefs = injector<SharedPreferenceHelper>();

  Future<void> fetchUserDetail({required String userId}) async {
    emit(FetchUserDetailLoadingState());
    try {
      UserModel? data = await authRepositoryImpl.fetchUserDetail(userId);
      if (data != null) {
        userModel = data;
      }
      emit(FetchUserDetailSuccessState(data));
    } catch (error) {
      emit(FetchUserDetailErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  Future<void> updateUser({
    required String userId,
    required String name,
    required String companyName,
    required String industryType,
    required String profilePicture,
  }) async {
    emit(EditProfileLoadingState());
    try {
      Map<String, dynamic> requestData = {
        'userId': userId,
        'name': name,
        'companyName': companyName,
        'industryType': industryType,
        'profilePicture': profilePicture,
      };
      final data = await authRepositoryImpl.updateUser(requestData);
      prefs.setUser(data);
      emit(EditProfileSuccessState(data));
    } catch (error) {
      emit(EditProfileErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final File file = File(image.path);
        final bytes = await file.readAsBytes();

        final String extension = image.path.split('.').last.toLowerCase();
        final String mimeType = extension == 'jpg' || extension == 'jpeg'
            ? 'image/jpeg'
            : extension == 'png'
                ? 'image/png'
                : 'image';

        profilePicture = "data:$mimeType;base64,${base64Encode(bytes)}";
        emit(EditProfileInitial());
      }
    } catch (error) {
      emit(EditProfileErrorState("Failed to pick image: ${error.toString()}"));
    }
  }
}
