import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/model/response_model.dart';
import 'package:jashoda_transport/data/model/user/usermodel.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:jashoda_transport/data/services/network_api_service.dart';
import 'package:jashoda_transport/domain/repo/auth/auth_base_repository.dart';
import 'package:jashoda_transport/getit_injector.dart';

class OtpVerificationResponse {
  final String message;
  final bool isRegistered;

  OtpVerificationResponse({required this.message, required this.isRegistered});
}

class AuthRepositoryImpl extends AuthBaseRepository {
  NetworkApiService networkApiService = NetworkApiService(Dio()..interceptors.add(AppInterceptor()));
  final prefs = injector.get<SharedPreferenceHelper>();

  @override
  Future<String?> sendOTP(Map<String, dynamic> data) async {
    final response = await networkApiService.post(
      endPoint: AppUrl.sendOTP,
      data: data,
    );

    if (response.statusCode == ResponseCode.SUCCESS) {
      return response.data['message'];
    }
    return null;
  }

  @override
  Future<OtpVerificationResponse?> verifyOTP(Map<String, dynamic> data) async {
    final response = await networkApiService.post(
      endPoint: AppUrl.verifyOTP,
      data: data,
    );
    if (response.statusCode == ResponseCode.SUCCESS) {
      return OtpVerificationResponse(
        message: response.data['message'],
        isRegistered: response.data['isRegistered'],
      );
    }
    return null;
  }

  @override
  Future<UserModel?>  register(Map<String, dynamic> data) async {
    final response = await networkApiService.post(
      endPoint: AppUrl.register,
      data: data,
    );
    final result = ResponseDataObjectModel.fromJson(UserModel(), response.data);
    return result.data;
  }

  @override
  Future<UserModel?> updateUser(Map<String,dynamic> data) async {
    final response = await networkApiService.patch(
      endPoint: AppUrl.updateUser,
      data: data
    );

    final result = ResponseDataObjectModel.fromJson(UserModel(), response.data);
    return result.data;
  }
}
