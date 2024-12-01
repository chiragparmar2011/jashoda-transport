import 'package:dio/dio.dart';
import 'package:jashoda_transport/core/utils/app_url.dart';
import 'package:jashoda_transport/data/services/app_interceptor_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();

  Dio get sendRequest => _dio;

  API(AppInterceptor appInterceptor) {
    _dio.options.baseUrl = AppUrl.baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: 10000);
    _dio.interceptors.add(appInterceptor);
    _dio.interceptors.add(PrettyDioLogger());
  }
}
