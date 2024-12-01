import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController industryTypeController = TextEditingController();
  UserModel? userModel;
}
