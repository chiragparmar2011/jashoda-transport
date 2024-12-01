import 'package:dio/dio.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:jashoda_transport/data/services/base_api_service.dart';
import 'package:jashoda_transport/domain/repo/api/api.dart';

class NetworkApiService extends BaseApiService {
  API api = API(AppInterceptor());
  Dio? dio;

  NetworkApiService(Dio dio);

  @override
  Future<Response> get(
      {required String endPoint,
      query,
      Map<String, dynamic>? queryParameters,
      String? token,
      int? timeOut,
      Options? options}) async {
    if (timeOut != null) {
      api.sendRequest.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    return await api.sendRequest.get(
      queryParameters: queryParameters,
      endPoint,
      options: options,
    );
  }

  @override
  Future<Response> post({
    required String endPoint,
    data,
    String? token,
    int? timeOut,
  }) async {
    if (timeOut != null) {
      api.sendRequest.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    return await api.sendRequest.post(
      endPoint,
      data: data,
    );
  }

  @override
  Future<Response> put({
    required String endPoint,
    data,
    String? token,
    int? timeOut,
  }) async {
    if (timeOut != null) {
      api.sendRequest.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    return await api.sendRequest.put(
      endPoint,
      data: data,
    );
  }

  @override
  Future<Response> patch({
    required String endPoint,
    data,
    String? token,
    int? timeOut,
  }) async {
    if (timeOut != null) {
      api.sendRequest.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    return await api.sendRequest.patch(
      endPoint,
      data: data,
    );
  }

  @override
  Future<Response> delete({
    required String endPoint,
    data,
    String? token,
    int? timeOut,
  }) async {
    if (timeOut != null) {
      api.sendRequest.options.connectTimeout = Duration(milliseconds: timeOut);
    }
    return await api.sendRequest.delete(
      endPoint,
      data: data,
    );
  }
}
