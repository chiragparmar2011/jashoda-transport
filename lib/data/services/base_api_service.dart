import 'package:dio/dio.dart';

abstract class BaseApiService {
  Future<Response> post({
    required String endPoint,
    dynamic data,
    String? token,
    int? timeOut,
  });

  Future<Response> get({
    Map<String, dynamic>? queryParameters,
    required String endPoint,
    dynamic query,
    String? token,
    int? timeOut,
  });

  Future<Response> put({
    required String endPoint,
    dynamic data,
    String? token,
    int? timeOut,
  });

  Future<Response> delete({
    required String endPoint,
    dynamic data,
    String? token,
    int? timeOut,
  });

}
